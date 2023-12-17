import 'package:dash/screen/pages/mobile/mobile_screen.dart';
import 'package:dash/screen/pages/tablet/tablet_screen.dart';
import 'package:dash/screen/pages/web/desktop_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isDesktop) {
          return DesktopScreen();
        }
        if (sizingInformation.isTablet) {
          return TabletScreen();
        }
        return MobileScreen();
      },
    );
  }
}
