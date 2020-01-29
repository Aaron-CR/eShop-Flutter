import 'package:eshop/constants/route_names.dart';
import 'package:eshop/core/locator.dart';
import 'package:eshop/core/services/authentication_service.dart';
import 'package:eshop/core/services/navigation_service.dart';
import 'package:eshop/core/base/base_view_model.dart';

class StartUpViewModel extends BaseViewModel {
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
