import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: RawMaterialButton(
        shape: const ContinuousRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 0.5)),
        onPressed: () {},
        child: Text(text,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.normal)),
      ),
    );
  }
}
