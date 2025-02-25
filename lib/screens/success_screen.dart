// CHANGE TO ACTIVITIES SCREEN

import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final String email;
  final String password;

  const SuccessScreen({super.key, required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Success')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('✅ Form Submitted!', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              Text('email: $email', style: const TextStyle(fontSize: 18)),
              Text('password: $password', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
