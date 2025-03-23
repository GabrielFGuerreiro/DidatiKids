import 'package:didatikids/components/button_component.dart';
import 'package:didatikids/components/text_input_component.dart';
import 'package:didatikids/themes/standart.dart';
import 'package:didatikids/utils/form_utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var frameWidth = MediaQuery.of(context).size.width * 0.80;
    var frameHeight = MediaQuery.of(context).size.height * 0.60;

    return Scaffold(
      body: Container(
        color: backgroundMainColor,
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Logo
            Container(
              width: 500,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Image.asset('assets/images/title_logo.png'),
            ),

            // Frame lilás
            Container(
              width: frameWidth,
              height: frameHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: backgroundSecondColor,
              ),
              padding: const EdgeInsets.fromLTRB(50, 40, 50, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: Stack(
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Super Funnel',
                              fontSize: 50,
                              color: yellow,
                            ),
                          ),
                          // Text(
                          //   'Log in',
                          //   style: TextStyle(
                          //     fontFamily: 'Super Funnel',
                          //     fontSize: 50,
                          //     foreground:
                          //         Paint()
                          //           ..style = PaintingStyle.stroke
                          //           ..strokeWidth = 1
                          //           ..color = Colors.white,
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    //Input email
                    TextInputComponent(
                      label: 'e-mail',
                      validator: (value) => validateEmail(value),
                      inputType: TextInputType.emailAddress,
                      controller: _emailController,
                      readOnly: false,
                      suffixIcon: null,
                      handleTap: () => {},
                      mainColor: inputMainColor,
                      hideText: false,
                      hint: '',
                    ),

                    SizedBox(height: 5),

                    //Input senha
                    TextInputComponent(
                      label: 'senha',
                      validator: (value) => validatePassword(value),
                      inputType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      readOnly: false,
                      suffixIcon: null,
                      handleTap: () => {},
                      mainColor: inputMainColor,
                      hideText: true,
                      hint: '',
                    ),

                    //Botão esqueceu a senha
                    Container(
                      alignment: Alignment.centerLeft,
                      child: ButtonComponent(
                        isTextButton: true,
                        text: 'Esqueceu a senha?',
                        mainColor: yellow,
                        secondColor: Colors.black,
                        handlePress: () => handlePasswordButton(context),
                        minWidth: 0,
                      ),
                    ),

                    SizedBox(height: 30),

                    //Botao enviar
                    ButtonComponent(
                      isTextButton: false,
                      text: 'Entrar',
                      mainColor: buttonColor,
                      secondColor: Colors.white,
                      handlePress:
                          () => handleSubmitLoginButton(
                            _formKey,
                            context,
                            _emailController,
                            _passwordController,
                          ),
                      minWidth: double.infinity,
                    ),

                    //Botao cadastro
                    ButtonComponent(
                      isTextButton: true,
                      text: 'Fazer cadastro',
                      mainColor: yellow,
                      secondColor: Colors.black,
                      handlePress: () => handleSignInButton(context),
                      minWidth: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
