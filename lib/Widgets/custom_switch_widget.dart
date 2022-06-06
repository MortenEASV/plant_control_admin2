import 'package:flutter/material.dart';

class CustomSwitchWidget extends StatefulWidget {
  CustomSwitchWidget({Key? key, required this.configEnabled}) : super(key: key);
  bool configEnabled;

  @override
  State<CustomSwitchWidget> createState() => CustomSwitchWidgetState();
}

class CustomSwitchWidgetState extends State<CustomSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(5)),
        SizedBox(
          width: double.infinity,
          child: Switch(value: widget.configEnabled , onChanged: (bool value) {
            widget.configEnabled = value;
            setState(() {});
          },
          ),
        ),
      ],
    );
  }
}
