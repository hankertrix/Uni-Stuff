// The module for all the bluetooth related functions

import { useEffect, useState } from "react";
import {
  PermissionsAndroid,
  Platform,
  NativeModules,
  NativeEventEmitter,
  EmitterSubscription,
} from "react-native";
import { Buffer } from "buffer";
import BleManager, { Peripheral } from "react-native-ble-manager";

import * as ExpoDevice from "expo-device";

// The UUID for the cone layer console service
const CONE_LAYER_UUID = "0000FFE0-0000-1000-8000-00805F9B34FB";

// The characteristic for the cone layer console service
const CONE_LAYER_CHARACTERISTIC = "0000FFE1-0000-1000-8000-00805F9B34FB";

// The device name for the cone layer
const CONE_LAYER_DEVICE_NAME = "BT05";

// Seconds to scan for
const SECONDS_TO_SCAN = 300;

// Whether to allow duplicates
const ALLOW_DUPLICATES = false;

// The type of the scan for devices function
export type ScanForDevices = () => Promise<boolean>;

// The type of the connect to device function
export type ConnectToDevice = (device: Peripheral) => Promise<boolean>;

// The type of the send string to device function
export type SendStringToDevice = (
  device: Peripheral | null,
  str: string,
) => Promise<boolean>;

// The type of the disconnect from device function
export type DisconnectFromDevice = () => Promise<void>;

// The type of all devices
export type AllDevices = Peripheral[];

// The type of the bluetooth device
export type BluetoothDevice = Peripheral;

// The interface for the bluetooth device
interface BluetoothLowEnergyApi {
  requestPermissions(): Promise<boolean>;
  scanForPeripherals(): void;
  scanForDevices: ScanForDevices;
  connectToDevice: ConnectToDevice;
  sendStringToDevice: SendStringToDevice;
  disconnectFromDevice: DisconnectFromDevice;
  allDevices: AllDevices;
  connectedDevice: BluetoothDevice | null;
}

// The ble manager module
const bleManagerModule = NativeModules.BleManager;

// The ble manager emitter
const bleManagerEmitter = new NativeEventEmitter(bleManagerModule);

// The function to use bluetooth low energy
function useBluetoothLowEnergy(): BluetoothLowEnergyApi {
  //

  // Initialise the bluetooth low energy manager
  useEffect(() => {
    BleManager.start({ showAlert: true }).then(() => {});
  }, []);

  // Add an additional reference to the bluetooth low energy manager
  const bleManager = BleManager;

  // Initialise the state for the bluetooth devices
  const [allDevices, setAllDevices] = useState<Peripheral[]>([]);

  // Initialise the state for the connected device
  const [connectedDevice, setConnectedDevice] = useState<Peripheral | null>(
    null,
  );

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
  function isDuplicateDevice(devices: Peripheral[], deviceToCheck: Peripheral) {
    return devices.findIndex((device) => deviceToCheck.id === device.id) > -1;
  }

  // The function to scan for peripherals
  async function scanForPeripherals() {
    //

    // Initialise the listeners array
    let listeners: EmitterSubscription[] = [];

    // The function to call when the ble manager discovers a device
    function onDiscoverPeripheral(peripheral: Peripheral) {
      //

      // If the peripheral has an ID and name
      // and includes the cone layer device name
      if (peripheral && peripheral.name?.includes(CONE_LAYER_DEVICE_NAME)) {
        //

        // Add to the device array
        setAllDevices((existingDevices) => {
          //

          // If the device is not a duplicate
          // then add it to the array
          if (!isDuplicateDevice(existingDevices, peripheral)) {
            return [...existingDevices, peripheral];
          }

          // Otherwise, the device is a duplicate,
          // so return the existing devices
          else return existingDevices;
        });
      }
    }

    // The function to call when the ble manager stops scanning
    function onStopScan() {
      //

      // Iterate over all the listeners
      for (const listener of listeners) {
        //

        // Remove the listener
        listener.remove();
      }
    }

    // Try block to catch any errors
    try {
      //

      // Add the listeners to the listeners array
      listeners = [
        bleManagerEmitter.addListener(
          "BleManagerDiscoverPeripheral",
          onDiscoverPeripheral,
        ),
        bleManagerEmitter.addListener("BleManagerStopScan", onStopScan),
      ];

      // Scan for peripherals
      await bleManager.scan([], SECONDS_TO_SCAN, ALLOW_DUPLICATES);
    } catch (error) {
      //

      // Log the error
      console.error("Error in scanning for peripherals: ", error);
    }
  }

  // The function to scan for devices
  const scanForDevices: ScanForDevices = async () => {
    //

    // Request for permissions
    const permissionsRequestSuccess = await requestPermissions();

    // If the permissions request was not successful, return false
    if (!permissionsRequestSuccess) return false;

    // Otherwise, scan for peripherals
    await scanForPeripherals();

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
      await bleManager.connect(device.id);

      // Set the connected device to the device
      setConnectedDevice(device);

      // Retrieve the services
      // so that data can be sent to the device
      await bleManager.retrieveServices(device.id);

      // Get whether the ble manager is still scanning
      const isScanning = await bleManager.isScanning();

      // If the ble manager is still scanning,
      // stop the device scan
      if (isScanning) {
        await bleManager.stopScan();
      }

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

  // The function to send a string to the device
  async function sendStringToDevice(
    device: Peripheral | null,
    str: string,
  ): Promise<boolean> {
    //

    // If the device doesn't exist, exit the function
    if (!device) return false;

    // Trim the string
    str = str.trim();

    // Add the new line character to the string
    str += "\n";

    // Convert the string to a byte string
    const byteString = Buffer.from(str, "utf8");

    // Get the byte array from the string
    const byteArray = Array.from(byteString);

    // Try to write the string to the device
    try {
      await bleManager.writeWithoutResponse(
        device.id ?? "",
        CONE_LAYER_UUID,
        CONE_LAYER_CHARACTERISTIC,
        byteArray,
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
    bleManager.disconnect(connectedDevice.id);

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
    sendStringToDevice,
    disconnectFromDevice,
    allDevices,
    connectedDevice,
    coneLayerConsoleData,
  };
}

// Export the bluetooth low energy api
export default useBluetoothLowEnergy;
