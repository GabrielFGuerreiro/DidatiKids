import 'package:didatikids/components/text_input_component.dart';
import 'package:didatikids/themes/standart.dart';
import 'package:didatikids/utils/form_utils.dart';
import 'package:flutter/material.dart';

class AddProfile extends StatefulWidget {
  const AddProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var frameWidth = MediaQuery.of(context).size.width * 0.80;
    var frameHeight = MediaQuery.of(context).size.height * 0.60;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: backgroundMainColor, size: 30),
        title: Text(
          'Adicionar Perfil',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Super Funnel',
            color: backgroundMainColor,
          ),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        color: backgroundMainColor,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: frameWidth,
                height: frameHeight,
                child: Column(
                  children: [
                    TextInputComponent(
                      label: 'Nome',
                      validator: (value) => null,
                      inputType: TextInputType.name,
                      controller: _nameController,
                      readOnly: false,
                      suffixIcon: null,
                      handleTap: () => {},
                      mainColor: inputMainColor,
                      hideText: false,
                      hint: '',
                    ),

                    SizedBox(height: 5),

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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
