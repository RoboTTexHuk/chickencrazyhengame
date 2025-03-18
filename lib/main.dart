import 'package:chickencrazyhengame/loader.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FallingTextScreen(),
    );
  }
}

class FallingTextScreen extends StatefulWidget {
  @override
  _FallingTextScreenState createState() => _FallingTextScreenState();
}

class _FallingTextScreenState extends State<FallingTextScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Анимация падения текста
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Длительность падения
      vsync: this,
    );

    _animation = Tween<double>(begin: -100, end: 600).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward(); // Запуск анимации

    // Таймер для перехода на следующий экран
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomWebView()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // Красный фон
      body: Stack(
        children: [
          Positioned(
            top: _animation.value, // Падающий текст
            left: MediaQuery.of(context).size.width / 2 - 50, // Центр экрана
            child: Text(
              "Crazy Hen",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Синий фон для второго экрана
      body: Center(
        child: Text(
          "Welcome to the next screen!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}