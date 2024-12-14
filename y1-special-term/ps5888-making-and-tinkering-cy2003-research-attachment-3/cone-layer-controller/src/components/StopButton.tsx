// The module containing the button to stop the cone layer

import { useCallback } from "react";
import { Pressable, StyleSheet, Text } from "react-native";
import { BluetoothDevice, SendStringToDevice } from "../utils/bluetooth";

// The stop command
export const STOP_COMMAND = "stop";

// The interface for the stop button
interface StopButtonProps {
  radius: number;
  visible: boolean;
  setArduinoAsNotBusy: () => void;
  connectedDevice: BluetoothDevice | null;
  sendStringToDevice: SendStringToDevice;
}

// The stop button component
const StopButton = ({
  radius,
  visible,
  setArduinoAsNotBusy,
  connectedDevice,
  sendStringToDevice,
}: StopButtonProps) => {
  //

  // The function to handle the button press
  const handleButtonPress = useCallback(async () => {
    //

    // Send the stop command to the device
    const successful = await sendStringToDevice(connectedDevice, STOP_COMMAND);

    // If the command isn't successful, exit the function
    if (!successful) return;

    // Otherwise, set the joystick to be enabled
    setArduinoAsNotBusy();
  }, [sendStringToDevice, setArduinoAsNotBusy]);

  // The function to create the styles
  const createStyles = useCallback(
    (isPressed: boolean) => {
      //

      // Create the styles
      const styles = StyleSheet.create({
        button: {
          width: radius * 2,
          height: radius * 2,
          borderRadius: radius,
          justifyContent: "center",
          alignItems: "center",
          backgroundColor: isPressed ? "#f20000" : "#ff3333",
          opacity: visible ? 1 : 0,
        },
        text: {
          textAlign: "center",
          fontSize: radius * 0.6,
          color: "#000000",
        },
      });

      // Return the styles
      return styles;
    },
    [radius, visible],
  );

  // Return the button component
  return (
    <Pressable
      style={({ pressed }) => createStyles(pressed).button}
      onPress={handleButtonPress}
    >
      {({ pressed }) => {
        //

        // Create the styles for the rest of the button
        const styles = createStyles(pressed);

        // Return the rest of the button
        return <Text style={styles.text}>Stop</Text>;
      }}
    </Pressable>
  );
};

// Export the button component by default
export default StopButton;
