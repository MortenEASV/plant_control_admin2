import 'package:flutter/material.dart';
import 'package:ini/ini.dart';
import 'package:plant_control_admin/Widgets/custom_switch_widget.dart';
import 'package:plant_control_admin/Widgets/custom_text_button.dart';
import 'package:plant_control_admin/Widgets/custom_textformfield_widget.dart';
import 'package:plant_control_admin/enumerators.dart';

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
                          validationType: ValidationType.objectID,
                          readonly: true,
                          width: 100,
                          hintText: "Logger ID",
                          labelText: 'Logger ID',
                          enabled: widget.piConnected,
                          text: widget.config.get("Logging", "LoggerId")!,
                          onTextChanged: (text) =>
                              widget.config.set("Logging", "LoggerId", text)),
                      CustomTextFormFieldWidget(
                          validationType: ValidationType.objectID,
                          width: 100,
                          hintText: "Pairing ID",
                          labelText: 'Pairing ID',
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
                      validationType: ValidationType.ip,
                      hintText: "e.g. 40.87.132.220:9093",
                      labelText: "Hub Address",
                      enabled: widget.piConnected,
                      text: widget.config.get("Logging", "SocketUrl")!,
                      onTextChanged: (text) =>
                          widget.config.set("Logging", "SocketUrl", text)),
                  CustomTextFormFieldWidget(
                      validationType: ValidationType.ip,
                      hintText: "e.g. 40.87.132.220:9092",
                      labelText: "Rest Address",
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
                      validationType: ValidationType.numbers,
                      hintText: "Min Humidity",
                      labelText: 'Min Humidity',
                      enabled: widget.piConnected,
                      text: widget.config.get("Air", "MinHumid")!,
                      onTextChanged: (text) =>
                          widget.config.set("Air", "MinHumid", text)),
                  CustomTextFormFieldWidget(
                      validationType: ValidationType.numbers,
                      hintText: "Min Temperature",
                      labelText: "Min Temperature",
                      enabled: widget.piConnected,
                      text: widget.config.get("Air", "MinTemp")!,
                      onTextChanged: (text) =>
                          widget.config.set("Air", "MinTemp", text)),
                  CustomTextFormFieldWidget(
                      validationType: ValidationType.numbers,
                      hintText: "Moist",
                      labelText: "Moist",
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
                        validationType: ValidationType.numbers,
                        hintText: "Max Humidity",
                        labelText: "Max Humidity",
                        enabled: widget.piConnected,
                        text: widget.config.get("Air", "MaxHumid")!,
                        onTextChanged: (text) =>
                            widget.config.set("Air", "MaxHumid", text)),
                    CustomTextFormFieldWidget(
                        validationType: ValidationType.numbers,
                        hintText: "Max Temperature",
                        labelText: "Max Temperature",
                        enabled: widget.piConnected,
                        text: widget.config.get("Air", "MaxTemp")!,
                        onTextChanged: (text) =>
                            widget.config.set("Air", "MaxTemp", text)),
                    CustomTextFormFieldWidget(
                        validationType: ValidationType.numbers,
                        hintText: "Dry",
                        labelText: "Dry",
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
