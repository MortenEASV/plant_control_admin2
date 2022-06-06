import 'package:flutter/material.dart';
import 'package:plant_control_admin/Widgets/custom_switch_widget.dart';
import 'package:plant_control_admin/Widgets/custom_text_button.dart';
import 'package:plant_control_admin/Widgets/custom_textformfield_widget.dart';

import '../Models/config.dart';

class ConfigurationWidget extends StatefulWidget {
  const ConfigurationWidget(
      {Key? key,
      required this.width,
      required this.config,
      required this.piConnected})
      : super(key: key);

  final double width;
  final double padding = 5.0;
  final bool piConnected;

  //Config parameters
  final Config config;

  @override
  _ConfigurationWidgetState createState() => _ConfigurationWidgetState();
}

class _ConfigurationWidgetState extends State<ConfigurationWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width + widget.padding * 2,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: widget.width / 2,
                height: 150,
                child: Column(
                  children: [
                    CustomSwitchWidget(
                        config: widget.config,
                        width: 200,
                        text1: 'Active',
                        text2: 'Inactive', piConnected: widget.piConnected),
                    const CustomTextFormFieldWidget(hintText: "Id", enabled: false),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(widget.padding)),
              SizedBox(
                width: widget.width / 2,
                height: 150,
                child: Column(
                  children: [
                    CustomTextFormFieldWidget(hintText: "Hub Url", enabled: widget.piConnected),
                    CustomTextFormFieldWidget(hintText: "Rest Url", enabled: widget.piConnected),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: widget.width / 2,
                child: Column(
                  children: [
                    CustomTextFormFieldWidget(hintText: "Min Humidity", enabled: widget.piConnected),
                    CustomTextFormFieldWidget(hintText: "Min Temperature", enabled: widget.piConnected),
                    CustomTextFormFieldWidget(hintText: "Moist", enabled: widget.piConnected),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(widget.padding)),
              SizedBox(
                width: widget.width / 2,
                child: Column(
                  children: [
                    CustomTextFormFieldWidget(hintText: "Max Humidity", enabled: widget.piConnected),
                    CustomTextFormFieldWidget(hintText: "Max Temperature", enabled: widget.piConnected),
                    CustomTextFormFieldWidget(hintText: "Dry", enabled: widget.piConnected),
                  ],
                ),
              ),
            ],
          ),
          CustomTextButton(text: "Register", onPressed: () => {}),
        ],
      ),
    );
  }
}
