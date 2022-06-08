import 'package:flutter/material.dart';
import 'package:ini/ini.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  CustomTextFormFieldWidget(
      {Key? key,
      required this.hintText,
      this.enabled = true,
      this.width = 200,
      this.text = "",
      required this.onTextChanged,
      this.validateNumbers = false})
      : super(key: key);
  final String hintText;
  final String text;
  final bool enabled;
  final double width;
  final Function onTextChanged;
  final bool validateNumbers;

  final TextEditingController textEditingController = TextEditingController();

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  @override
  initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(5)),
          Focus(
            onFocusChange: (hasFocus) {
              if (!hasFocus) widget.onTextChanged(widget.textEditingController.text);
            },
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field cannot be empty';
                }
                if (widget.validateNumbers) {
                  if (!RegExp(r'^\d+(\.\d+)*$').hasMatch(value)) {
                    return 'Field only accepts numbers';
                  }
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.textEditingController..text = widget.text,
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
          ),
        ],
      ),
    );
  }
}
