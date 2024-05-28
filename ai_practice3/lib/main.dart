import 'package:flutter/material.dart';
import 'package:ai_practice/second.dart';
import 'dart:io';

void main() async {
  print('23');
  Socket socket = await Socket.connect('10.0.2.2', 5000);
  print('23');
  runApp(MyApp(socket: socket));
}

class MyApp extends StatelessWidget {
  final Socket socket;

  const MyApp({required this.socket, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(socket: socket),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Socket socket;

  const HomeScreen({required this.socket, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BERSERK'),
        titleTextStyle: TextStyle(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'images/judong.jpg',
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondScreen(socket: socket)),
                  );
                },
                child: Text(
                  "시작하기",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(200, 50),
                  elevation: 20.0,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
