import 'dart:io';

import 'package:flutter/material.dart';

class RaspberryStatusWidget extends StatefulWidget {
  const RaspberryStatusWidget({Key? key, required this.connected, required this.size}) : super(key: key);
  final bool connected;
  final double size;

  @override
  _RaspberryStatusWidgetState createState() => _RaspberryStatusWidgetState();
}

class _RaspberryStatusWidgetState extends State<RaspberryStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.connected?  //Conditional widget
      Column(children:[ //True
        Image.file(File("assets/raspberry-connected.png"), width: widget.size),
        const Text("Connection established")
      ]):
      Column(children:[ //False
          Image.file(File("assets/raspberry-disconnected.png"), width: 200),
          const Text("Please connect the data logger via ethernet cable")
        ])


    );
  }
}
