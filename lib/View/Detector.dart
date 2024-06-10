import 'package:flutter/material.dart';

class Detector extends StatelessWidget {
  final String detectedText;

  const Detector({Key? key, required this.detectedText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detected Text'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            detectedText,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
