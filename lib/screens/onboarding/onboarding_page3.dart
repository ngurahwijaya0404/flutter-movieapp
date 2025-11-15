import 'package:flutter/material.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.play_circle_fill, size: 120),
        SizedBox(height: 20),
        Text("Mulai Jelajahi Sekarang",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text("Login & nikmati rekomendasi film terbaru."),
      ],
    );
  }
}
