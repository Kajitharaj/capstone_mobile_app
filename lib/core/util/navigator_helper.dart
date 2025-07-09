import 'package:capstone_mobile_app/core/shared/enum/snackbar_enum.dart';
import 'package:flutter/material.dart';

class NavigatorHelper {
  static final NavigatorHelper _instance = NavigatorHelper._internal();

  BuildContext? _parentContext;

  // Private constructor
  NavigatorHelper._internal();

  // Factory constructor for singleton access
  factory NavigatorHelper() => _instance;

  // Set parent context
  void setParentContext(BuildContext context) {
    _parentContext = context;
  }

  // Get parent context
  BuildContext? get parentContext => _parentContext;

  showSnackBar({String message = '', SnackBarType type = SnackBarType.info}) {
    ScaffoldMessenger.of(_parentContext!).clearMaterialBanners();
    ScaffoldMessenger.of(_parentContext!).showMaterialBanner(
      MaterialBanner(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: getBannerColor(type),
        actions: [
          IconButton(
            onPressed: () => ScaffoldMessenger.of(
              _parentContext!,
            ).hideCurrentMaterialBanner(),
            icon: Icon(Icons.close, color: Colors.white),
          ),
        ],
        elevation: 5,
      ),
    );

    Future.delayed(Duration(seconds: 5), () {
      ScaffoldMessenger.of(_parentContext!).hideCurrentMaterialBanner();
    });
  }

  Color getBannerColor(SnackBarType type) => switch (type) {
    SnackBarType.error => Colors.redAccent,
    SnackBarType.warning => Colors.orangeAccent,
    SnackBarType.success => Colors.green,
    SnackBarType.info => Colors.blueAccent,
  };
}
