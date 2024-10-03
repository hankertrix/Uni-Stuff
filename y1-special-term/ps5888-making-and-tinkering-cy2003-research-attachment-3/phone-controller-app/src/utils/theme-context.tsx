// The module containing the theme context provider

import React, { useMemo } from "react";
import { useState, useCallback, useContext } from "react";
import { useColorScheme } from "react-native";

// The interface for the theme context
interface ThemeContext {
  theme: "light" | "dark";
  setTheme: (theme: "light" | "dark") => void;
  toggleTheme: () => void;
  getThemeStyles: () => ThemedStyles;
}

// The type of the styles object
export type ThemedStyles = {
  textColour: string;
  backgroundColour: string;
  joystickJoypadColour: string;
  joystickNubColour: string;
  deviceListButtonColour: string;
  deviceListButtonColourPressed: string;
  deviceListTextColour: string;
};

// The type of the theme colours object
export type ThemeStyles = {
  light: ThemedStyles;
  dark: ThemedStyles;
};

// The theme styles
export const themeStyles: ThemeStyles = {
  light: {
    textColour: "#000000",
    backgroundColour: "#f2f2f2",
    joystickJoypadColour: "#000000",
    joystickNubColour: "#34eb12",
    deviceListButtonColour: "#ff6060",
    deviceListButtonColourPressed: "#f25b5b",
    deviceListTextColour: "#f2f2f2",
  },
  dark: {
    textColour: "#e6e6e6",
    backgroundColour: "#121212",
    joystickJoypadColour: "#f2f2f2",
    joystickNubColour: "#009f30",
    deviceListButtonColour: "#e65656",
    deviceListButtonColourPressed: "#db5252",
    deviceListTextColour: "#ffffff",
  },
};

// The theme context
const ThemeContext = React.createContext<ThemeContext>({
  theme: "light",
  setTheme: () => {},
  toggleTheme: () => {
    console.error("Theme context not set");
  },
  getThemeStyles: () => themeStyles.light,
});

// Export the theme context provider
export const ThemeContextProvider = React.memo<React.PropsWithChildren<{}>>(
  (props) => {
    //

    // Get the initial theme
    let initialTheme = useColorScheme();

    // If the initial theme isn't defined, set it to light
    if (!initialTheme) initialTheme = "light";

    // Initialise the theme
    const [theme, setTheme] = useState<"light" | "dark">(initialTheme);

    // Create the function to toggle the theme
    const toggleTheme = useCallback(() => {
      //

      // Call the function to set the theme
      setTheme(() => {
        //

        // If the theme is light, set it to dark
        if (theme === "light") {
          return "dark";
        }

        // Otherwise, set it to light
        return "light";
      });
    }, [theme]);

    // Create the function to get the theme styles for the current theme
    const getThemeStyles = useCallback(() => {
      //

      // If the theme is light, return the light theme styles
      if (theme === "light") return themeStyles.light;

      // Otherwise, return the dark theme styles
      return themeStyles.dark;
    }, [theme]);

    // Create a memoised value for the theme context
    const memoisedThemeContext = useMemo(() => {
      //

      // Create the theme context object
      const themeContext: ThemeContext = {
        theme,
        setTheme,
        toggleTheme: toggleTheme,
        getThemeStyles: getThemeStyles,
      };

      // Return the theme context
      return themeContext;
    }, [theme, toggleTheme, getThemeStyles]);

    // Return the theme context provider with the children
    return (
      <ThemeContext.Provider value={memoisedThemeContext}>
        {props.children}
      </ThemeContext.Provider>
    );
  },
);

// Export the theme context consumer
export const useTheme = () => useContext(ThemeContext);
