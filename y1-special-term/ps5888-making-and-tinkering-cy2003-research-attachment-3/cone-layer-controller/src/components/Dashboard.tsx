// The screen that shows the dashboard for the Arduino

import { useCallback, useMemo, useState } from "react";
import { StyleSheet, View, Text } from "react-native";
import { GestureHandlerRootView } from "react-native-gesture-handler";
import { ThemedStyles, useTheme } from "../utils/theme-context";
import Joystick, { JoystickEventHandler } from "./Joystick";
import ThemeTogglerButton from "./ThemeToggler";
import DropConeButton from "./DropConeButton";
import HandleConnectionButton from "./HandleConnectionButton";
import StopButton, { STOP_COMMAND } from "./StopButton";
import DeviceConnectionModal from "./DeviceConnectionModal";
import LayConesButton from "./LayConesButton";
import LayConesModal from "./LayConesModal";
import {
  AllDevices,
  BluetoothDevice,
  ConnectToDevice,
  DisconnectFromDevice,
  ScanForDevices,
  SendStringToDevice,
} from "../utils/bluetooth";

// The radius of the round buttons
const ROUND_BUTTON_RADIUS = 35;

// The minimum width of the connection button
const CONNECTION_BUTTON_MIN_WIDTH = 150;

// The joystick radius
const JOYSTICK_RADIUS = 150;

// The delay between two joystick movements
// (in milliseconds)
const JOYSTICK_MOVEMENT_DELAY_IN_MS = 250;

// The motor speed
const DROP_CONE_MOTOR_SPEED = 50;

// The handle joystick command
const HANDLE_JOYSTICK_COMMAND = "handle_joystick";

// The number of times to repeat the stop command
const STOP_COMMAND_REPEAT_COUNT = 3;

// The interface for the dashboard
interface DashboardProps {
  connectedDevice: BluetoothDevice | null;
  allDevices: AllDevices;
  scanForDevices: ScanForDevices;
  sendStringToDevice: SendStringToDevice;
  connectToDevice: ConnectToDevice;
  disconnectFromDevice: DisconnectFromDevice;
}

// The function to create the styles for the dashboard
function createStyles(themedStyles: ThemedStyles) {
  //

  // The created styles
  const variableStyles = StyleSheet.create({
    wrapper: {
      ...baseStyles.wrapper,
      backgroundColor: themedStyles.backgroundColour,
    },
    text: {
      color: themedStyles.textColour,
    },
    noDeviceText: {
      ...baseStyles.noDeviceText,
      color: themedStyles.textColour,
    },
    joystickJoypadColour: {
      color: themedStyles.joystickJoypadColour,
    },
    joystickNubColour: {
      color: themedStyles.joystickNubColour,
    },
  });

  // Return the base styles combined with the theme styles
  return Object.assign(baseStyles, variableStyles);
}

// The dashboard component that will be the main screen
// for controlling the Arduino
const Dashboard = ({
  connectedDevice,
  allDevices,
  scanForDevices,
  sendStringToDevice,
  connectToDevice,
  disconnectFromDevice,
}: DashboardProps) => {
  //

  // Initialise if the device is connected or not
  const deviceIsConnected = Boolean(connectedDevice);

  // Initialise the state of whether the Ardiuno is busy or not
  const [arduinoBusy, setArduinoBusy] = useState(false);

  // The function to set the Arduino as busy
  const setArduinoAsBusy = useCallback(() => {
    setArduinoBusy(true);
  }, [setArduinoBusy]);

  // The function to set the Arduino as not busy
  const setArduinoAsNotBusy = useCallback(() => {
    setArduinoBusy(false);
  }, [setArduinoBusy]);

  // Initialise the state of whether
  // the device connection modal is active or not
  const [deviceConnectionModalVisible, setDeviceConnectionModalVisible] =
    useState(false);

  // The function to open the device connection modal
  function openDeviceConnectionModal() {
    //

    // Scan for devices
    scanForDevices();

    // Set the Arduino state as not busy
    setArduinoAsNotBusy();

    // Set the device connection modal to visible
    setDeviceConnectionModalVisible(true);
  }

  // The function to close the device connection modal
  function closeDeviceConnectionModal() {
    setDeviceConnectionModalVisible(false);
  }

  // Initialise the state of whether
  // the lay cones modal is active or not
  const [layConesModalVisible, setLayConesModalVisible] = useState(false);

  // The function to open the lay cones modal
  const openLayConesModal = useCallback(() => {
    //

    // If there is no connected device, exit the function
    if (!connectedDevice) return;

    // Otherwise, open the lay cones modal
    setLayConesModalVisible(true);
  }, [connectedDevice]);

  // The function to close the lay cones modal
  function closeLayConesModal() {
    setLayConesModalVisible(false);
  }

  // The function to connect to a device
  // and set the state of the Arduino as not busy
  const connectToDeviceAndResetState: ConnectToDevice = useCallback(
    async (device) => {
      //

      // Call the connect to device function
      const result = connectToDevice(device);

      // Set the Arduino as not busy
      setArduinoAsNotBusy();

      // Return the result of the connect to device function
      return result;
    },
    [connectToDevice, setArduinoAsNotBusy],
  );

  // The function to disconnect from a device
  // and set the state of the Arduino as not busy
  const disconnectFromDeviceAndResetState: DisconnectFromDevice =
    useCallback(async () => {
      //

      // Call the disconnect from device function
      disconnectFromDevice();

      // Set the Arduino as not busy
      setArduinoAsNotBusy();
    }, [disconnectFromDevice, setArduinoAsNotBusy]);

  // Create the function to handle the joystick move event
  const handleJoystickMoveEvent: JoystickEventHandler = useCallback(
    ({ position: { x, y } }) => {
      //

      // Round the x and y coordinates to the nearest integer
      const xCoordinates = Math.round(x);
      const yCoordinates = Math.round(y);

      // Create the command to send to the device
      const command =
        HANDLE_JOYSTICK_COMMAND + " " + `${xCoordinates} ${yCoordinates}`;

      // Send the command to the device
      sendStringToDevice(connectedDevice, command);
    },
    [connectedDevice, sendStringToDevice],
  );

  // Create the function to handle the joystick stop event
  const handleJoystickStopEvent: JoystickEventHandler = useCallback(() => {
    //

    // Create the command to stop the Arduino
    const command = STOP_COMMAND;

    // Send the command to the device the number of times
    // specified by the STOP_COMMAND_REPEAT_COUNT constant
    for (let i = 0; i < STOP_COMMAND_REPEAT_COUNT; ++i) {
      sendStringToDevice(connectedDevice, command);
    }
  }, [connectedDevice, sendStringToDevice]);

  // Initialise the theme
  const { getThemeStyles } = useTheme();

  // Get the themed styles
  const themedStyles = getThemeStyles();

  // Get the styles for the dashboard
  const styles = useMemo(
    () => createStyles(themedStyles),
    [themedStyles, connectedDevice],
  );

  // Return the dashboard component
  return (
    <View style={styles.wrapper}>
      <View style={styles.dashboard}>
        <View style={styles.topRow}>
          <ThemeTogglerButton
            radius={ROUND_BUTTON_RADIUS}
            visible={!deviceConnectionModalVisible && !layConesModalVisible}
          />
          <LayConesButton
            radius={ROUND_BUTTON_RADIUS}
            visible={
              deviceIsConnected &&
              !deviceConnectionModalVisible &&
              !layConesModalVisible
            }
            disable={arduinoBusy}
            openLayConesModal={openLayConesModal}
          />
        </View>
        {deviceIsConnected ? (
          <GestureHandlerRootView style={styles.joystickWrapper}>
            <Joystick
              joypadColour={styles.joystickJoypadColour.color}
              nubColour={styles.joystickNubColour.color}
              radius={JOYSTICK_RADIUS}
              disable={arduinoBusy}
              delayInMs={JOYSTICK_MOVEMENT_DELAY_IN_MS}
              onMove={handleJoystickMoveEvent}
              onStop={handleJoystickStopEvent}
            />
          </GestureHandlerRootView>
        ) : (
          <Text style={styles.noDeviceText}>
            Please connect to the Arduino Cone Layer
          </Text>
        )}
        <View style={styles.bottomRow}>
          <DropConeButton
            radius={ROUND_BUTTON_RADIUS}
            visible={deviceIsConnected}
            disable={arduinoBusy}
            motorSpeed={DROP_CONE_MOTOR_SPEED}
            setArduinoAsBusy={setArduinoAsBusy}
            connectedDevice={connectedDevice}
            sendStringToDevice={sendStringToDevice}
          />
          <HandleConnectionButton
            minWidth={CONNECTION_BUTTON_MIN_WIDTH}
            buttonText={connectedDevice ? "Disconnect" : "Connect"}
            handleConnection={
              connectedDevice
                ? disconnectFromDeviceAndResetState
                : openDeviceConnectionModal
            }
          />
          <StopButton
            radius={ROUND_BUTTON_RADIUS}
            visible={deviceIsConnected}
            setArduinoAsNotBusy={setArduinoAsNotBusy}
            connectedDevice={connectedDevice}
            sendStringToDevice={sendStringToDevice}
          />
        </View>
      </View>
      <View style={styles.modalWrapper}>
        <GestureHandlerRootView>
          <DeviceConnectionModal
            devices={allDevices}
            visible={deviceConnectionModalVisible}
            connectToDevice={connectToDeviceAndResetState}
            closeModal={closeDeviceConnectionModal}
          />
        </GestureHandlerRootView>
        <LayConesModal
          visible={layConesModalVisible}
          closeButtonRadius={ROUND_BUTTON_RADIUS / 2}
          setArduinoAsBusy={setArduinoAsBusy}
          closeModal={closeLayConesModal}
          connectedDevice={connectedDevice}
          sendStringToDevice={sendStringToDevice}
        />
      </View>
    </View>
  );
};

// The base styles for the dashboard
const baseStyles = StyleSheet.create({
  wrapper: {
    flex: 1,
    alignSelf: "stretch",
    paddingHorizontal: 5,
    paddingVertical: 8,
  },
  dashboard: {
    flex: 1,
    flexGrow: 1,
    display: "flex",
    flexDirection: "column",
    justifyContent: "space-between",
  },
  topRow: {
    flexDirection: "row",
    justifyContent: "space-between",
  },
  noDeviceText: {
    fontSize: 30,
    fontWeight: "bold",
    textAlign: "center",
  },
  joystickWrapper: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  bottomRow: {
    flexDirection: "row",
    justifyContent: "space-between",
  },
  modalWrapper: {
    position: "absolute",
  },
});

// Export the component by default
export default Dashboard;
