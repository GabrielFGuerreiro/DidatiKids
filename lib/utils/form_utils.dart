import 'package:didatikids/screens/login_screen.dart';
import 'package:didatikids/screens/signin_screen.dart';
import 'package:didatikids/screens/profile_screen.dart';
import 'package:flutter/material.dart';

String? validateName(value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, insira seu nome';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, insira seu e-mail';
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'E-mail inválido';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, insira sua senha';
  }
  return null;
}

String? validateBirthday(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, selecione uma data';
  }
  return null;
}

void handleSubmitLoginButton(
  GlobalKey<FormState> formKey,
  BuildContext context,
  TextEditingController emailController,
  TextEditingController passwordController,
) {
  if (!formKey.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('E-mail ou senha incorretos, tente novamente.'),
      ),
    );
  } else {
    // Envia para o banco de dados, entra no sistema
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ProfileScreen(
              email: emailController.text,
              password: passwordController.text,
            ),
      ),
    );
  }
  emailController.clear();
  passwordController.clear();
}

void handleSignInButton(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SignInScreen()),
  );
}

void handleLoginButton(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );
}

void handlePasswordButton(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SignInScreen()),
  );
}
