import  'package:flutter/material.dart';
import  'package:responsive_builder/responsive_builder.dart';

class SemnoxScreenUtils {
  SemnoxScreenUtils._() {
    ResponsiveSizingConfig.instance.setCustomBreakpoints(
      const ScreenBreakpoints(desktop: 800, tablet: 550, watch: 200),
    );
  }

  static T selectFromScreenSize<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    return getValueForScreenType<T>(
        context: context, mobile: mobile, tablet: tablet, desktop: desktop);
  }
}
