import 'package:flutter/material.dart';

void main() {
  runApp(const Gemmy());
}

class Gemmy extends StatelessWidget {
  const Gemmy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemmy',
      theme: ThemeData(fontFamily: 'NotoSans'),
      home: const Scaffold(
        body: Center(
          child: Text(
            'Hi mom!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
