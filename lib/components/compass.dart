import 'package:flutter/material.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SmoothCompass(
          //higher the value of rotation speed slower the rotation
          rotationSpeed: 200,
          height: 300,
          width: 300,
        ),

      ),
    );


  }
}
