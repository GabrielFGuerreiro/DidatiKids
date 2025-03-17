import 'package:didatikids/themes/standart.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String email;
  final String password;

  const ProfileScreen({super.key, required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('', style: TextStyle(color: Colors.white)),
        backgroundColor: backgroungMainColor,
      ),
      body: Container(color: backgroungMainColor),
    );
  }
}
