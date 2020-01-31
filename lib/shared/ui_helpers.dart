import 'package:flutter/material.dart';

// TODO: Document UI Helpers

Widget horizontalSpace(double height) => SizedBox(width: height);
const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceMedium = SizedBox(width: 20.0);
const Widget horizontalSpaceLarge = SizedBox(width: 40.0);
const Widget horizontalSpaceMassive = SizedBox(width: 120.0);

Widget verticalSpace(double height) => SizedBox(height: height);
const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceMedium = SizedBox(height: 20.0);
const Widget verticalSpaceLarge = SizedBox(height: 40.0);
const Widget verticalSpaceMassive = SizedBox(height: 120.0);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

Orientation orientation(BuildContext context) =>
    MediaQuery.of(context).orientation;

bool isPortrait(BuildContext context) =>
    orientation(context) == Orientation.portrait;

double screenHeightFraction(BuildContext context,
        {double dividedBy = 1, double offsetBy = 0}) =>
    (screenHeight(context) - offsetBy) / dividedBy;

double screenWidthFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0}) =>
    (screenWidth(context) - offsetBy) / dividedBy;
