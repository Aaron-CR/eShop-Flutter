import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eshop/shared/shared_styles.dart';

// TODO: add empty validator as default
class InputField extends StatefulWidget {
  final Function(String) validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;
  final IconData icon;
  final Function enterPressed;
  final FocusNode fieldFocusNode;
  final FocusNode nextFocusNode;
  final TextInputAction textInputAction;
  final TextInputFormatter formatter;

  InputField({
    @required this.controller,
    @required this.hintText,
    this.icon,
    this.enterPressed,
    this.fieldFocusNode,
    this.nextFocusNode,
    this.onChanged,
    this.validator,
    this.formatter,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: fieldHeight,
          decoration: kBoxDecorationStyle,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                validator: widget.validator,
                keyboardType: widget.keyboardType,
                obscureText: obscureText,
                controller: widget.controller,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  errorStyle: kErrorTextStyle,
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: kHintTextStyle,
                  prefixIcon: Icon(
                    widget.icon,
                    color: Colors.black54,
                  ),
                ),
                textInputAction: widget.textInputAction,
                focusNode: widget.fieldFocusNode,
                inputFormatters:
                    widget.formatter != null ? [widget.formatter] : null,
                onEditingComplete: () {
                  if (widget.enterPressed != null) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    widget.enterPressed();
                  }
                },
                onFieldSubmitted: (value) {
                  if (widget.nextFocusNode != null) {
                    widget.nextFocusNode.requestFocus();
                  }
                },
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                obscureText = !obscureText;
              }),
              child: widget.obscureText
                  ? Container(
                      width: fieldHeight,
                      height: fieldHeight,
                      alignment: Alignment.center,
                      child: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black54,
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ],
    );
  }
}
