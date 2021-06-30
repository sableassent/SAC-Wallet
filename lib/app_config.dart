import 'package:flutter/material.dart';
import 'package:sac_wallet/util/api_config.dart';

class AppConfig extends InheritedWidget {
  final ApiConfig config;

  AppConfig({this.config, Widget child}) : super(child: child);

  static AppConfig of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppConfig);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
