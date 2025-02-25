import 'package:didatikids/components/button_component.dart';
import 'package:didatikids/components/text_input_component.dart';
import 'package:didatikids/themes/standart.dart';
import 'package:didatikids/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:didatikids/services/supabase_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2026),
    );

    if (picked != null) {
      setState(() {
        _birthdayController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  Future<void> _submitForm() async {
    final tableName = 'tb_responsaveis';
    if (_formKey.currentState!.validate()) {
      try {
        var supabaseService = SupabaseService();
        await supabaseService.insertTableData(
          tableName,
          _nameController.text,
          _emailController.text,
          _passwordController.text,
          _birthdayController.text,
        );
      } catch (error) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(SnackBar(content: Text('Error inserting data: $error')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro na validação do formulário.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: backgroungMainColor,
        width: width,
        height: height,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Logo
            Container(
              width: 500,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Image.asset('images/title_logo.png'),
            ),
            Text(
              'Cadastro',
              style: TextStyle(
                fontFamily: 'Super Funnel',
                fontSize: 50,
                color: yellow,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextInputComponent(
                      label: 'Nome',
                      validator: (value) => validateName(value),
                      inputType: TextInputType.text,
                      controller: _nameController,
                      readOnly: false,
                      suffixIcon: null,
                      handleTap: () => {},
                      mainColor: inputMainColor,
                      hideText: false,
                      hint: '',
                    ),

                    const SizedBox(height: 16),

                    //Não abre o datepicker
                    TextInputComponent(
                      label: 'Data de nascimento',
                      validator: (value) => validateBirthday(value),
                      inputType: TextInputType.text,
                      controller: _birthdayController,
                      readOnly: true,
                      suffixIcon: Icon(Icons.calendar_today),
                      handleTap: _selectDate,
                      mainColor: inputMainColor,
                      hideText: false,
                      hint: '',
                    ),

                    const SizedBox(height: 16),

                    TextInputComponent(
                      label: 'E-mail',
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

                    const SizedBox(height: 16),

                    TextInputComponent(
                      label: 'Senha',
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

                    const SizedBox(height: 32),

                    ButtonComponent(
                      isTextButton: false,
                      text: 'Enviar',
                      mainColor: buttonColor,
                      secondColor: Colors.white,
                      handlePress:
                          () => _submitForm(),
                      minWidth: double.infinity,
                    ),

                    ButtonComponent(
                      isTextButton: true, 
                      text: 'Já possuo conta', 
                      mainColor: yellow, 
                      secondColor: Colors.black, 
                      handlePress: () => handleLoginButton(context), 
                      minWidth: 0)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
