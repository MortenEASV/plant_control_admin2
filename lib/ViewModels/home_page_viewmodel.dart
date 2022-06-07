import 'dart:async';
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
import 'package:http/http.dart' as http;


class HomePageViewModel with ChangeNotifier {
  //Singleton
  static final HomePageViewModel instance = HomePageViewModel._();
  HomePageViewModel._() {
    init();
  }

  String sshHost = "raspberrypi.local";
  late SSHClient client;
  FileImage qrCenterImg = FileImage(File("assets/chip.png"));
  FileImage qrPlaceholderImg = FileImage(File("assets/placeholder.webp"));
  //var img = NetworkImage("https://cdn-icons-png.flaticon.com/512/964/964748.png");
  bool connected = false;
  bool configRead = false;
  Config config = Config();


  init(){
    initConfig();
    connectSSH();


    //Initialize network state listener
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.ethernet) {
        connectSSH();
      }
    });
  }

  registerOnClick() async {

    if (!connected) return;   //Guard clause

    //Save the config file on the raspberry through the sftp protocol
    final sftp = await client.sftp();
    final file = await sftp.open('/home/pi/denis/plant-control-logger/config.ini', mode: SftpFileOpenMode.write);
    await file.writeBytes(utf8.encode(config.toString()) as Uint8List);

    //Make post request
    var response = await postLogger("testerloggyboi");

    //Decode Json to map
    Map<String, dynamic> map = jsonDecode(response.body);

    //Get id from map
    String id = map['_id'];

    print(id);
    //config.set("Logging", "LoggerId", id);


  }

  Future<http.Response> postLogger(String name) async {
    return http.post(
      Uri.parse('${config.get("Logging", 'RestUrl')!}/loggers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
      }),
    );
  }

  connectSSH() async {
    try {
      //Connect to raspberry via SSH
      client = SSHClient(
          await SSHSocket.connect('raspberrypi.local', 22,
              timeout: const Duration(seconds: 5)),
          username: 'pi',
          onPasswordRequest: () => 'easv2021');

      //Subscribe for the event where the connection closes, and handle it
      client.done.then((value) {
        connected = false;
        configRead = false;
        notifyListeners();
      });


      connected = true;
      readConfigFile();

    } catch (_) {}


  }

  readConfigFile() async {
    if (configRead) return;   //Guard clause

    //Read the config file on the raspberry through the sftp protocol
    final sftp = await client.sftp();
    final file = await sftp.open('/home/pi/denis/plant-control-logger/config.ini');
    final content = await file.readBytes();
    config = Config.fromString(latin1.decode(content));
    configRead = true;

    notifyListeners();
  }


  //Initialize a default config for when a raspberry is not connected, or when a config file could not be found
  initConfig() {
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
  }
}

