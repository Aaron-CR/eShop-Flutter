import 'package:flutter/material.dart';

BoxDecoration backgroundImage() {
  return BoxDecoration(
    color: Colors.black87,
    image: DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/images/background/signup.jpg'),
    ),
  );
}
