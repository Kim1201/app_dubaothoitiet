import 'package:app_dubaothoitiet/screens/home_screen.dart';
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios,size: 30,),
              ),
            ),
            const Expanded(
              child: Center(
                child: SmoothCompass(
                  rotationSpeed: 200,
                  height: 300,
                  width: 300,
                ),
              ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false);
          },
          backgroundColor: Colors.grey,
          child: const Icon(
            Icons.home,
          ),
        ),
      ),
    );
  }
}
