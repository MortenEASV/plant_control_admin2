import 'package:flutter/material.dart';
import 'package:ini/ini.dart';
import 'package:plant_control_admin/Widgets/custom_switch_widget.dart';
import 'package:plant_control_admin/Widgets/custom_text_button.dart';
import 'package:plant_control_admin/Widgets/custom_textformfield_widget.dart';

class ConfigurationWidget extends StatefulWidget {
  const ConfigurationWidget(
      {Key? key,
      required this.width,
      required this.config,
      required this.piConnected,
      required this.registerOnPressed})
      : super(key: key);

  final double width;
  final double padding = 5.0;
  final bool piConnected;
  final Function registerOnPressed;

  //Config parameters
  final Config config;

  @override
  _ConfigurationWidgetState createState() => _ConfigurationWidgetState();
}

class _ConfigurationWidgetState extends State<ConfigurationWidget> {
  @override
  initState() {
    super.initState();
  }

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
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.all(6)),
                        CustomTextFormFieldWidget(
                            width: 100,
                            hintText: "Logger ID",
                            enabled: false,
                            text: widget.config.get("Logging", "LoggerId")!,
                            onTextChanged: (text) =>
                                widget.config.set("Logging", "LoggerId", text)),
                        CustomTextFormFieldWidget(
                            width: 100,
                            hintText: "Pairing ID",
                            enabled: widget.piConnected,
                            text: widget.config.get("Logging", "PairingId")!,
                            onTextChanged: (text) => widget.config
                                .set("Logging", "PairingId", text)),
                      ],
                    ),
                    CustomSwitchWidget(
                        config: widget.config,
                        width: 200,
                        text1: 'Active',
                        text2: 'Inactive',
                        piConnected: widget.piConnected,
                        isSelected: List<bool>.of({
                          widget.config
                                  .get("Logging", "Active")!
                                  .toLowerCase() ==
                              "true",
                          !(widget.config
                                  .get("Logging", "Active")!
                                  .toLowerCase() ==
                              "true")
                        })),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(widget.padding)),
              SizedBox(
                width: widget.width / 2,
                height: 150,
                child: Column(
                  children: [
                    CustomTextFormFieldWidget(
                        hintText: "Hub Url",
                        enabled: widget.piConnected,
                        text: widget.config.get("Logging", "HubUrl")!,
                        onTextChanged: (text) =>
                            widget.config.set("Logging", "HubUrl", text)),
                    CustomTextFormFieldWidget(
                        hintText: "Rest Url",
                        enabled: widget.piConnected,
                        text: widget.config.get("Logging", "RestUrl")!,
                        onTextChanged: (text) =>
                            widget.config.set("Logging", "RestUrl", text)),
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
                    CustomTextFormFieldWidget(
                        hintText: "Min Humidity",
                        enabled: widget.piConnected,
                        text: widget.config.get("Air", "MinHumid")!,
                        onTextChanged: (text) =>
                            widget.config.set("Air", "MinHumid", text)),
                    CustomTextFormFieldWidget(
                        hintText: "Min Temperature",
                        enabled: widget.piConnected,
                        text: widget.config.get("Air", "MinTemp")!,
                        onTextChanged: (text) =>
                            widget.config.set("Air", "MinTemp", text)),
                    CustomTextFormFieldWidget(
                        hintText: "Moist",
                        enabled: widget.piConnected,
                        text: widget.config.get("Soil", "Moist")!,
                        onTextChanged: (text) =>
                            widget.config.set("Soil", "Moist", text)),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(widget.padding)),
              SizedBox(
                width: widget.width / 2,
                child: Column(
                  children: [
                    CustomTextFormFieldWidget(
                        hintText: "Max Humidity",
                        enabled: widget.piConnected,
                        text: widget.config.get("Air", "MaxHumid")!,
                        onTextChanged: (text) =>
                            widget.config.set("Air", "MaxHumid", text)),
                    CustomTextFormFieldWidget(
                        hintText: "Max Temperature",
                        enabled: widget.piConnected,
                        text: widget.config.get("Air", "MaxTemp")!,
                        onTextChanged: (text) =>
                            widget.config.set("Air", "MaxTemp", text)),
                    CustomTextFormFieldWidget(
                        hintText: "Dry",
                        enabled: widget.piConnected,
                        text: widget.config.get("Soil", "Dry")!,
                        onTextChanged: (text) =>
                            widget.config.set("Soil", "Dry", text)),
                  ],
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(widget.padding)),
          CustomTextButton(
              text: "Register",
              onPressed: () {
                widget.registerOnPressed();
              }),
        ],
      ),
    );
  }
}
