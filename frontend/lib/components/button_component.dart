import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget{

  final bool isTextButton;
  final String text;
  final Color mainColor;
  final Color secondColor;
  final Function handlePress;
  final double minWidth;

  const ButtonComponent({
    super.key, 
    required this.isTextButton,
    required this.text,
    required this.mainColor,
    required this.secondColor,
    required this.handlePress,
    required this.minWidth
    });

  @override
  Widget build(BuildContext context) {

    var elevatedButton = ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth,
          minHeight: 50
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            foregroundColor: secondColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
          ),
          onPressed: () { handlePress(); },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18
            )
          ),
          ),
        );

    var textButton = TextButton(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(mainColor)
      ),
      onPressed: () { handlePress(); },
      child: Text(text, style: TextStyle(fontSize: 16),),
    );
          

    return isTextButton ? textButton : elevatedButton;
  }
}