import 'package:eshop/constants/route_names.dart';
import 'package:eshop/services/authentication_service.dart';
import 'package:eshop/services/dialog_service.dart';
import 'package:eshop/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import '../locator.dart';
import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signInWithEmail(
      {@required String email, @required String password}) async {
    setBusy(true);
    var authResult = await _authenticationService.signInWithEmail(
        email: email, password: password);
    setBusy(false);
    if (authResult is bool) {
      if (authResult) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign In Failure',
          description: 'General sign ing failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign In Failure',
        description: authResult,
      );
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(SignUpViewRoute);
  }
}
