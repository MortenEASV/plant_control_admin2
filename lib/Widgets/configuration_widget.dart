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
      required this.registerOnPressed,
      required this.saveOnPressed})
      : super(key: key);

  final double width;
  final double padding = 5.0;
  final bool piConnected;
  final Function registerOnPressed;
  final Function saveOnPressed;

  //Config parameters
  final Config config;

  @override
  _ConfigurationWidgetState createState() => _ConfigurationWidgetState();
}

class _ConfigurationWidgetState extends State<ConfigurationWidget> {
  @override
  Widget build(BuildContext context) {
    print('building conf');
    return SizedBox(
      width: widget.width,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      CustomTextFormFieldWidget(
                          width: 100,
                          hintText: "Logger ID",
                          enabled: widget.piConnected,
                          text: widget.config.get("Logging", "LoggerId")!,
                          onTextChanged: (text) =>
                              widget.config.set("Logging", "LoggerId", text)),
                      CustomTextFormFieldWidget(
                          width: 100,
                          hintText: "Pairing ID",
                          enabled: widget.piConnected,
                          text: widget.config.get("Logging", "PairingId")!,
                          onTextChanged: (text) =>
                              widget.config.set("Logging", "PairingId", text)),
                    ],
                  ),
                  CustomSwitchWidget(
                    config: widget.config,
                    width: 200,
                    text1: 'Active',
                    text2: 'Inactive',
                    piConnected: widget.piConnected,
                  )
                ],
              ),
              Padding(padding: EdgeInsets.all(widget.padding)),
              Column(
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
            ],
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children: [
              Column(
                children: [
                  CustomTextFormFieldWidget(
                      validateNumbers: true,
                      hintText: "Min Humidity",
                      enabled: widget.piConnected,
                      text: widget.config.get("Air", "MinHumid")!,
                      onTextChanged: (text) =>
                          widget.config.set("Air", "MinHumid", text)),
                  CustomTextFormFieldWidget(
                      validateNumbers: true,
                      hintText: "Min Temperature",
                      enabled: widget.piConnected,
                      text: widget.config.get("Air", "MinTemp")!,
                      onTextChanged: (text) =>
                          widget.config.set("Air", "MinTemp", text)),
                  CustomTextFormFieldWidget(
                      validateNumbers: true,
                      hintText: "Moist",
                      enabled: widget.piConnected,
                      text: widget.config.get("Soil", "Moist")!,
                      onTextChanged: (text) =>
                          widget.config.set("Soil", "Moist", text)),
                ],
              ),
              Padding(padding: EdgeInsets.all(widget.padding)),
              SizedBox(
                child: Column(
                  children: [
                    CustomTextFormFieldWidget(
                        validateNumbers: true,
                        hintText: "Max Humidity",
                        enabled: widget.piConnected,
                        text: widget.config.get("Air", "MaxHumid")!,
                        onTextChanged: (text) =>
                            widget.config.set("Air", "MaxHumid", text)),
                    CustomTextFormFieldWidget(
                        validateNumbers: true,
                        hintText: "Max Temperature",
                        enabled: widget.piConnected,
                        text: widget.config.get("Air", "MaxTemp")!,
                        onTextChanged: (text) =>
                            widget.config.set("Air", "MaxTemp", text)),
                    CustomTextFormFieldWidget(
                        validateNumbers: true,
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
          SizedBox(
            width: 210,
            child: Row(
              children: [
                CustomTextButton(
                    text: "Save",
                    onPressed: () {
                      widget.saveOnPressed();
                    }),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: widget.padding)),
                CustomTextButton(
                    text: "Register",
                    onPressed: () {
                      widget.registerOnPressed();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
