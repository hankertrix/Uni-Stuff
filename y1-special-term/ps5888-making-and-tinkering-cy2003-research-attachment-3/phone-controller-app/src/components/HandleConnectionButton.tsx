// The module containing the button to disconnect from the device

import { View, Pressable, StyleSheet, Text } from "react-native";
import { useCallback, useMemo } from "react";
import { useTheme } from "../utils/theme-context";

// The interface for the handle connection button
interface handleConnectionButtonProps {
  minWidth: number;
  buttonText: string;
  handleConnection: () => void;
}

// The button to handle connection or disconnection
const HandleConnectionButton = ({
  minWidth,
  buttonText,
  handleConnection,
}: handleConnectionButtonProps) => {
  //

  // Get the theme
  const { getThemeStyles } = useTheme();

  // Get the themed styles
  const themedStyles = getThemeStyles();

  // The function to create the styles for the disconnect button
  const createStyles = useCallback(
    (isPressed: boolean) => {
      //

      // The created styles
      const styles = StyleSheet.create({
        wrapper: {
          flex: 1,
          justifyContent: "center",
          alignItems: "center",
        },
        button: {
          minWidth: minWidth,
          justifyContent: "center",
          alignItems: "center",
          borderRadius: 10,
          padding: 15,
          backgroundColor: isPressed
            ? themedStyles.deviceListButtonColourPressed
            : themedStyles.deviceListButtonColour,
        },
        text: {
          fontSize: 20,
          fontWeight: "bold",
          color: themedStyles.deviceListTextColour,
          textAlign: "center",
        },
      });

      // Return the created styles
      return styles;
    },
    [minWidth, themedStyles],
  );

  // Create the styles
  const styles = useMemo(() => createStyles(false), [minWidth]);

  // Return the disconnect button
  return (
    <View style={styles.wrapper}>
      <Pressable
        style={({ pressed }) => createStyles(pressed).button}
        onPress={handleConnection}
      >
        <Text style={styles.text}>{buttonText}</Text>
      </Pressable>
    </View>
  );
};

// Export the handle connection button
export default HandleConnectionButton;
