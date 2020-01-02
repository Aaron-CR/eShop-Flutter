import 'package:eshop/services/auth.dart';
import 'package:eshop/shared/constants.dart';
import 'package:eshop/utils/background_image.dart';
import 'package:eshop/utils/email_validator.dart';
import 'package:eshop/widgets/circular_button.dart';
import 'package:eshop/widgets/input.dart';
import 'package:eshop/widgets/rounded_button.dart';
import 'package:eshop/widgets/social_buttons_row.dart';
import 'package:eshop/utils/spinner.dart';
import 'package:flutter/material.dart';
import 'package:eshop/shared/constants_routes.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context);
    return Container(
      child: isLoading
          ? Spinner()
          : Scaffold(
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 120.0),
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
                                Input(
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
                                Input(
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
                                forgotPasswordButton(),
                                RoundedButton(
                                  text: 'Login',
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() => isLoading = true);
                                      dynamic result = await user.signInUser(
                                          email, password);
                                      if (result == null) {
                                        setState(() {
                                          error =
                                              'Your email and password combination does not match a eshop account. Please try again.';
                                          isLoading = false;
                                        });
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
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircularButton(
                                          onPressed: () {},
                                          image:
                                              'assets/images/facebook-logo.png',
                                          color: Color(0xFF4267B2)),
                                      SizedBox(width: 10.0),
                                      CircularButton(
                                        onPressed: () async {
                                          if (!await user.signInWithGoogle())
                                            _key.currentState
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text("Something is wrong"),
                                            ));
                                        },
                                        image: 'assets/images/google-logo.png',
                                      ),
                                    ],
                                  ),
                                ),
                                signUpButton(),
                                SizedBox(height: 12.0),
                                // TODO: implement Snackbar
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
