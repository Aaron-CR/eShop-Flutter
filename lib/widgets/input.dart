import 'package:eshop/shared/constants.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input(
      {Key key,
      @required this.onChanged,
      @required this.icon,
      @required this.hintText,
      @required this.validator,
      this.keyboardType,
      this.obscureText})
      : super(key: key);

  final bool obscureText;
  final Function onChanged;
  final Function validator;
  final TextInputType keyboardType;
  final IconData icon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
        ),
        TextFormField(
          validator: validator,
          obscureText: obscureText == null ? false : true,
          onChanged: onChanged,
          keyboardType:
              keyboardType == null ? TextInputType.text : keyboardType,
          style: TextStyle(
            color: Colors.black54,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                icon,
                color: Colors.black54,
              ),
              hintText: hintText,
              hintStyle: kHintTextStyle,
              errorStyle: TextStyle(color: Colors.red[50])),
        ),
      ],
    );
  }
}
