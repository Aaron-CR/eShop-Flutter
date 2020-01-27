import 'package:eshop/constants/route_names.dart';
import 'package:eshop/locator.dart';
import 'package:eshop/services/authentication_service.dart';
import 'package:eshop/services/navigation_service.dart';
import 'package:eshop/viewmodels/base_model.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(HomeViewRoute);
    } else {
      _navigationService.navigateTo(LoginViewRoute);
    }
  }
}
