import 'package:flutter/material.dart';

// TODO: Reorganize and refactor styles

// Box Decorations

BoxDecoration fieldDecortaion =
    BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white);

BoxDecoration disabledFieldDecortaion = BoxDecoration(
    borderRadius: BorderRadius.circular(10), color: Colors.grey[100]);

BoxDecoration kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

// Field Variables

const double fieldHeight = 50;
const double smallFieldHeight = 40;
const double inputFieldBottomMargin = 30;
const double inputFieldSmallBottomMargin = 0;
const EdgeInsets fieldPadding = EdgeInsets.symmetric(horizontal: 15);
const EdgeInsets largeFieldPadding =
    const EdgeInsets.symmetric(horizontal: 15, vertical: 15);

// Text Variables

const TextStyle buttonTitleTextStyle = TextStyle(
  color: Colors.white,
  letterSpacing: 1.1,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

const kWhiteTextStyle = TextStyle(
  color: Colors.white,
);
const kBlackTextStyle = TextStyle(
  color: Colors.black54,
);

const kHintTextStyle = TextStyle(
  color: Colors.black54,
  fontFamily: 'OpenSans',
);

const kErrorTextStyle = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.w400,
);

const kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);
