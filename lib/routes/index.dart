
import 'package:daily_one_meal/pages/Home/home.dart';
import 'package:flutter/material.dart';

Widget getRootWidget() {
  return MaterialApp(

    //命名路由
    initialRoute: "/home",
    routes: getRootRoutes(),
    debugShowCheckedModeBanner: false,
  );
}

// 返回路由表
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    '/home': (context) => const HomePage(),
  };
}