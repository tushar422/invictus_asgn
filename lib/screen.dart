import 'package:flutter/material.dart';
import 'package:invictus_asgn/gradient.dart';

class NextScreen extends StatelessWidget {
  const NextScreen({super.key, required this.success});

  final bool success;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              (success) ? 'asset/welcome.png' : 'asset/error.png',
              height: 200,
            ),
            const SizedBox(height: 20),
            GradientText(
              (success) ? 'Welcome User' : 'User already exists!',
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 210, 21, 78),
                  Color.fromRGBO(254, 104, 84, 1),
                ],
              ),
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
