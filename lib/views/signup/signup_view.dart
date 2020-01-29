import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:eshop/views/signup/signup_view_model.dart';
import 'package:eshop/shared/email_validator.dart';
import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/widgets/background.dart';
import 'package:eshop/widgets/busy_button.dart';
import 'package:eshop/widgets/expansion_list.dart';
import 'package:eshop/widgets/input_field.dart';

class SignUpView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final displayNamController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModel: SignUpViewModel(),
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
                      'Sign Up',
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
                            hintText: 'Full Name',
                            controller: displayNamController,
                            icon: Icons.person,
                          ),
                          verticalSpaceMedium,
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
                          verticalSpaceMedium,
                          ExpansionList<String>(
                              items: ['Admin', 'User'],
                              title: model.selectedRole,
                              onItemSelected: model.setSelectedRole),
                          verticalSpaceMedium,
                        ],
                      ),
                    ),
                    BusyButton(
                      title: 'Register',
                      busy: model.busy,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          model.signUpWithEmail(
                            email: emailController.text.trim(),
                            password: passwordController.text,
                            displayName: displayNamController.text,
                          );
                        }
                      },
                    ),
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

/* 

InputField(
                hintText: 'Full Name',
                controller: displayNamController,
                icon: Icons.person,
              ),
              verticalSpaceSmall,
              InputField(
                hintText: 'Email',
                controller: emailController,
                icon: Icons.email,
              ),
              verticalSpaceSmall,
              InputField(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
                icon: Icons.lock,
              ),
              verticalSpaceMedium,
              ExpansionList<String>(
                  items: ['Admin', 'User'],
                  title: model.selectedRole,
                  onItemSelected: model.setSelectedRole),
              verticalSpaceMedium,
              BusyButton(
                title: 'Sign Up',
                busy: model.busy,
                onPressed: () {
                  model.signUpWithEmail(
                    email: emailController.text.trim(),
                    password: passwordController.text,
                    displayName: displayNamController.text,
                  );
                },
              )

 */
