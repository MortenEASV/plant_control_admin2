import 'package:flutter/material.dart';

class ConfigurationWidget extends StatefulWidget {
  const ConfigurationWidget({Key? key}) : super(key: key);

  @override
  _ConfigurationWidgetState createState() => _ConfigurationWidgetState();
}

class _ConfigurationWidgetState extends State<ConfigurationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(initialValue: "yooo",)
      ],
    );
  }
}
