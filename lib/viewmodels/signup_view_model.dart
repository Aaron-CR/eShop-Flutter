import 'package:eshop/constants/route_names.dart';
import 'package:eshop/locator.dart';
import 'package:eshop/services/authentication_service.dart';
import 'package:eshop/services/dialog_service.dart';
import 'package:eshop/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String _selectedRole = 'Select a User Role';
  String get selectedRole => _selectedRole;

  void setSelectedRole(dynamic role) {
    _selectedRole = role;
    notifyListeners();
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String displayName,
  }) async {
    setBusy(true);
    var authResult = await _authenticationService.signUpWithEmail(
      email: email,
      password: password,
      displayName: displayName,
      userRole: _selectedRole,
    );
    setBusy(false);
    if (authResult is bool) {
      if (authResult) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: authResult,
      );
    }
  }
}
