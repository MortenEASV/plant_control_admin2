import 'package:flutter/material.dart';
import 'package:ini/ini.dart';

class CustomSwitchWidget extends StatefulWidget {
  CustomSwitchWidget(
      {Key? key,
      required this.config,
      required this.width,
      required this.text1,
      required this.text2,
      required this.piConnected})
      : super(key: key);
  Config config;

  Color color = Colors.green;
  Color textColor = Colors.black;
  late List<bool> isSelected;
  final double width;
  final String text1;
  final String text2;
  final bool piConnected;
  bool initialized = false;

  @override
  State<CustomSwitchWidget> createState() => CustomSwitchWidgetState();
}

class CustomSwitchWidgetState extends State<CustomSwitchWidget> {

  @override
  Widget build(BuildContext context) {
    if (!widget.initialized) {
      widget.isSelected = List<bool>.of({
        widget.config
            .get("Logging", "Active")!
            .toLowerCase() ==
            "true",
        !(widget.config
            .get("Logging", "Active")!
            .toLowerCase() ==
            "true")
      });
      widget.initialized = true;
    }
    if(widget.isSelected[1]) widget.color = Colors.redAccent;
    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(5)),
        SizedBox(
          height: 53,
          child: ToggleButtons(
            fillColor: widget.color,
            selectedColor: widget.textColor,
            isSelected: widget.isSelected,
            children: [
              SizedBox(
                  width: widget.width / 2,
                  child: Center(child: Text(widget.text1))),
              SizedBox(
                  width: widget.width / 2,
                  child: Center(child: Text(widget.text2))),
            ],
            onPressed: (index) {
              if (!widget.piConnected) return;
              switch (index) {
                case 0:
                  widget.color = Colors.green;
                  widget.isSelected[0] = true;
                  widget.isSelected[1] = false;
                  widget.config.set("Logging", "Active", "True");
                  break;
                case 1:
                  widget.color = Colors.redAccent;
                  widget.isSelected[0] = false;
                  widget.isSelected[1] = true;
                  widget.config.set("Logging", "Active", "False");
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
