import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plant_control_admin/Widgets/barcode_widget.dart';
import 'package:plant_control_admin/Widgets/configuration_widget.dart';
import 'package:plant_control_admin/Widgets/raspberry_status_widget.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../ViewModels/home_page_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var vm = HomePageViewModel.instance;
    vm.addListener(() {
      setState((){});
    });
    var raspsize = 200.0;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 600,
            child: Column(
              children: [
                RaspberryStatusWidget(connected: vm.connected, size: raspsize),
                ConfigurationWidget(
                    width: 450, config: vm.config, piConnected: vm.connected),
              ],
            ),
          ),
          //Vertical line
          Container(height: screenHeight, width: 0.5, color: Colors.black),

          SizedBox(width: 300, child: BarcodeWidget(img: vm.img, qrSize: 200.0))
        ],
      ),
    );
  }
}
