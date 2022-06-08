import 'package:flutter/material.dart';
import 'package:plant_control_admin/Widgets/custom_text_button.dart';

class AlertWidget extends StatelessWidget {
  const AlertWidget({Key? key, required this.text, required this.onPressed, required this.title}) : super(key: key);

  final String text;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        CustomTextButton(text: "OK", onPressed: onPressed),
      ],
    );
  }
}
