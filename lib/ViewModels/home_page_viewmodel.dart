import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:dartssh2/dartssh2.dart';
import 'package:image/image.dart';

import '../Models/config.dart';

class HomePageViewModel with ChangeNotifier{
  //Singleton
  static final HomePageViewModel instance = HomePageViewModel._();

  HomePageViewModel._() {
    init();
  }

  var sshHost = "raspberrypi.local";
  var client;
  var img = const NetworkImage("https://www.kindpng.com/picc/m/63-636289_computer-chip-computer-chip-icon-png-transparent-png.png");

  //var img = NetworkImage("https://cdn-icons-png.flaticon.com/512/964/964748.png");
  bool connected = false;

  Config config = Config(
      logging: Logging(id: "", active: false, hubUrl: "", restUrl: ""),
      air: Air(minHumid: 0.0, maxHumid: 0.0, minTemp: 0.0, maxTemp: 0.0),
      soil: Soil(moist: 0.0, dry: 0.0));

  init() async {
    //Initialize network state listener
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result.name == "ethernet") {
        networkChange();
      }
    });
  }

  bool running = false;
  networkChange() async {
    if (running) return;  //Avoid spam calls
    running = true;
    try {
      //Connect to raspberry via SSH
      client = SSHClient(await SSHSocket.connect('raspberrypi.local', 22, timeout: const Duration(seconds: 2)),
          username: 'pi', onPasswordRequest: () => 'easv2021');

      connected = true;
    } catch (_) {
      connected = false;
    }
    notifyListeners();
    running = false;
  }

  pressed() {
    if (client == null) init();
  }
}
