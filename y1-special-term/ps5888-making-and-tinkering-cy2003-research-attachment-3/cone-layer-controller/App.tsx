import { View, StyleSheet } from "react-native";
import { ThemeContextProvider } from "./src/utils/theme-context";
import AppWrapper from "./src/components/AppWrapper";

export default function App() {
  return (
    <View style={styles.container}>
      <ThemeContextProvider>
        <AppWrapper />
      </ThemeContextProvider>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
  },
});
