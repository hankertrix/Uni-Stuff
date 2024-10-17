// The module containing the Joystick component

import { useCallback, useMemo, useState } from "react";
import { Platform, StyleSheet, View, ViewProps } from "react-native";
import {
  Gesture,
  GestureDetector,
  GestureTouchEvent,
} from "react-native-gesture-handler";

// The type of the joystick event handler
export type JoystickEventHandler = (
  event: JoystickEvent,
) => Promise<void> | void;

// The joystick event interface
interface JoystickEvent {
  force: number;

  // The position of the joystick
  position: {
    x: number;
    y: number;
  };
  angle: {
    radians: number;
    degrees: number;
  };
  type: "move" | "start" | "stop";
}

// The joystick props interface
interface JoystickProps extends ViewProps {
  onStart?: JoystickEventHandler;
  onMove?: JoystickEventHandler;
  onStop?: JoystickEventHandler;
  joypadColour?: string;
  nubColour?: string;
  radius?: number;
  disable?: boolean;
  delayInMs?: number;
}

// The function to convert from radians to degrees
function radiansToDegrees(radians: number) {
  return radians * (180 / Math.PI);
}

// The function to convert from degrees to radians
function degreesToRadians(degrees: number) {
  return degrees * (Math.PI / 180);
}

// The function to calculate the angle of a line
// joining two points from the positive x axis
function calculateAngleOfLineFromPositiveXAxis(
  point1: { x: number; y: number },
  point2: { x: number; y: number },
) {
  //

  // Calculate the change in the x coordinate
  const changeInX = point2.x - point1.x;

  // Calculate the change in the y coordinate
  const changeInY = point2.y - point1.y;

  // Calculate the angle between the two points
  const rawAngle = radiansToDegrees(Math.atan2(changeInY, changeInX));

  // If the raw angle is less than 0, return
  // 180 minus the absolute value of the raw angle
  if (rawAngle < 0) return 180 - Math.abs(rawAngle);

  // Otherwise, return the raw angle plus 180
  return rawAngle + 180;
}

// The function to calculate the distance between two points
function calculateDistance(
  point1: { x: number; y: number },
  point2: { x: number; y: number },
) {
  //

  // Calculate the distance between the two x coordinates
  const xDistance = point2.x - point1.x;

  // Calculate the distance between the two y coordinates
  const yDistance = point2.y - point1.y;

  // Use the Pythagorean theorem to calculate the distance
  return Math.sqrt(xDistance ** 2 + yDistance ** 2);
}

// The function to find the coordinate of the point
// in the new coordinate system with the origin
// at the bottom left corner of the joypad.
//
// This function is only used to recalculate the
// coordinates of the joystick when the user moves the
// joystick past the joypad circle.
function findCoordinate(
  position: { x: number; y: number },
  distance: number,
  angle: number,
  radius: number,
) {
  //

  // Initialise the new coordinate object
  const newCoordinate = { x: 0, y: 0 };

  // Convert the angle to radians for the calculation
  angle = degreesToRadians(angle);

  // Set the new x coordinate to be the current position
  // plus the distance times the cosine of the angle,
  // which gives the distance in the x direction.
  newCoordinate.x = position.x + distance * Math.cos(angle);

  // Set the new y coordinate to be the current position
  // plus the distance times the sine of the angle,
  // which gives the distance in the y direction.
  newCoordinate.y = position.y + distance * Math.sin(angle);

  // If the new y coordinate ends up being less than 0,
  // due to a negative angle,
  // add the radius to the y coordinate so it will
  // always be positive.
  if (newCoordinate.y < 0) newCoordinate.y += radius;

  // Return the new coordinate object
  return newCoordinate;
}

// The joystick component
const Joystick = ({
  onStart,
  onMove,
  onStop,
  joypadColour = "#000000",
  nubColour = "#ff0000",
  radius = 150,
  disable = false,
  delayInMs = 1000,
  style,
  ...props
}: JoystickProps) => {
  //

  // Initialise the radius of the circle
  // containing the joystick, called the joypad
  const joypadRadius = radius;

  // Initialise the nub radius of the joystick
  const nubRadius = radius / 3;

  // Initialise the previous move time
  const [previousMoveTime, setPreviousMoveTime] = useState(Date.now());

  // Initialise the x and y coordinates of the joystick
  // to the centre of the joypad.
  //
  // The coordinate system used is the same as
  // the mathematical one, where the origin is
  // at the bottom left corner of the joypad.
  //
  // The positions of all elements are taken from the bottom left point
  const [x, setX] = useState(joypadRadius - nubRadius);
  const [y, setY] = useState(joypadRadius - nubRadius);

  // The function to handle a touch move event
  const handleTouchMove = useCallback(
    (event: GestureTouchEvent) => {
      //

      // Get the touch data
      const touchData = event.changedTouches[0];

      // Get the raw x and y coordinates of the finger
      const fingerXCoordinate = touchData.x;

      // If the platform is the web, use the diameter of the wrapper
      // minus the current y coordinate of the finger
      const fingerYCoordinate =
        Platform.OS === "web" ? joypadRadius * 2 - touchData.y : touchData.y;

      // Initialise the coordinates object
      // to hold the x and y coordinates.
      //
      // Subtract the radius of the nub from the
      // raw finger x and y coordinates to
      // get the coordinates in the new coordinate system,
      // where the origin is at bottom left corner of the joypad.
      let coordinates = {
        x: fingerXCoordinate - nubRadius,
        y: fingerYCoordinate - nubRadius,
      };

      // Calculate the angle of the line joining the joystick position
      // and the centre of the joypad from the positive x axis
      const angleFromPositiveXAxis = calculateAngleOfLineFromPositiveXAxis(
        { x: fingerXCoordinate, y: fingerYCoordinate },
        { x: joypadRadius, y: joypadRadius },
      );

      // Calculate the distance between the current position of the joystick
      // and the centre of the joypad
      let distance = calculateDistance(
        { x: fingerXCoordinate, y: fingerYCoordinate },
        { x: joypadRadius, y: joypadRadius },
      );

      // Set the distance to the minimum between the calculated distance
      // and the joypad radius.
      // The distance shouldn't be larger than the joypad radius.
      distance = Math.min(distance, joypadRadius);

      // Calculate the force applied by the user.
      // This is entirely arbitrary.
      const force = distance / (nubRadius * 2);

      // If the distance is equal to the joypad radius
      if (distance === joypadRadius) {
        //

        // Recalculate the correct coordinates
        // for the position of the joystick so that it
        // doesn't go past the joypad circle.
        coordinates = findCoordinate(
          { x: joypadRadius, y: joypadRadius },
          distance,
          angleFromPositiveXAxis,
          radius,
        );

        // Subtract the nub radius from the calculated
        // coordinates to place the nub in the correct position
        coordinates = {
          x: coordinates.x - nubRadius,
          y: coordinates.y - nubRadius,
        };
      }

      // Set the x and y coordinates to the coordinates calculated above
      setX(coordinates.x);
      setY(coordinates.y);

      // If the onMove function is not defined,
      // or the joystick is disabled,
      // or if the current time minus the
      // previous move time is less than the delay in ms,
      // exit the function
      if (!onMove || disable || Date.now() - previousMoveTime < delayInMs)
        return;

      // Otherwise, call the onMove function
      // with the current position
      onMove({
        force: force,

        // Add the nub radius back to the coordinates
        // so that the position is never negative
        // and will follow the coordinate system
        // with the origin at the bottom left corner
        position: {
          x: coordinates.x + nubRadius,
          y: coordinates.y + nubRadius,
        },
        angle: {
          radians: degreesToRadians(angleFromPositiveXAxis),
          degrees: angleFromPositiveXAxis,
        },
        type: "move",
      });

      // Set the previous move time to the current time
      setPreviousMoveTime(Date.now());
    },
    [joypadRadius, nubRadius, disable, delayInMs, previousMoveTime],
  );

  // The function to handle the touch start event
  function handleTouchStart() {
    //

    // If the onStart function is not defined,
    // or the joystick is disabled,
    // exit the function
    if (!onStart || disable) return;

    // Otherwise, call the onStart function
    // with the starting position
    onStart({
      force: 0,
      position: {
        x: 0,
        y: 0,
      },
      angle: {
        radians: 0,
        degrees: 0,
      },
      type: "start",
    });
  }

  // The function to handle the touch end event
  function handleTouchEnd() {
    //

    // Set the x and y coordinates to the joypad radius minus the nub radius
    // to place the nub in the centre of the joypad
    setX(joypadRadius - nubRadius);
    setY(joypadRadius - nubRadius);

    // If the onStop function is not defined,
    // or the joystick is disabled,
    // exit the function
    if (!onStop || disable) return;

    // Otherwise, call the onStop function
    // with the ending position
    onStop({
      force: 0,
      position: {
        x: 0,
        y: 0,
      },
      angle: {
        radians: 0,
        degrees: 0,
      },
      type: "stop",
    });
  }

  // Create the pan gesture and attach all the touch event handlers to it
  const panGesture = Gesture.Pan()
    .onStart(handleTouchStart)
    .onEnd(handleTouchEnd)
    .onTouchesMove(handleTouchMove);

  // Create the styles for the joystick
  const styles = useMemo(
    () =>
      StyleSheet.create({
        joypad: {
          width: 2 * radius,
          height: 2 * radius,
          borderRadius: radius,
          backgroundColor: `${joypadColour}${disable ? "23" : "55"}`,
          transform: [{ rotateX: "180deg" }],
          ...(style && typeof style === "object" ? style : {}),
        },
        nub: {
          height: 2 * nubRadius,
          width: 2 * nubRadius,
          borderRadius: nubRadius,
          backgroundColor: `${nubColour}${disable ? "89" : "bb"}`,
          position: "absolute",
          transform: [{ translateX: x }, { translateY: y }],
        },
      }),
    [radius, joypadColour, nubColour, disable, nubRadius, x, y],
  );

  // Return the joystick component
  return (
    <GestureDetector gesture={panGesture}>
      <View style={styles.joypad} {...props}>
        <View pointerEvents="none" style={styles.nub}></View>
      </View>
    </GestureDetector>
  );
};

// Export the Joystick component by default
export default Joystick;
