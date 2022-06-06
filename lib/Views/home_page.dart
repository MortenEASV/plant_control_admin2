import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plant_control_admin/Widgets/configuration_widget.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("This is major tom to plant control"),
            OutlinedButton(onPressed: () {
              vm.pressed();
              setState(() {
                vm.img = vm.img;
              });
            }, child: Text("Press me homie")),
            ConfigurationWidget(

            ),
            PrettyQr(
              image: vm.img,
              typeNumber: 6,
              size: 200,
              data: '629b4aa3b0c62559fbc7226a',
              errorCorrectLevel: QrErrorCorrectLevel.M,
              roundEdges: false,
            ),
          ],
        ),
      ),
    );
  }
}
