import 'package:flutter/material.dart';

import 'custom_button_widget.dart';

class CustomSwitchWidget extends StatefulWidget {
  CustomSwitchWidget({Key? key, required this.configEnabled}) : super(key: key);
  bool configEnabled;

  Color color = Colors.lightBlue;
  Color textColor = Colors.black;
  final isSelected = <bool>[false, false];

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
          child: ToggleButtons(
            fillColor: widget.color,
            selectedColor: widget.textColor,
            isSelected: widget.isSelected,
            children: [CustomButtonWidget(text: 'Active', width: 100.0), CustomButtonWidget(text: 'Inactive', width: 100.0)],
            onPressed: (index) {
              switch(index){
                case 0:
                  widget.color = Colors.lightBlue;
                  widget.isSelected[0] = true;
                  widget.isSelected[1] = false;
                  break;
                case 1:
                  widget.color = Colors.redAccent;
                  widget.isSelected[0] = false;
                  widget.isSelected[1] = true;
                  break;
              }
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
