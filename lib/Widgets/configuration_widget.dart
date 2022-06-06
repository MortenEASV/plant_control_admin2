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
    return Row(
      children: [
        SizedBox(
            width: widget.width /2,
            height: 200,
            child: Column(
              children: [
                const CustomTextFormFieldWidget(hintText: "Id", enabled: false),
                CustomSwitchWidget(configEnabled: widget.configEnabled)
              ],
            ),
          ),
        const Padding(padding: EdgeInsets.all(5)),
        SizedBox(
            width: widget.width /2,
            height: 200,
            child: Column(
              children: const [
                CustomTextFormFieldWidget(hintText: "HubUrl"),
                CustomTextFormFieldWidget(hintText: "RestUrl"),
              ],
            ),
          ),

      ],
    );
  }
}
