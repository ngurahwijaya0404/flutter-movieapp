import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Sign in untuk melanjutkan"),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.error, color: Colors.red),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      child: Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _errorMessage = null);
                      },
                      child: const Text("Tutup"),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: _isLoading ? const SizedBox.shrink() : const Icon(Icons.login),
              label: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text("Sign in with Google"),
              onPressed: _isLoading
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                        _errorMessage = null;
                      });

                      try {
                        print("Login button clicked, starting sign in process...");
                        await auth.signInWithGoogle();
                        if (mounted) {
                          print("Sign in successful, navigating to home...");
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      } catch (e) {
                        print("Sign in failed: $e");
                        if (mounted) {
                          String errorMsg = e.toString();
                          // Clean up error message
                          if (errorMsg.contains("Exception: ")) {
                            errorMsg = errorMsg.replaceAll("Exception: ", "");
                          }
                          setState(() {
                            _isLoading = false;
                            _errorMessage = errorMsg;
                          });
                          print("Error message set: $_errorMessage");
                        }
                      }
                    },
            ),
            if (_isLoading) ...[
              const SizedBox(height: 20),
              const Text(
                "Menunggu respons Firebase...",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )
            ]
          ],
        ),
      ),
    );
  }
}
