import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:dartssh2/dartssh2.dart';
import 'package:image/image.dart';
import 'package:ini/ini.dart';



class HomePageViewModel with ChangeNotifier {
  //Singleton
  static final HomePageViewModel instance = HomePageViewModel._();

  HomePageViewModel._() {
    init();
  }

  var sshHost = "raspberrypi.local";
  late SSHClient client;
  var img = const NetworkImage(
      "https://www.kindpng.com/picc/m/63-636289_computer-chip-computer-chip-icon-png-transparent-png.png");

  //var img = NetworkImage("https://cdn-icons-png.flaticon.com/512/964/964748.png");
  bool connected = false;
  bool configRead = false;
  Config config = Config();
  init(){
    config.addSection("Logging");
    config.addSection("Air");
    config.addSection("Soil");

    config.set("Logging", "LoggerId", "");
    config.set("Logging", "PairingId", "");
    config.set("Logging", "Active", "False");
    config.set("Logging", "HubUrl", "http://40.87.132.220:8093/hubs/logger");
    config.set("Logging", "RestUrl", "http://40.87.132.220:8092");

    config.set("Air", "MinHumid", "0.0");
    config.set("Air", "MaxHumid", "0.0");
    config.set("Air", "MinTemp", "0.0");
    config.set("Air", "MaxTemp", "0.0");

    config.set("Soil", "Moist", "0.0");
    config.set("Soil", "Dry", "0.0");




    connectSSH();
    //Initialize network state listener
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print('ayo');
      connectSSH();
    });
  }

  register() async {
    print("IOJFDSJFJF");
    print(config.toString());
    final sftp = await client.sftp();
    final file = await sftp.open('/home/pi/denis/plant-control-logger/config.ini', mode: SftpFileOpenMode.write);
    await file.writeBytes(utf8.encode(config.toString()) as Uint8List);
  }

  connectSSH() async {
    print('connecting..');
    try {
      //Connect to raspberry via SSH
      client = SSHClient(
          await SSHSocket.connect('raspberrypi.local', 22,
              timeout: Duration(seconds: 5)),
          username: 'pi',
          onPasswordRequest: () => 'easv2021');

      connected = true;
      readConfigFile();
    } catch (_) {
      connected = false;
      configRead = false;
      notifyListeners();
    }

  }

  readConfigFile() async {
    if (configRead) return;
    print("reading");
    final sftp = await client.sftp();
    final file = await sftp.open('/home/pi/denis/plant-control-logger/config.ini');
    final content = await file.readBytes();
    config = Config.fromString(latin1.decode(content));
    configRead = true;
    notifyListeners();
  }
}
