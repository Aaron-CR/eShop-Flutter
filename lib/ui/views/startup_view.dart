import 'package:eshop/ui/shared/app_colors.dart';
import 'package:eshop/ui/shared/ui_helpers.dart';
import 'package:eshop/viewmodels/startup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ViewModelProvider<StartUpViewModel>.withConsumer(
        viewModel: StartUpViewModel(),
        onModelReady: (model) => model.handleStartUpLogic(),
        builder: (context, model, child) => Scaffold(
          backgroundColor: kMainColor,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: screenWidth(context) * 0.2,
                  height: screenHeight(context) * 0.7,
                  child: Image.asset('assets/images/launch_image.png'),
                ),
                CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(
                    Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
