import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({Key? key, required this.text, required this.width}) : super(key: key);
  final width;
  final text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width,child: Center(child: Text(text)));
  }
}
