import 'package:daily_one_meal/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {

  // 1. 确保绑定初始化
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  
  // 2. 保持原生启动屏显示
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(getRootWidget());
}
