import 'package:dash/screen/pages/web/widgets/body_content_widget.dart';
import 'package:dash/screen/pages/web/widgets/right_side_widget.dart';
import 'package:dash/screen/pages/web/widgets/web_vertical_nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DesktopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (_, sizingInformation) {
      return Scaffold(
        body: Row(
          children: [
            WebVerticalNavWidget(),
            BodyContentWidget(
                sizingInformation: sizingInformation,
                key: Key('body_content_widget')),
            RightSideWidget()
          ],
        ),
      );
    });
  }
}
