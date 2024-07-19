// The joystick component to control the car

import React, { useState, useCallback, useMemo } from "react";
import { Platform } from "react-native";
import { GestureTouchEvent } from "react-native-gesture-handler";


// The function to convert from degrees to radians
function degreesToRadians(degrees: number) {
    return degrees * (Math.PI / 180);
}


// The function to convert from radians to degrees
function radiansToDegrees(radians: number) {
    return radians * (180 / Math.PI);
}


// The function to calculate the distance between two points
function calculateDistance(
  point1: { x: number; y: number },
  point2: { x: number; y: number },
) {

    // Get the distance between the two x coordinates
    const distanceX = point2.x - point1.x;

    // Get the distance between the two y coordinates
    const distanceY = point2.y - point1.y;

    // Return the distance between the two points
    // using Pythagoras' Theorem
    return Math.sqrt(Math.pow(distanceX, 2) + Math.pow(distanceY, 2));
}


// The function to calculate the angle between two points
// from the origin of the joystick pad
// in degrees
function calculateAngle(
    point1: { x: number; y: number },
    point2: { x: number; y: number },
) {

    // Get the distance between the two x coordinates
    const distanceX = point2.x - point1.x;

    // Get the distance between the two y coordinates
    const distanceY = point2.y - point1.y;

    // Get the angle between the two points using arctan
    const angleInDegrees = radiansToDegrees(Math.atan2(distanceY, distanceX));

    // If the angle is negative, then return 180 - angle
    if (angleInDegrees < 0) return 180 - Math.abs(angleInDegrees);

    // Otherwise, return the 180 + the angle
    else return 180 + angleInDegrees;
}


// The joystick component
export const Joystick = ({
  onStart,
  onMove,
  onStop,
  colour = "#000000",
  radius,
  style,
  ...props
}) => {

  // Get the radius of the pad for the joystick
  const padRadius = radius;

  // Get the radius of the nub for the joystick
  const nubRadius = padRadius / 3;

  // Initialise the state to store the x and y coordinates
  const [x, setX] = useState(padRadius - nubRadius);
  const [y, setY] = useState(padRadius - nubRadius);

  // Function to handle when the joystick is moved
  const handleMove = useCallback((event: GestureTouchEvent) => {

    // Get the touch data
    const touchData = event.changedTouches[0];

    // Get the x and y coordinates
    const xCoordinate = touchData.x;
    const yCoordinate =
      Platform.OS === "web" ? padRadius * 2 - touchData.y : touchData.y;
  });
};
