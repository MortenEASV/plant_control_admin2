import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget(
      {Key? key, required this.hintText, this.enabled = true})
      : super(key: key);
  final String hintText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(5)),
          TextFormField(
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.grey,
              border: const OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.blue),
              ),
            ),
            enabled: enabled,
          ),
        ],
      ),
    );
  }
}
