import 'package:eshop/theme/theme.dart';
import 'package:flutter/material.dart';

/// A modal overlay that will show over your child widget (fullscreen) when the show value is true
///
/// Wrap your scaffold in this widget and set show value to model.isBusy to show a loading modal when
/// your model state is Busy
class BusyOverlay extends StatelessWidget {
  final Widget child;
  final bool show;

  const BusyOverlay({this.child, this.show = false});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: <Widget>[
          child,
          IgnorePointer(
            child: Opacity(
              opacity: show ? 0.7 : 0.0,
              child: Container(
                width: screenSize.width,
                height: screenSize.height,
                alignment: Alignment.center,
                color: colorScheme.surface,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(strokeWidth: 3),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
