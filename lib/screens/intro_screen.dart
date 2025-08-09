import 'package:airplane_prac/data/sp_helper.dart';
import 'package:airplane_prac/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String name = '';
  String image = 'Beach';

  @override
  void initState() {
    super.initState();
    final SPHelper helper = SPHelper();
    helper.getSettings().then((settings) {
      setState(() {
        name = settings['name'] ?? ''; //Unlike in the tutorial, had to move the setState inside of the then callback
        image = settings['image'] ?? 'Beach'; // due to the setState being called before the getSettings() could finish.
      });
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/$image.jpg", fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment(0, -0.5),
            child: Text(
              "Welcome $name",
              style: const TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  ),
                ],
                fontSize: 36,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const SettingsScreen(),
                  ),
                );
              },
              child: const Text("Select"),
            ),
          ),
        ],
      ),
    );
  }
}
