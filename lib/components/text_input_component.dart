import 'package:flutter/material.dart';

class TextInputComponent extends StatefulWidget {
  final String label;
  final Function validator;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool readOnly;
  final Widget? suffixIcon;
  final Function handleTap;
  final Color mainColor;
  final bool hideText;
  final String hint;

  const TextInputComponent({
    super.key,
    required this.label,
    required this.validator,
    required this.inputType,
    required this.controller,
    required this.readOnly,
    required this.suffixIcon,
    required this.handleTap,
    required this.mainColor,
    required this.hideText,
    required this.hint,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TextInputComponentState createState() => _TextInputComponentState();
}

class _TextInputComponentState extends State<TextInputComponent> {
  final TextEditingController _fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Label
        Container(
          padding: EdgeInsets.all(5),
          alignment: Alignment.bottomLeft,
          child: Text(
            widget.label,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),

        //Input
        TextFormField(
          cursorColor: widget.mainColor,
          style: TextStyle(color: widget.mainColor),
          controller: _fieldController,
          obscureText: widget.hideText,

          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: widget.mainColor, width: 0.0),
            ),
            fillColor: Colors.white,
            filled: true,

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: widget.mainColor, width: 1.5),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: widget.mainColor, width: 1.0),
            ),

            suffixIcon: widget.suffixIcon,
          ),

          readOnly: widget.readOnly ? true : false,
          //onTap: () => widget.handleTap(context),
          onTap: () => widget.handleTap(),

          keyboardType: widget.inputType,

          validator: (value) {
            return widget.validator(value);
          },
        ),
      ],
    );
  }
}
