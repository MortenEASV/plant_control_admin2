import 'package:flutter/material.dart';
import 'package:ini/ini.dart';
class CustomTextFormFieldWidget extends StatefulWidget {
  CustomTextFormFieldWidget(
      {Key? key, required this.hintText, this.enabled = true, this.width = 200, this.text = "", required this.onTextChanged})
      : super(key: key);
  final String hintText;
  final String text;
  final bool enabled;
  final double width;
  final Function onTextChanged;
  @override
  State<CustomTextFormFieldWidget> createState() => _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(5)),
          TextFormField(
            onChanged: (text){
              widget.onTextChanged(text);
            },
            initialValue: widget.text,
            decoration: InputDecoration(
              labelText: widget.hintText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: widget.hintText,
              fillColor: Colors.grey,
              border: const OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.black),
                borderRadius: BorderRadius.zero,
              ),
            ),
            enabled: widget.enabled,
          ),
        ],
      ),
    );
  }
}
