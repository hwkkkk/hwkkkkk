import 'package:flutter/material.dart';
import 'dart:io';

class ThirdScreen extends StatefulWidget {
  final Socket socket;

  const ThirdScreen({Key? key, required this.socket}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  String disease = '';

  @override
  void initState() {
    super.initState();
    _setupSocketListener();
  }

  void _setupSocketListener() {
    widget.socket.listen(
          (List<int> data) {
        setState(() {
          disease = String.fromCharCodes(data);
        });
      },
      onError: (error) {
        print('Error: $error');
        widget.socket.destroy();
      },
      onDone: () {
        print('Connection closed');
        widget.socket.destroy();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BERSERK'),
        titleTextStyle: TextStyle(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text(disease),
      ),
    );
  }
}
