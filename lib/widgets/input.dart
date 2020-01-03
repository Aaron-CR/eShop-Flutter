import 'package:eshop/shared/constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final bool obscureText;
  final Function onChanged;
  final Function validator;
  final TextInputType keyboardType;
  final IconData icon;
  final String hintText;

  const CustomTextFormField(
      {Key key,
      @required this.icon,
      @required this.hintText,
      @required this.onChanged,
      @required this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: kBoxDecorationStyle,
          height: 50.0,
        ),
        TextFormField(
          validator: validator,
          obscureText: obscureText,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: TextStyle(
            color: Colors.black54,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: kHintTextStyle,
            errorStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            prefixIcon: Icon(
              icon,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
