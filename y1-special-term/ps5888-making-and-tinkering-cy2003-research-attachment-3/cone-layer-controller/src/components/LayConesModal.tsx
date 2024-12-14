// The module containing the modal for the lay cones function

import { useCallback, useMemo, useState } from "react";
import {
  Modal,
  Pressable,
  StyleSheet,
  SafeAreaView,
  View,
  Text,
  TextInput,
  TouchableWithoutFeedback,
  Keyboard,
} from "react-native";
import Svg, { Path } from "react-native-svg";
import { BluetoothDevice, SendStringToDevice } from "../utils/bluetooth";
import { themeStyles, useTheme } from "../utils/theme-context";

// The command to lay cones
const LAY_CONES_COMMAND = "lay_cones_in_a_straight_line";

// The font size for text
const FONT_SIZE = 20;

// The interface for the lay cones modal
interface LayConesModalProps {
  visible: boolean;
  closeButtonRadius: number;
  setArduinoAsBusy: () => void;
  closeModal: () => void;
  connectedDevice: BluetoothDevice | null;
  sendStringToDevice: SendStringToDevice;
}

// The modal component
const LayConesModal = ({
  visible,
  closeButtonRadius,
  setArduinoAsBusy,
  closeModal,
  connectedDevice,
  sendStringToDevice,
}: LayConesModalProps) => {
  //

  // Initialise the distance between the cones
  const [distanceBetweenCones, setDistanceBetweenCones] = useState(0);

  // Initialise the number of cones to lay
  const [numberOfCones, setNumberOfCones] = useState(0);

  // The function to handle the user input changing
  function handleTextInputChange(text: string, func: (num: number) => void) {
    //

    // Parse the user's input to an integer
    const parsedInput = parseInt(text);

    // If the user's input is not a valid integer, then exit the function
    if (!Number.isFinite(parsedInput)) return;

    // Call the function with the parsed input
    func(parsedInput);
  }

  // The function to handle the cancel button being pressed
  function handleCancelButtonPress() {
    //

    // Set the distance between cones to 0
    setDistanceBetweenCones(0);

    // Set the number of cones to 0
    setNumberOfCones(0);

    // Close the modal
    closeModal();
  }

  // The function to handle the modal ok button being pressed
  const onModalOkButtonPress = useCallback(async () => {
    //

    // Get the absolute value of the distance between cones
    const distanceBetweenConesAbs = Math.abs(distanceBetweenCones);

    // Get the absolute value of the number of cones to lay
    const numberOfConesAbs = Math.abs(numberOfCones);

    // If the distance between cones or the number of cones is 0,
    // then exit the function
    if (distanceBetweenConesAbs === 0 || numberOfConesAbs === 0) return;

    // Create the lay cones command string
    const layConesCommandString =
      LAY_CONES_COMMAND +
      " " +
      distanceBetweenConesAbs +
      " " +
      numberOfConesAbs;

    // Send the lay cones command to the device
    const successful = await sendStringToDevice(
      connectedDevice,
      layConesCommandString,
    );

    // If the command isn't successful, exit the function
    if (!successful) return;

    // Otherwise, disable the joystick
    setArduinoAsBusy();

    // Close the modal
    closeModal();
  }, [
    setArduinoAsBusy,
    sendStringToDevice,
    distanceBetweenCones,
    numberOfCones,
  ]);

  // Get the theme
  const { theme, getThemeStyles } = useTheme();

  // Get the themed styles
  const providedThemedStyles = getThemeStyles();

  // Create the variable styles
  const createStyles = useCallback(
    (isPressed: boolean) => {
      //

      // The colour of the ok button when it is pressed
      const okButtonColourWhenPressed =
        theme === "dark" ? "#00a600" : "#00af00";

      // The colour of the cancel button when it is pressed
      const cancelButtonColourWhenPressed =
        theme === "dark" ? "#d30000" : "#de0000";

      // Create the variable styles
      const variableStyles = StyleSheet.create({
        modalContainer: {
          ...baseStyles.modalContainer,
          backgroundColor: providedThemedStyles.backgroundColour,
        },
        closeButton: {
          ...baseStyles.closeButton,
          borderColor: isPressed
            ? `${providedThemedStyles.textColour}cc`
            : providedThemedStyles.textColour,
          borderRadius: closeButtonRadius,
          width: closeButtonRadius * 2,
          height: closeButtonRadius * 2,
        },
        textInputLabel: {
          ...baseStyles.textInputLabel,
          color: providedThemedStyles.textColour,
        },
        textInput: {
          ...baseStyles.textInput,
          color: providedThemedStyles.textColour,
          backgroundColor:
            providedThemedStyles.textColour + (theme === "dark" ? "28" : "14"),
        },
        okButton: {
          ...baseStyles.okButton,
          backgroundColor: isPressed ? okButtonColourWhenPressed : "#00b800",
        },
        cancelButton: {
          ...baseStyles.cancelButton,
          backgroundColor: isPressed
            ? cancelButtonColourWhenPressed
            : "#ea0000",
        },
      });

      // Return the base styles combined with the variable styles
      return Object.assign(baseStyles, variableStyles);
    },
    [closeButtonRadius, providedThemedStyles, theme],
  );

  // Get the styles
  const styles = useMemo(() => {
    return createStyles(false);
  }, [createStyles]);

  // The function to create the close button SVG icon
  const createCloseButtonSVG = useCallback(
    (isPressed: boolean) => (
      <Svg
        fill={
          isPressed
            ? `${providedThemedStyles.textColour}cc`
            : providedThemedStyles.textColour
        }
        viewBox="0 0 512 512"
      >
        <Path d="M443.6,387.1L312.4,255.4l131.5-130c5.4-5.4,5.4-14.2,0-19.6l-37.4-37.6c-2.6-2.6-6.1-4-9.8-4c-3.7,0-7.2,1.5-9.8,4  L256,197.8L124.9,68.3c-2.6-2.6-6.1-4-9.8-4c-3.7,0-7.2,1.5-9.8,4L68,105.9c-5.4,5.4-5.4,14.2,0,19.6l131.5,130L68.4,387.1  c-2.6,2.6-4.1,6.1-4.1,9.8c0,3.7,1.4,7.2,4.1,9.8l37.4,37.6c2.7,2.7,6.2,4.1,9.8,4.1c3.5,0,7.1-1.3,9.8-4.1L256,313.1l130.7,131.1  c2.7,2.7,6.2,4.1,9.8,4.1c3.5,0,7.1-1.3,9.8-4.1l37.4-37.6c2.6-2.6,4.1-6.1,4.1-9.8C447.7,393.2,446.2,389.7,443.6,387.1z" />
      </Svg>
    ),
    [providedThemedStyles.textColour],
  );

  // Return the lay cones modal
  return (
    <Modal
      style={styles.modal}
      animationType="slide"
      transparent={false}
      visible={visible}
    >
      <SafeAreaView style={styles.modalContainer}>
        <TouchableWithoutFeedback
          style={styles.modalContainer}
          onPress={Keyboard.dismiss}
        >
          <View style={styles.modalWrapper}>
            <View style={styles.headerRow}>
              <Pressable
                style={({ pressed }) => createStyles(pressed).closeButton}
                onPress={handleCancelButtonPress}
              >
                {({ pressed }) => createCloseButtonSVG(pressed)}
              </Pressable>
            </View>
            <View style={styles.inputRow}>
              <View style={styles.textInputWrapper}>
                <Text style={styles.textInputLabel}>
                  Distance between each cone in cm:
                </Text>
                <TextInput
                  editable
                  maxLength={4}
                  blurOnSubmit={false}
                  inputMode="numeric"
                  keyboardType="numeric"
                  placeholder="120"
                  placeholderTextColor={`${providedThemedStyles.textColour}99`}
                  textAlign="left"
                  keyboardAppearance={theme}
                  style={styles.textInput}
                  onChangeText={(text: string) =>
                    handleTextInputChange(text, setDistanceBetweenCones)
                  }
                />
              </View>
              <View style={styles.textInputWrapper}>
                <Text style={styles.textInputLabel}>
                  Number of cones to lay:
                </Text>
                <TextInput
                  editable
                  maxLength={4}
                  blurOnSubmit={false}
                  inputMode="numeric"
                  keyboardType="numeric"
                  placeholder="20"
                  placeholderTextColor={`${providedThemedStyles.textColour}99`}
                  textAlign="left"
                  keyboardAppearance={theme}
                  style={styles.textInput}
                  onChangeText={(text: string) =>
                    handleTextInputChange(text, setNumberOfCones)
                  }
                />
              </View>
            </View>
            <View style={styles.buttonRow}>
              <View style={styles.buttonWrapper}>
                <View style={styles.individualButtonWrapper}>
                  <Pressable
                    style={({ pressed }) => createStyles(pressed).okButton}
                    onPress={onModalOkButtonPress}
                  >
                    <Text style={styles.buttonText}>Ok</Text>
                  </Pressable>
                </View>
                <View style={styles.individualButtonWrapper}>
                  <Pressable
                    style={({ pressed }) => createStyles(pressed).cancelButton}
                    onPress={handleCancelButtonPress}
                  >
                    <Text style={styles.buttonText}>Cancel</Text>
                  </Pressable>
                </View>
              </View>
            </View>
          </View>
        </TouchableWithoutFeedback>
      </SafeAreaView>
    </Modal>
  );
};

// The base styles for the modal
const baseStyles = StyleSheet.create({
  modal: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  modalContainer: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  modalWrapper: {
    flex: 1,
    flexDirection: "column",
    justifyContent: "space-between",
    alignSelf: "stretch",
    padding: 10,
  },
  headerRow: {
    alignItems: "flex-end",
  },
  closeButton: {
    justifyContent: "center",
    alignItems: "center",
    padding: 1,
    borderWidth: 3,
  },
  inputRow: {
    flexDirection: "column",
    alignSelf: "center",
  },
  buttonRow: {
    alignSelf: "stretch",
  },
  textInputWrapper: {
    margin: 10,
  },
  textInputLabel: {
    fontSize: FONT_SIZE,
    fontWeight: "bold",
    margin: 2,
  },
  textInput: {
    fontSize: FONT_SIZE,
    borderRadius: 12,
    padding: 5,
  },
  buttonWrapper: {
    flexDirection: "row",
    justifyContent: "center",
    alignItems: "center",
  },
  individualButtonWrapper: {
    justifyContent: "center",
    alignItems: "center",
    width: "50%",
  },
  buttonText: {
    fontSize: FONT_SIZE,
    color: themeStyles.dark.textColour,
    padding: 10,
  },
  okButton: {
    borderRadius: 10,
  },
  cancelButton: {
    borderRadius: 10,
  },
});

// Export the lay cones modal component by default
export default LayConesModal;
