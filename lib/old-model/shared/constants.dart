import 'package:flutter/material.dart';

final kMainColor = Color(0xFFE84444);

final kWhiteTextStyle = TextStyle(
  color: Colors.white,
);
final kBlackTextStyle = TextStyle(
  color: Colors.black54,
);

final kHintTextStyle = TextStyle(
  color: Colors.black54,
  fontFamily: 'OpenSans',
);

final kErrorTextStyle = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.w400,
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
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
