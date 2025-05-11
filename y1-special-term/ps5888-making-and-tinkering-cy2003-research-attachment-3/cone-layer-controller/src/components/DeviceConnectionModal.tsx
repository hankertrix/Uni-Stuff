// The component to display the connect screen

import { useCallback, useMemo } from "react";
import {
  ListRenderItemInfo,
  Pressable,
  Text,
  StyleSheet,
  ViewStyle,
  TextStyle,
  Modal,
  SafeAreaView,
  View,
} from "react-native";
import { FlatList } from "react-native-gesture-handler";
import { ThemedStyles, useTheme } from "../utils/theme-context";
import {
  AllDevices,
  BluetoothDevice,
  ConnectToDevice,
} from "../utils/bluetooth";

// The props for the device list item
interface DeviceListItemProps {
  item: ListRenderItemInfo<BluetoothDevice>;
  connectToDevice: ConnectToDevice;
  closeModal: () => void;
  themedStyles: ThemedStyles;
  styles: {
    listItemButton: ViewStyle;
    listItemText: TextStyle;
    [styleName: string]: ViewStyle | TextStyle;
  };
}

// The props for the device connection modal
interface DeviceConnectionModalProps {
  devices: AllDevices;
  visible: boolean;
  connectToDevice: ConnectToDevice;
  closeModal: () => void;
}

// The list item component for the device list
const DeviceListItem = ({
  item,
  connectToDevice,
  closeModal,
  themedStyles,
  styles,
}: DeviceListItemProps) => {
  //

  // The function to handle the button press
  const handlePress = useCallback(() => {
    //

    // Connect to the device
    connectToDevice(item.item);

    // Close the modal
    closeModal();
  }, [item.item, connectToDevice, closeModal]);

  // The function to create the styles
  const createStyles = useCallback(
    (isPressed: boolean) => {
      //

      // Create the styles for when the button is pressed
      const buttonPressedStyles = StyleSheet.create({
        listItemButton: {
          ...styles.listItemButton,
          backgroundColor: isPressed
            ? themedStyles.deviceListButtonColourPressed
            : themedStyles.deviceListButtonColour,
        },
      });

      // Return the button pressed styles combined with the given styles
      return Object.assign(styles, buttonPressedStyles);
    },
    [themedStyles, styles],
  );

  // Return the component
  return (
    <Pressable
      onPress={handlePress}
      style={({ pressed }) => createStyles(pressed).listItemButton}
    >
      <Text style={styles.listItemText}>{item.item.name}</Text>
    </Pressable>
  );
};

// The device list component
const DeviceConnectionModal = ({
  devices,
  visible,
  connectToDevice,
  closeModal,
}: DeviceConnectionModalProps) => {
  //

  // Get the theme and the themed styles
  const { theme, getThemeStyles } = useTheme();

  // Get the themed styles
  const themedStyles = getThemeStyles();

  // Create the variable styles
  const styles = useMemo(() => {
    //

    // Create the variable styles
    const variableStyles = StyleSheet.create({
      modalContainer: {
        ...baseStyles.modalContainer,
        backgroundColor: themedStyles.backgroundColour,
      },
      modalTitleText: {
        ...baseStyles.modalTitleText,
        color: themedStyles.textColour,
      },
      listItemButton: {
        ...baseStyles.listItemButton,
        backgroundColor: themedStyles.deviceListButtonColour,
      },
      listItemText: {
        ...baseStyles.listItemText,
        color: themedStyles.deviceListTextColour,
      },
    });

    // Return the base styles combined with the variable styles
    return Object.assign(baseStyles, variableStyles);
  }, [theme, themedStyles]);

  // The function to render the device list item
  const renderDeviceListItem = useCallback(
    (item: ListRenderItemInfo<BluetoothDevice>) => {
      return (
        <DeviceListItem
          item={item}
          connectToDevice={connectToDevice}
          closeModal={closeModal}
          themedStyles={themedStyles}
          styles={styles}
        />
      );
    },
    [devices, connectToDevice, closeModal, themedStyles, styles],
  );

  // Return the device connection modal
  return (
    <Modal
      style={styles.modal}
      animationType="slide"
      transparent={false}
      visible={visible}
    >
      <SafeAreaView style={styles.modalContainer}>
        <View style={styles.modalWrapper}>
          <Text style={styles.modalTitleText}>
            Tap on a device to connect to it
          </Text>
          <FlatList
            contentContainerStyle={styles.deviceList}
            data={devices}
            renderItem={renderDeviceListItem}
          />
        </View>
      </SafeAreaView>
    </Modal>
  );
};

// The base styles
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
    justifyContent: "center",
    alignItems: "center",
    marginTop: 30,
  },
  modalTitleText: {
    fontSize: 25,
    fontWeight: "bold",
    textAlign: "center",
  },
  deviceList: {
    justifyContent: "center",
  },
  listItemButton: {
    justifyContent: "center",
    alignItems: "center",
    borderRadius: 30,
    padding: 5,
    margin: 8,
    minWidth: 200,
  },
  listItemText: {
    fontWeight: "bold",
    fontSize: 20,
  },
});

// Export the connect screen
export default DeviceConnectionModal;
