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
  var vm = HomePageViewModel.instance;
  @override
  initState(){
    super.initState();
    vm.addListener(() {
      setState((){});
    });
  }
  @override
  Widget build(BuildContext context) {
    print('building homepage');
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 600,
            child: Column(
              children: [
                RaspberryStatusWidget(connected: vm.connected, size: 200),
                const Padding(padding: EdgeInsets.all(5)),
                ConfigurationWidget(
                    width: 450, config: vm.config, piConnected: vm.connected, registerOnPressed: () => vm.registerOnClick(), saveOnPressed: () => vm.saveOnClick(),),
              ],
            ),
          ),
          //Vertical line
          Container(height: screenHeight, width: 0.5, color: Colors.black),

          BarcodeWidget(qrCenterImg: vm.qrCenterImg, size: 300.0, qrPlaceholderImg: vm.qrPlaceholderImg, content: vm.config.get("Logging", 'LoggerId')!)
        ],
      ),
    );
  }
}
