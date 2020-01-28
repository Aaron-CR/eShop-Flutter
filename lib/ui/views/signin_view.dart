import 'package:eshop/old-model/shared/constants.dart';
import 'package:eshop/old-model/utils/background.dart';
import 'package:eshop/old-model/widgets/circular_button.dart';
import 'package:eshop/ui/shared/email_validator.dart';
import 'package:eshop/ui/shared/ui_helpers.dart';
import 'package:eshop/ui/widgets/busy_button.dart';
import 'package:eshop/ui/widgets/input_field.dart';
import 'package:eshop/ui/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:eshop/viewmodels/signin_view_model.dart';

class SignInView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignInViewModel>.withConsumer(
      viewModel: SignInViewModel(),
      builder: (context, model, child) => Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Background(),
              SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
                child: Column(
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
                    verticalSpaceLarge,
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          InputField(
                            validator: (value) => !isEmail(value)
                                ? 'Enter a valid email address'
                                : null,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'Enter your email',
                            controller: emailController,
                            icon: Icons.email,
                          ),
                          verticalSpaceMedium,
                          InputField(
                            validator: (value) => value.length < 6
                                ? 'Password must be at least 6 digits long'
                                : null,
                            hintText: 'Enter your password',
                            obscureText: true,
                            controller: passwordController,
                            icon: Icons.lock,
                          ),
                        ],
                      ),
                    ),
                    forgotPasswordButton(),
                    BusyButton(
                      title: 'Login',
                      busy: model.busy,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          model.signInWithEmail(
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          );
                        }
                      },
                    ),
                    verticalSpaceMedium,
                    Column(
                      children: <Widget>[
                        Text(
                          '- Or Sign In with -',
                          style: kWhiteTextStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // TODO: implements facebool login
                              // Facebook
                              CircularButton(
                                onPressed: () {
                                  model.signInWithFacebook();
                                },
                                image: 'assets/images/facebook-logo.png',
                                color: Color(0xFF4267B2),
                              ),
                              verticalSpaceSmall,
                              // Google
                              CircularButton(
                                onPressed: () {
                                  model.signInWithGoogle();
                                },
                                image: 'assets/images/google-logo.png',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceMedium,
                    TextLink(
                      'Create an Account if you\'re new.',
                      onPressed: () {
                        model.navigateToSignUp();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: replace this for TextLink WIdget
Widget forgotPasswordButton() {
  return Container(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    ),
  );
}
/* 

 */
