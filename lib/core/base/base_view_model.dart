import 'package:flutter/widgets.dart';
import 'package:eshop/core/locator.dart';
import 'package:eshop/core/models/user_models.dart';
import 'package:eshop/core/services/authentication_service.dart';

class BaseViewModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  User get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
