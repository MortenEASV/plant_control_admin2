import 'package:flutter/material.dart';
import 'package:plant_control_admin/Widgets/custom_switch_widget.dart';
import 'package:plant_control_admin/Widgets/custom_textformfield_widget.dart';

class ConfigurationWidget extends StatefulWidget {
  const ConfigurationWidget(
      {Key? key,
      required this.width,
      required this.configId,
      required this.configEnabled,
      required this.configHubUrl,
      required this.configRestUrl})
      : super(key: key);

  final double width;
  final double padding = 5.0;

  //Config parameters
  final String configId;
  final String configHubUrl;
  final String configRestUrl;
  final bool configEnabled;

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
                    const CustomTextFormFieldWidget(
                        hintText: "Id", enabled: false),
                    CustomSwitchWidget(configEnabled: widget.configEnabled)
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(widget.padding)),
              SizedBox(
                width: widget.width / 2,
                height: 150,
                child: Column(
                  children: const [
                    CustomTextFormFieldWidget(hintText: "HubUrl"),
                    CustomTextFormFieldWidget(hintText: "RestUrl"),
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
                    children: const [
                      CustomTextFormFieldWidget(hintText: "Min Humidity"),
                      CustomTextFormFieldWidget(hintText: "Min Temperature"),
                      CustomTextFormFieldWidget(hintText: "Moist"),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(widget.padding)),
                SizedBox(
                  width: widget.width / 2,
                  child: Column(
                    children: const [
                      CustomTextFormFieldWidget(hintText: "Max Humidity"),
                      CustomTextFormFieldWidget(hintText: "Max Temperature"),
                      CustomTextFormFieldWidget(hintText: "Dry"),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
