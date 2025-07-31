import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome Home"),),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/Beach.jpg", fit: BoxFit.cover),),
          Align(
            alignment: Alignment(0, -0.5),
            child: const Text("Welcome",
             style: TextStyle(
              color: Colors.white,
              shadows: [Shadow(
                color: Colors.black,
                blurRadius: 10,
                offset: Offset(5, 5)
              )],
              fontSize: 36))
          ),
          Align(
            alignment: Alignment(0, 0.5),
            child: ElevatedButton(
              onPressed: (){},
              child: const Text("Select")
            ),
          )
          ]),
    );
  }
}