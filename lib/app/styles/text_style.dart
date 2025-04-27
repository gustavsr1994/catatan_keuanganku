import 'package:flutter/material.dart';

TextStyle textSmallXtra(
    {required Color fontColor,
    bool isBold = false,
    bool isLineThrough = false}) {
  return TextStyle(
      color: fontColor,
      fontSize: 7,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      decoration:
          isLineThrough ? TextDecoration.lineThrough : TextDecoration.none);
}

TextStyle textSmall(
    {required Color fontColor,
    bool isBold = false,
    bool isLineThrough = false}) {
  return TextStyle(
      color: fontColor,
      fontSize: 10,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      decoration:
          isLineThrough ? TextDecoration.lineThrough : TextDecoration.none);
}

TextStyle textNormal(
    {required Color fontColor,
    bool isBold = false,
    bool isLineThrough = false}) {
  return TextStyle(
      color: fontColor,
      fontSize: 14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      decoration:
          isLineThrough ? TextDecoration.lineThrough : TextDecoration.none);
}

TextStyle textMedium(
    {required Color fontColor,
    bool isBold = false,
    bool isLineThrough = false}) {
  return TextStyle(
      color: fontColor,
      fontSize: 16,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      decoration:
          isLineThrough ? TextDecoration.lineThrough : TextDecoration.none);
}

TextStyle textLarge(
    {required Color fontColor,
    bool isBold = false,
    bool isLineThrough = false}) {
  return TextStyle(
      color: fontColor,
      fontSize: 20,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      decoration:
          isLineThrough ? TextDecoration.lineThrough : TextDecoration.none);
}

TextStyle textLargeXtra(
    {required Color fontColor,
    bool isBold = false,
    bool isLineThrough = false}) {
  return TextStyle(
      color: fontColor,
      fontSize: 23,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      decoration:
          isLineThrough ? TextDecoration.lineThrough : TextDecoration.none);
}

TextStyle textLargeSuper(
    {required Color fontColor,
    bool isBold = false,
    bool isLineThrough = false}) {
  return TextStyle(
      color: fontColor,
      fontSize: 40,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      decoration:
          isLineThrough ? TextDecoration.lineThrough : TextDecoration.none);
}
