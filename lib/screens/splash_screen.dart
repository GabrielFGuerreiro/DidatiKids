import 'package:didatikids/themes/standart.dart';
import 'package:flutter/material.dart';
import 'package:didatikids/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double larguraQuadrado = 170; //Valores iniciais do quadro
  double alturaQuadrado = 170;
  bool icExpandir = false;

  @override
  void initState() {
    super.initState();
    comecarAnimacao();
  }

  void comecarAnimacao() {
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        icExpandir = true;
        larguraQuadrado = MediaQuery.of(context).size.width; //Expande a largura
        alturaQuadrado = MediaQuery.of(context).size.height; //Expande a altura
      });

      //Leva para a tela de login
      Future.delayed(Duration(milliseconds: 3000), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeInOut, //Suaviza a transição
              width: larguraQuadrado,
              height: alturaQuadrado,
              //padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: backgroungMainColor,
                borderRadius: BorderRadius.circular(
                  icExpandir ? 0 : 70, //Bordas normais qnd expandir
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo_sFundo.png',
              width: 170,
              height: 170,
            ),
          ),
          Positioned(
            top: 0,
            bottom: -700,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: icExpandir ? 1 : 0,
              duration: Duration(milliseconds: 1000),
              child: Image.asset('assets/images/title_sFundo.png', width: 500),
            ),
          ),
        ],
      ),
    );
  }
}
