
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:clock/clock.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _currentTime = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _updateTime() {
    // 使用 clock.now() 而不是 DateTime.now()
    // 这使得代码更容易测试，并且在不同平台（如鸿蒙）上行为一致
    final now = clock.now();
    
    // 格式化时间：HH:mm:ss
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');
    
    setState(() {
      _currentTime = '$hour:$minute:$second';
    });
  }

  Future<void> _initializeApp() async {

    // 初始化时立即更新一次时间，避免等待第一秒
    _updateTime();
    // 启动定时器，每秒更新一次
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
    
    // 3. 初始化完成后，移除启动屏
    FlutterNativeSplash.remove();
  }

  Widget _buildPage(String time) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '当前时间',
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              time,
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace', // 使用等宽字体使数字对齐更美观
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '日期: ${clock.now().year}-${clock.now().month.toString().padLeft(2, '0')}-${clock.now().day.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
  }
  @override
  void dispose() {
    // 重要：在组件销毁时取消定时器，防止内存泄漏
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(

      // SafeArea避开刘海等遮挡区域
      body: SafeArea(
        child: _buildPage(_currentTime),
      ),
    );
  }
}
