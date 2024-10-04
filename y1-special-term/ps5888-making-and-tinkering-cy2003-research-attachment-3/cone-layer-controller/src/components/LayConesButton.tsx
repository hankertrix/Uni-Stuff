// The module containing the button to lay cones in a straight line

import { useCallback, useMemo } from "react";
import { Pressable, StyleSheet, Text } from "react-native";
import { themeStyles, useTheme } from "../utils/theme-context";

// The interface for the lay cones button
interface LayConesButtonProps {
  radius: number;
  visible: boolean;
  disable: boolean;
  openLayConesModal: () => void;
}

// The lay cones button component
const LayConesButton = ({
  radius,
  visible,
  disable,
  openLayConesModal,
}: LayConesButtonProps) => {
  //

  // Create the function to handle the button press
  const handleButtonPress = useCallback(() => {
    //

    // If the button has been disabled, exit the function
    if (disable) return;

    // Otherwise, open the lay cones modal
    openLayConesModal();
  }, [disable, openLayConesModal]);

  // Get the theme
  const { getThemeStyles } = useTheme();

  // Get the themed styles
  const providedThemedStyles = getThemeStyles();

  // Create the variable styles
  const createStyles = useCallback(
    (isPressed: boolean) => {
      //

      // Create the variable styles
      const styles = StyleSheet.create({
        layConesButton: {
          justifyContent: "center",
          alignItems: "center",
          backgroundColor:
            (isPressed ? "#8c409e" : "#9e48b3") + (disable ? "cc" : "ff"),
          borderRadius: radius,
          width: radius * 2,
          height: radius * 2,
          opacity: visible ? 1 : 0,
        },
        layConesButtonText: {
          textAlign: "center",
          fontSize: radius * 0.5,
          color: themeStyles.dark.textColour + (disable ? "cc" : "ff"),
        },
      });

      // Return the base styles combined with the variable styles
      return styles;
    },
    [radius, visible, disable, providedThemedStyles],
  );

  // Get the styles
  const styles = useMemo(() => {
    return createStyles(false);
  }, [createStyles]);

  // Return the lay cones button component with the overlay
  return (
    <Pressable
      style={({ pressed }) => createStyles(pressed).layConesButton}
      onPress={handleButtonPress}
    >
      <Text style={styles.layConesButtonText}>Lay Cones</Text>
    </Pressable>
  );
};

// Export the button component by default
export default LayConesButton;
