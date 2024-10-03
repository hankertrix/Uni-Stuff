import { useCallback, useState } from "react";
import { StatusBar } from "expo-status-bar";
import { SafeAreaView, StyleSheet } from "react-native";
import { Dashboard } from "./src/components/Dashboard";
import { ThemeContextProvider } from "./src/utils/theme-context";
import useBluetoothLowEnergy from "./src/utils/bluetooth";

export default function App() {
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

  return (
    <SafeAreaView style={styles.container}>
      <ThemeContextProvider>
        <Dashboard
          connectedDevice={connectedDevice}
          allDevices={allDevices}
          scanForDevices={scanForDevices}
          sendStringToDevice={sendStringToDevice}
          connectToDevice={connectToDevice}
          disconnectFromDevice={disconnectFromDevice}
        />
        <StatusBar style="auto" />
      </ThemeContextProvider>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
  },
});
