import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eshop/services/auth.dart';
import 'package:eshop/shared/constants.dart';
import 'package:eshop/utils/background.dart';
import 'package:eshop/utils/email_validator.dart';
import 'package:eshop/widgets/circular_button.dart';
import 'package:eshop/widgets/input.dart';
import 'package:eshop/widgets/rounded_button.dart';

class AuthenticateScreen extends StatefulWidget {
  AuthenticateScreen({Key key}) : super(key: key);

  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLogin = true;
  String _email;
  String _password;
  String _displayName;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context);
    return Container(
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Background(),
            Container(
              child: SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    _isLogin ? _signIn(user) : _signUp(user),
                    _socialButtonsRow(user),
                    _footerBotton(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _signIn(AuthService user) {
    return Column(
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
                validator: (value) =>
                    !isEmail(value) ? 'Enter a valid email address' : null,
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
                    if (!await user.signInUser(_email, _password)) {
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text(
                              "Your email and password combination does not match a eShop account. Please try again."),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget forgotPasswordButton() {
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(
                    "Sorry this feature is not available right now. Please try again later."),
              ),
            );
          },
          child: Text(
            'Forgot Password?',
            style: kLabelStyle,
          ),
        ),
      ),
    );
  }

  Widget _signUp(AuthService user) {
    return Column(
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
                validator: (value) => value.isEmpty ? 'Enter an name' : null,
                hintText: 'Enter your name',
                icon: Icons.person,
                onChanged: (value) {
                  setState(() {
                    _displayName = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              CustomTextFormField(
                validator: (value) =>
                    !isEmail(value) ? 'Enter a valid email address' : null,
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
              SizedBox(height: 10.0),
              RoundedButton(
                text: 'Register',
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if (!await user.signUpUser(
                        _email, _password, _displayName)) {
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content:
                              Text("Something went wrong. Please try again."),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _socialButtonsRow(user) {
    return Column(
      children: <Widget>[
        Text(
          _isLogin ? '- Or Sign In with -' : '- Or Sign Up with -',
          style: kWhiteTextStyle,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // TODO: implements facebool login
              // Facebook
              CircularButton(
                onPressed: () {
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text(
                          "Sorry this feature is not available right now. Please try again later."),
                    ),
                  );
                },
                image: 'assets/images/facebook-logo.png',
                color: Color(0xFF4267B2),
              ),
              SizedBox(width: 10.0),
              // Google
              CircularButton(
                onPressed: () async {
                  if (!await user.signInWithGoogle()) {
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text("Something is wrong"),
                      ),
                    );
                  }
                },
                image: 'assets/images/google-logo.png',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _footerBotton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isLogin = !_isLogin;
        });
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: _isLogin ? 'Need an Account? ' : 'Already Have Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: _isLogin ? 'Sign Up' : 'Sign In',
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
