import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static const String _iconPath = 'assets/icons/';

  static const String cubic = '${_iconPath}cubic.svg';
  static const String challenge = '${_iconPath}challenge.svg';
  static const String tasks = '${_iconPath}tasks.svg';
  static const String settings = '${_iconPath}settings.svg';

  static Widget svg(
    String assetName, {
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
    );
  }
}
