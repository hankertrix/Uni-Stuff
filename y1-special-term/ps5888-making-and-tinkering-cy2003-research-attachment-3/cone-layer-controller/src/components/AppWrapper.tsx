// The module containing the component that wraps
// the entire app

import { useMemo, useState } from "react";
import { View, SafeAreaView, StyleSheet, Platform } from "react-native";
import { StatusBar } from "expo-status-bar";
import { Device } from "react-native-ble-plx";
import { useTheme } from "../utils/theme-context";
import Dashboard from "./Dashboard";
import useBluetoothLowEnergy from "../utils/bluetooth";

// The component that wraps the entire app
const AppWrapper = () => {
  //

  // Start of bluetooth related code

  const {
    connectedDevice,
    allDevices,
    scanForDevices,
    sendStringToDevice,
    connectToDevice,
    disconnectFromDevice,
  } = useBluetoothLowEnergy();

  // End of bluetooth related code

  // Placeholders for bluetooth related code
  //
  // // Placeholder variables
  // const [connectedDevice, setConnectedDevice] = useState<Device | null>(null);
  // const [allDevices, setAllDevices] = useState<Device[]>([
  //   {
  //     id: "1",
  //     name: "test 1",
  //   } as Device,
  //   {
  //     id: "2",
  //     name: "test 2",
  //   } as Device,
  // ]);
  //
  // // Placeholder functions to mock the bluetooth functions
  // async function scanForDevices() {
  //   return true;
  // }
  // async function sendStringToDevice(device: Device | null, str: string) {
  //   return true;
  // }
  // async function connectToDevice(device: Device) {
  //   setConnectedDevice(device);
  //   return true;
  // }
  // async function disconnectFromDevice() {
  //   setConnectedDevice(null);
  // }
  //
  // End of placeholders

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
