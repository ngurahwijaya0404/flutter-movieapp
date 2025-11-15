import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? _status = "Initializing...";

  Future<void> checkNavigation() async {
    try {
      setState(() => _status = "Loading preferences...");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? done = prefs.getBool("onboarding_done");

      setState(() => _status = "Onboarding done: $done");
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        if (done == true) {
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          Navigator.pushReplacementNamed(context, '/onboarding');
        }
      }
    } catch (e) {
      print("Error in checkNavigation: $e");
      setState(() => _status = "Error: $e");
      // Fallback to onboarding
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("MOVIE APP", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            Text(_status ?? "", textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
