import 'package:capstone_mobile_app/capstone_app.dart';
import 'package:capstone_mobile_app/core/di/service_locator.dart';
import 'package:capstone_mobile_app/core/util/env_util.dart';
import 'package:flutter/material.dart';

void main() async {
  await EnvUtil.init();
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const CapstoneApp());
}
