// The module containing the button to toggle the theme

import { useMemo } from "react";
import { View, Pressable, StyleSheet } from "react-native";
import Svg, { Path, G } from "react-native-svg";
import { useTheme } from "../utils/theme-context";

type ThemeTogglerProps = {
  radius: number;
  visible: boolean;
};

// The button to toggle the theme
const ThemeTogglerButton = ({ radius, visible }: ThemeTogglerProps) => {
  //

  // Get the function to toggle the theme
  const { theme, toggleTheme, getThemeStyles } = useTheme();

  // Get the themed styles provided by the context
  const providedThemedStyles = getThemeStyles();

  // Create the variable styles
  const styles = useMemo(
    () =>
      StyleSheet.create({
        wrapper: {
          justifyContent: "center",
          alignItems: "center",
        },
        button: {
          borderRadius: radius,
          width: radius * 2,
          height: radius * 2,
          backgroundColor: theme === "dark" ? "#404040" : "#ffffff",
          borderWidth: theme === "dark" ? 0 : 2,
          justifyContent: "center",
          opacity: visible ? 1 : 0,
        },
        icon: {
          padding: theme === "dark" ? 7 : 0,
          transform: [{ translateX: theme === "dark" ? -7 : 0 }],
        },
      }),
    [radius, visible, theme, providedThemedStyles],
  );

  // The moon SVG icon
  const moonIcon = useMemo(
    () => (
      <Svg fill={providedThemedStyles.textColour} viewBox="0 0 56 56">
        <Path d="M29,28c0-11.917,7.486-22.112,18-26.147C43.892,0.66,40.523,0,37,0C21.561,0,9,12.561,9,28  s12.561,28,28,28c3.523,0,6.892-0.66,10-1.853C36.486,50.112,29,39.917,29,28z" />
      </Svg>
    ),
    [providedThemedStyles.textColour],
  );

  // The sun SVG icon
  const sunIcon = useMemo(
    () => (
      <Svg fill={providedThemedStyles.textColour} viewBox="0 0 457.32 457.32">
        <G>
          <Path d="M228.66,112.692c-63.945,0-115.968,52.022-115.968,115.967c0,63.945,52.023,115.968,115.968,115.968   s115.968-52.023,115.968-115.968C344.628,164.715,292.605,112.692,228.66,112.692z" />
          <Path d="M401.429,228.66l42.467-57.07c2.903-3.9,3.734-8.966,2.232-13.59c-1.503-4.624-5.153-8.233-9.794-9.683   l-67.901-21.209l0.811-71.132c0.056-4.862-2.249-9.449-6.182-12.307c-3.934-2.858-9.009-3.633-13.615-2.077l-67.399,22.753   L240.895,6.322C238.082,2.356,233.522,0,228.66,0c-4.862,0-9.422,2.356-12.235,6.322l-41.154,58.024l-67.4-22.753   c-4.607-1.555-9.682-0.781-13.615,2.077c-3.933,2.858-6.238,7.445-6.182,12.307l0.812,71.132l-67.901,21.209   c-4.641,1.45-8.291,5.059-9.793,9.683c-1.503,4.624-0.671,9.689,2.232,13.59l42.467,57.07l-42.467,57.07   c-2.903,3.9-3.734,8.966-2.232,13.59c1.502,4.624,5.153,8.233,9.793,9.683l67.901,21.208l-0.812,71.132   c-0.056,4.862,2.249,9.449,6.182,12.307c3.934,2.857,9.007,3.632,13.615,2.077l67.4-22.753l41.154,58.024   c2.813,3.966,7.373,6.322,12.235,6.322c4.862,0,9.422-2.356,12.235-6.322l41.154-58.024l67.399,22.753   c4.606,1.555,9.681,0.781,13.615-2.077c3.933-2.858,6.238-7.445,6.182-12.306l-0.811-71.133l67.901-21.208   c4.641-1.45,8.291-5.059,9.794-9.683c1.502-4.624,0.671-9.689-2.232-13.59L401.429,228.66z M228.66,374.627   c-80.487,0-145.968-65.481-145.968-145.968S148.173,82.692,228.66,82.692s145.968,65.48,145.968,145.967   S309.147,374.627,228.66,374.627z" />
        </G>
      </Svg>
    ),
    [providedThemedStyles.textColour],
  );

  // Return the button component
  return (
    <View style={styles.wrapper}>
      <Pressable onPress={toggleTheme} style={styles.button}>
        <View style={styles.icon}>
          {theme === "light" ? sunIcon : moonIcon}
        </View>
      </Pressable>
    </View>
  );
};

export default ThemeTogglerButton;
