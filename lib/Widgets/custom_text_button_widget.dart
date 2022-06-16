import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(5)),
        SizedBox(
          height: 50,
          width: 100,
          child: RawMaterialButton(
            shape: const ContinuousRectangleBorder(
                side: BorderSide(color: Colors.grey, width: 0.5)),
            onPressed: () => onPressed(),
            child: Text(text,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal)),
          ),
        ),
      ],
    );
  }
}
