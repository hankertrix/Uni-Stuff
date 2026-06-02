// The module containing the component that wraps
// the entire app

import { useMemo, useState } from "react";
import { View, SafeAreaView, StyleSheet, Platform } from "react-native";
import { StatusBar } from "expo-status-bar";
import { useTheme } from "../utils/theme-context";
import Dashboard from "./Dashboard";
import useBluetoothLowEnergy, {
  AllDevices,
  BluetoothDevice,
  ConnectToDevice,
  SendStringToDevice,
} from "../utils/bluetooth";

// The function to mock the bluetooth functions
function mockUseBluetoothLowEnergy() {
  //

  // Create the connected device state
  const [connectedDevice, setConnectedDevice] =
    useState<BluetoothDevice | null>(null);

  // Create the list of all devices
  const [allDevices, _] = useState<AllDevices>([
    {
      id: "1",
      name: "BT05",
    } as BluetoothDevice,
  ]);

  // Mock the scan for devices function
  async function scanForDevices() {
    return true;
  }

  // Mock the send string to device function
  const sendStringToDevice: SendStringToDevice = async (_, string) => {
    console.log(string);
    return true;
  };

  // Mock the connect to device function
  const connectToDevice: ConnectToDevice = async (device) => {
    setConnectedDevice(device);
    return true;
  };

  // Mock the disconnect from device function
  async function disconnectFromDevice() {
    setConnectedDevice(null);
  }

  // Return the bluetooth state
  // and functions
  return {
    connectedDevice,
    allDevices,
    scanForDevices,
    sendStringToDevice,
    connectToDevice,
    disconnectFromDevice,
  };
}

// The component that wraps the entire app
const AppWrapper = () => {
  //

  // If bluetooth mocking is wanted,
  // which means the app is being run
  // on Expo Go, and not being run
  // natively on a device,
  // then call the function to mock
  // the bluetooth functions and state,
  // otherwise, use the real bluetooth
  // functions and state
  const {
    connectedDevice,
    allDevices,
    scanForDevices,
    sendStringToDevice,
    connectToDevice,
    disconnectFromDevice,
  } = useBluetoothLowEnergy();

  // Get the theme
  const { theme, getThemeStyles } = useTheme();

  // Get the themed styles
  const themedStyles = getThemeStyles();

  // Get if the platform is Android
  const isAndroid = Platform.OS === "android";

  // Create the styles
  const styles = useMemo(
    () =>
      StyleSheet.create({
        appWrapper: {
          flex: 1,
          justifyContent: "center",
          alignItems: "center",
          alignSelf: "stretch",
          backgroundColor: themedStyles.backgroundColour,
        },
        wrapper: {
          flex: 1,
          justifyContent: "center",
          alignItems: "center",
          alignSelf: "stretch",
          backgroundColor: themedStyles.backgroundColour,
          marginTop: isAndroid ? 30 : 0,
        },
      }),
    [themedStyles],
  );

  // Return the component
  return (
    <View style={styles.appWrapper}>
      <SafeAreaView style={styles.wrapper}>
        <Dashboard
          connectedDevice={connectedDevice}
          allDevices={allDevices}
          scanForDevices={scanForDevices}
          sendStringToDevice={sendStringToDevice}
          connectToDevice={connectToDevice}
          disconnectFromDevice={disconnectFromDevice}
        />
      </SafeAreaView>
      <StatusBar style={theme === "dark" ? "light" : "dark"} />
    </View>
  );
};

// Export the component
export default AppWrapper;
