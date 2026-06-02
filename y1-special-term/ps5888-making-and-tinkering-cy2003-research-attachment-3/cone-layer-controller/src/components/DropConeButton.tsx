// The module containing the button to drop a cone

import { Pressable, StyleSheet, Text } from "react-native";
import { useCallback } from "react";
import { themeStyles } from "../utils/theme-context";
import { BluetoothDevice, SendStringToDevice } from "../utils/bluetooth";

// The drop cone command
const DROP_CONE_COMMAND = "drop_cone";

// The interface for the drop cone button
interface DropConeButtonProps {
  radius: number;
  visible: boolean;
  disable: boolean;
  motorSpeed: number;
  setArduinoAsBusy: () => void;
  connectedDevice: BluetoothDevice | null;
  sendStringToDevice: SendStringToDevice;
}

// The button component to drop a cone
const DropConeButton = ({
  radius,
  visible,
  disable,
  motorSpeed,
  setArduinoAsBusy,
  connectedDevice,
  sendStringToDevice,
}: DropConeButtonProps) => {
  //

  // Round the motor speed to the nearest integer
  motorSpeed = Math.round(motorSpeed);

  // The function to handle the button press
  const handleButtonPress = useCallback(async () => {
    //

    // If the button has been disabled, exit the function
    if (disable) return;

    // If there is no connected device, exit the function
    if (!connectedDevice) return;

    // Create the drop cone string
    const dropConeString = `${DROP_CONE_COMMAND} ${motorSpeed}`;

    // Send the drop cone command to the device
    const successful = await sendStringToDevice(
      connectedDevice,
      dropConeString,
    );

    // If the command isn't successful, exit the function
    if (!successful) return;

    // Otherwise, set the joystick to be disabled
    setArduinoAsBusy();
  }, [disable, motorSpeed, connectedDevice, setArduinoAsBusy]);

  // The function to create the styles for the drop cone button
  const createStyles = useCallback(
    (isPressed: boolean) => {
      //

      // The styles for the button
      const styles = StyleSheet.create({
        button: {
          justifyContent: "center",
          alignItems: "center",
          backgroundColor:
            (isPressed ? "#0e32a7" : "#2747b0") + (disable ? "cc" : "ff"),
          borderRadius: radius,
          width: radius * 2,
          height: radius * 2,
          opacity: visible ? 1 : 0,
        },
        text: {
          textAlign: "center",
          fontSize: radius * 0.5,
          color: themeStyles.dark.textColour + (disable ? "cc" : "ff"),
        },
      });

      // Merge the base styles with the variable styles and return the result
      return styles;
    },
    [radius, visible, disable],
  );

  // Return the drop cone button
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
        return <Text style={styles.text}>Drop Cone</Text>;
      }}
    </Pressable>
  );
};

// Export the button component by default
export default DropConeButton;
