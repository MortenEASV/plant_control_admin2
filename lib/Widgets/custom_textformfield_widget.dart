import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget(
      {Key? key, required this.hintText, this.enabled = true, this.width = 200})
      : super(key: key);
  final String hintText;
  final bool enabled;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(5)),
          TextFormField(
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.grey,
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.black),
                borderRadius: BorderRadius.zero,
              ),
            ),
            enabled: enabled,
          ),
        ],
      ),
    );
  }
}
