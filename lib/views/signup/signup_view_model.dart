import 'package:flutter/foundation.dart';
import 'package:eshop/core/locator.dart';
import 'package:eshop/core/services/authentication_service.dart';
import 'package:eshop/core/services/dialog_service.dart';
import 'package:eshop/core/services/navigation_service.dart';
import 'package:eshop/core/base/base_view_model.dart';
import 'package:eshop/constants/route_names.dart';

class SignUpViewModel extends BaseViewModel {
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
        _navigationService.pushReplacementNamed(HomeViewRoute);
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
