import 'package:flutter/material.dart';
import 'package:didatikids/screens/splash_screen.dart'; // Importando a SplashScreen animada
import 'package:didatikids/screens/login_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //SystemNavigator.pop();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DidatiKids',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: SplashScreen(),
    );
  }
}
