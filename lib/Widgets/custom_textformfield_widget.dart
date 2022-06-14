import 'package:flutter/material.dart';

import '../enumerators.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  CustomTextFormFieldWidget(
      {Key? key,
      required this.hintText,
      required this.labelText,
      this.enabled = true,
      this.width = 200,
      this.text = "",
      required this.onTextChanged,
      this.validationType = ValidationType.none,
      this.readonly = false})
      : super(key: key);
  final String hintText;
  final String labelText;
  final String text;
  final bool enabled;
  final bool readonly;
  final double width;
  final Function onTextChanged;
  final ValidationType validationType;

  final TextEditingController textEditingController = TextEditingController();

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  @override
  initState() {
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
                if (value == null) return null;
                switch (widget.validationType) {
                  case ValidationType.numbers:
                    if (!RegExp(r'^\d+(\.\d+)*').hasMatch(value) ||
                        value.isEmpty) {
                      return 'Only numbers allowed';
                    }
                    break;
                  case ValidationType.ip:
                    if (!RegExp(r'^\d+(\.\d+)*:\d{1,6}$').hasMatch(value) ||
                        value.isEmpty) {
                      return 'Valid format: 0.0.0.0:0000';
                    }
                    break;
                  case ValidationType.objectID:
                    if (!RegExp(r'^[a-f\d]{24}$').hasMatch(value) &&
                        value.isNotEmpty) {
                      return 'Only object IDs allowed';
                    }
                    break;
                  default:
                    return null;
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.textEditingController..text = widget.text,
              decoration: InputDecoration(
                labelText: widget.labelText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: widget.hintText,
                fillColor: Colors.grey,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.zero,
                ),
              ),
              enabled: widget.enabled,
              readOnly: widget.readonly,
            ),
          ),
        ],
      ),
    );
  }
}
