import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkNavigation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? done = prefs.getBool("onboarding_done");

    await Future.delayed(const Duration(seconds: 2));

    if (done == true) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  void initState() {
    super.initState();
    checkNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("MOVIE APP", style: TextStyle(fontSize: 32)),
      ),
    );
  }
}
