import 'package:eshop/services/auth.dart';
import 'package:eshop/shared/constants.dart';
import 'package:eshop/utils/background.dart';
import 'package:eshop/utils/email_validator.dart';
import 'package:eshop/widgets/input.dart';
import 'package:eshop/widgets/rounded_button.dart';
import 'package:eshop/widgets/social_buttons_row.dart';
import 'package:eshop/utils/spinner.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key, this.user}) : super(key: key);
  final AuthService user;
  @override
  _SignUpScreenState createState() => _SignUpScreenState(user);
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService user;
  bool isLoading = false;
  String displayName = '';
  String email = '';
  String password = '';
  String error = '';

  _SignUpScreenState(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? Spinner()
          : Scaffold(
              key: _scaffoldKey,
              body: Stack(
                children: <Widget>[
                  Background(),
                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 100.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Sign Up',
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
                                  validator: (value) =>
                                      value.isEmpty ? 'Enter an name' : null,
                                  hintText: 'Enter your name',
                                  icon: Icons.person,
                                  onChanged: (value) {
                                    setState(() {
                                      displayName = value;
                                    });
                                  },
                                ),
                                SizedBox(height: 20.0),
                                CustomTextFormField(
                                  validator: (value) => !isEmail(value)
                                      ? 'Enter a valid email address'
                                      : null,
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: 'Enter your email',
                                  icon: Icons.email,
                                  onChanged: (value) {
                                    setState(() {
                                      email = value.trim();
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
                                      password = value;
                                    });
                                  },
                                ),
                                SizedBox(height: 20.0),
                                RoundedButton(
                                  text: 'Register',
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() => isLoading = true);
                                      dynamic result =
                                          await AuthService.instance()
                                              .signUpUser(
                                                  email, password, displayName);
                                      if (result == null) {
                                        setState(() {
                                          error =
                                              'Something went wrong, please try again';
                                          isLoading = false;
                                        });
                                      } else {
                                        Navigator.pop(context);
                                      }
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
                                SocialButtonsRow(
                                    scaffoldKey: _scaffoldKey, user: user),
                                signInButton(),
                                SizedBox(height: 12.0),
                                Text(
                                  error,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget signInButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already Have Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
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
