import 'package:eshop/services/auth.dart';
import 'package:eshop/shared/constants.dart';
import 'package:eshop/utils/background_image.dart';
import 'package:eshop/utils/email_validator.dart';
import 'package:eshop/widgets/circular_button.dart';
import 'package:eshop/widgets/input.dart';
import 'package:eshop/widgets/rounded_button.dart';
import 'package:eshop/widgets/social_buttons_row.dart';
import 'package:flutter/material.dart';
import 'package:eshop/shared/constants_routes.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: backgroundImage(),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        CustomTextFormField(
                          validator: (value) => !isEmail(value)
                              ? 'Enter a valid email address'
                              : null,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Enter your email',
                          icon: Icons.email,
                          onChanged: (value) {
                            setState(() {
                              _email = value.trim();
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        CustomTextFormField(
                          validator: (value) => value.length < 6
                              ? 'Password must be at least 6 digits long'
                              : null,
                          obscureText: true,
                          hintText: 'Enter your password',
                          icon: Icons.lock,
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                        ),
                        forgotPasswordButton(),
                        RoundedButton(
                          text: 'Login',
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if (!await user.signInUser(_email, _password))
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                      "Your email and password combination does not match a eShop account. Please try again."),
                                ));
                            }
                          },
                        ),
                        Text(
                          '- Or Login with -',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SocialButtonsRow(user: user, scaffoldKey: _scaffoldKey),
                        signUpButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget forgotPasswordButton() {
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: GestureDetector(
          onTap: () => print('Forgot Password Button Pressed'),
          child: Text(
            'Forgot Password?',
            style: kLabelStyle,
          ),
        ),
      ),
    );
  }

  Widget signUpButton() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(signUpRoute),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Need an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: kMainColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
