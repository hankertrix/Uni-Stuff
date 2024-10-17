// The module for all the bluetooth related functions

import { useMemo, useState } from "react";
import { PermissionsAndroid, Platform } from "react-native";
import {
  BleError,
  BleManager,
  Characteristic,
  Device,
} from "react-native-ble-plx";
import { Buffer } from "buffer";

import * as ExpoDevice from "expo-device";

// The UUID for the cone layer console service
const CONE_LAYER_UUID = "0000FFE0-0000-1000-8000-00805F9B34FB";

// The characteristic for the cone layer console service
const CONE_LAYER_CHARACTERISTIC = "0000FFE1-0000-1000-8000-00805F9B34FB";

// The device name for the cone layer
const CONE_LAYER_DEVICE_NAME = "BT05";

// The type of the scan for devices function
export type ScanForDevices = () => Promise<boolean>;

// The type of the connect to device function
export type ConnectToDevice = (device: Device) => Promise<boolean>;

// The type of the send string to device function
export type SendStringToDevice = (
  device: Device | null,
  str: string,
) => Promise<boolean>;

// The type of the disconnect from device function
export type DisconnectFromDevice = () => Promise<void>;

// The type of all devices
export type AllDevices = Device[];

// The type of the bluetooth device
export type BluetoothDevice = Device;

// The interface for the bluetooth device
interface BluetoothLowEnergyApi {
  requestPermissions(): Promise<boolean>;
  scanForPeripherals(): void;
  scanForDevices: ScanForDevices;
  connectToDevice: ConnectToDevice;
  startStreamingData: (device: Device | null) => void;
  sendStringToDevice: SendStringToDevice;
  disconnectFromDevice: DisconnectFromDevice;
  allDevices: AllDevices;
  connectedDevice: BluetoothDevice | null;
  coneLayerConsoleData: string;
}

// The function to use bluetooth low energy
function useBluetoothLowEnergy(): BluetoothLowEnergyApi {
  //

  // Initialise the bluetooth low energy manager
  const bleManager = useMemo(() => new BleManager(), []);

  // Initialise the state for the bluetooth devices
  const [allDevices, setAllDevices] = useState<Device[]>([]);

  // Initialise the state for the connected device
  const [connectedDevice, setConnectedDevice] = useState<Device | null>(null);

  // Initialise the state for the console data from the cone layer
  const [coneLayerConsoleData, setConeLayerConsoleData] = useState<string>("");

  // The function to request permissions
  // for Android platform version 31 and above
  async function requestAndroid31Permissions() {
    //

    // Request for the permission to scan bluetooth devices
    const bluetoothScanPermission = await PermissionsAndroid.request(
      PermissionsAndroid.PERMISSIONS.BLUETOOTH_SCAN,
      {
        title: "Bluetooth Scan Permission",
        message: "The app needs to scan for bluetooth devices",
        buttonPositive: "Ok",
      },
    );

    // Request for the permission to connect to bluetooth devices
    const bluetoothConnectPermission = await PermissionsAndroid.request(
      PermissionsAndroid.PERMISSIONS.BLUETOOTH_CONNECT,
      {
        title: "Bluetooth Connect Permission",
        message: "The app needs to connect to bluetooth devices",
        buttonPositive: "Ok",
      },
    );

    // Request for the bluetooth fine location permission
    const bluetoothFineLocationPermission = await PermissionsAndroid.request(
      PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION,
      {
        title: "Bluetooth Fine Location Permission",
        message:
          "The app needs fine location to work with bluetooth low energy",
        buttonPositive: "Ok",
      },
    );

    // Return if the permissions are granted
    return (
      bluetoothScanPermission === "granted" &&
      bluetoothConnectPermission === "granted" &&
      bluetoothFineLocationPermission === "granted"
    );
  }

  // The function to request permissions
  // for Android platform version below 31
  // and the iOS platform
  async function requestPermissions() {
    //

    // If the platform is Android
    if (Platform.OS === "android") {
      //

      // Check if the platform API level is less than 31
      if ((ExpoDevice.platformApiLevel ?? -1) < 31) {
        //

        // Request for the fine location permission
        const bluetoothFineLocationPermission =
          await PermissionsAndroid.request(
            PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION,
            {
              title: "Bluetooth Fine Location Permission",
              message: "Bluetooth low energy requires fine location",
              buttonPositive: "OK",
            },
          );

        // Return if the permissions are granted
        return bluetoothFineLocationPermission === "granted";
      }

      // Otherwise, the android platform API level is 31 and above
      else {
        //

        // Use the function to ask for permissions
        // on Android platform level 31 and above
        const android31PermissionsGranted = await requestAndroid31Permissions();

        // Return if the permissions are granted
        return android31PermissionsGranted;
      }
    }

    // Otherwise, the platform is iOS
    // so just return true as iOS
    // will automatically ask for the permissions at start up
    else return true;
  }

  // The function to check whether a device is a duplicate
  function isDuplicateDevice(devices: Device[], deviceToCheck: Device) {
    return devices.findIndex((device) => deviceToCheck.id === device.id) > -1;
  }

  // The function to scan for peripherals
  function scanForPeripherals() {
    //

    // Start scanning for devices
    bleManager.startDeviceScan(null, null, (error, device) => {
      //

      // If there is an error, log the error and exit the function
      if (error) return console.error(error);

      // Otherwise, if the device exists and is the cone layer
      if (device && device.name?.includes(CONE_LAYER_DEVICE_NAME)) {
        //

        // Set the device array to add the new device
        setAllDevices((existingDevices) => {
          //

          // If the device is not a duplicate
          // then add it to the array
          if (!isDuplicateDevice(existingDevices, device)) {
            return [...existingDevices, device];
          }

          // Otherwise, the device is a duplicate,
          // so return the existing devices
          else return existingDevices;
        });
      }
    });
  }

  // The function to scan for devices
  const scanForDevices: ScanForDevices = async () => {
    //

    // Request for permissions
    const permissionsRequestSuccess = await requestPermissions();

    console.log(
      `Permissions ${permissionsRequestSuccess ? "granted" : "denied"}`,
    );

    // If the permissions request was not successful, return false
    if (!permissionsRequestSuccess) return false;

    // Otherwise, scan for peripherals
    scanForPeripherals();

    console.log("Started scanning for bluetooth devices");

    // Return true
    return true;
  };

  // The function to connect to a device
  const connectToDevice: ConnectToDevice = async (device) => {
    //

    // Try block to catch any errors
    try {
      //

      // Connect to the device using the bluetooth manager
      const deviceConnection = await bleManager.connectToDevice(device.id);

      // Set the connected device to the device
      setConnectedDevice(deviceConnection);

      // Discover all the services and characteristics for the device.
      // This line of code is required, otherwise nothing can be
      // sent to the device.
      await deviceConnection.discoverAllServicesAndCharacteristics();

      // Stop the device scan
      bleManager.stopDeviceScan();

      // Return that the connection was successful
      return true;
    } catch (error) {
      //

      // Catch any errors and log them
      console.error("Error in connection: ", error);

      // Return that the connection was unsuccessful
      return false;
    }
  };

  // The function to get handle the console data stream from the cone layer
  function onConeLayerConsoleDataUpdate(
    error: BleError | null,
    characteristic: Characteristic | null,
  ) {
    //

    // If there is an error, log the error and exit the function
    if (error) return console.error(error);
    //
    // Otherwise, if there is no value in the characteristic,
    // log that there's no data received and exit the function
    else if (!characteristic?.value) return console.log("No data received");

    // Otherwise, get the data from the characteristic
    const consoleData = characteristic.value.toString();

    // Append the data to the cone layer console data
    setConeLayerConsoleData(
      (existingConsoleData) => existingConsoleData + consoleData,
    );
  }

  // The function to start streaming data from the device
  function startStreamingData(device: Device | null) {
    //

    // If the device doesn't exist, exit the function
    if (!device) return;

    // Monitor the console characteristic for the data
    // from the cone layer
    device.monitorCharacteristicForService(
      CONE_LAYER_UUID,
      CONE_LAYER_CHARACTERISTIC,
      onConeLayerConsoleDataUpdate,
    );
  }

  // The function to send a string to the device
  async function sendStringToDevice(
    device: Device | null,
    str: string,
  ): Promise<boolean> {
    //

    // If the device doesn't exist, exit the function
    if (!device) return false;

    // Trim the string
    str = str.trim();

    // Add the new line character to the string
    str += "\n";

    // Convert the hexadecimal string to base64
    const base64String = Buffer.from(str).toString("base64");

    // Try to write the string to the device
    try {
      await bleManager.writeCharacteristicWithoutResponseForDevice(
        device.id ?? "",
        CONE_LAYER_UUID,
        CONE_LAYER_CHARACTERISTIC,
        base64String,
      );

      // Return if the write was successful
      return true;
    } catch (error) {
      //

      // Catch any errors and log them
      console.error("Error in sending string: ", error);

      // Return that the write was unsuccessful
      return false;
    }
  }

  // The function to disconnect from the device
  async function disconnectFromDevice() {
    //

    // If the connected device doesn't exist,
    // exit the function
    if (!connectedDevice) return;

    // Otherwise, get the bluetooth manager to cancel the device connection
    bleManager.cancelDeviceConnection(connectedDevice.id);

    // Set the connected device to null
    setConnectedDevice(null);

    // Set the console data to an empty string
    setConeLayerConsoleData("");
  }

  // Return the function to request permissions
  // and the function to scan for peripherals
  return {
    requestPermissions,
    scanForPeripherals,
    scanForDevices,
    connectToDevice,
    startStreamingData,
    sendStringToDevice,
    disconnectFromDevice,
    allDevices,
    connectedDevice,
    coneLayerConsoleData,
  };
}

// Export the bluetooth low energy api
export default useBluetoothLowEnergy;
