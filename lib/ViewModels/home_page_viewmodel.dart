import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:ini/ini.dart';
import 'package:http/http.dart' as http;
import 'package:plant_control_admin/enumerators.dart';

class HomePageViewModel with ChangeNotifier {
  //Ensure class is used as a singleton
  static final HomePageViewModel instance = HomePageViewModel._();
  HomePageViewModel._() {
    init();
  }

  //Initialize class variables
  String sshHost = "raspberrypi.local";
  late SSHClient client;
  FileImage qrCenterImg = FileImage(File("assets/chip.png"));
  FileImage qrPlaceholderImg = FileImage(File("assets/placeholder.webp"));
  bool connected = false;
  bool configRead = false;
  Config defaultConfig = Config();
  Config config = Config();


  init(){
    initConfig();
    connectSSH();

    //Initialize network state listener
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print('yo');
      connectSSH();
    });
  }

  //Requests an ID from the Rest API and saves it to the config file
  Future<bool> registerOnClick() async {
    if (!connected) return false;   //Guard clause

    /*  //Not enabled to avoid database troubles
    //If logger already has an ID, we make a delete request for the old one
    if (config.get('Logging', 'LoggerId')!.isNotEmpty) {
      var res = await request(config.get('Logging', 'LoggerId')!, HttpRequestType.delete);
      print(res.statusCode);
    }

     */

    //Make post request
    var response = await request("Registered from plant_control_admin", HttpRequestType.post);
    if (response.statusCode != 201) return false; //Guard clause

    //Decode Json to map
    Map<String, dynamic> map = jsonDecode(response.body);

    //Get id from map
    String id = map['_id'];

    config.set("Logging", "LoggerId", id);
    saveOnClick();
    notifyListeners();

    return true;
  }

  //Http request that takes a parameter and a type of request
  Future<http.Response> request(String param, HttpRequestType type) async {
    var url = Uri.parse('http://${config.get("Logging", 'RestUrl')!}/loggers');
    switch (type) {
      case HttpRequestType.post:
        return http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'name': param,
          }),
        );

      case HttpRequestType.delete:
        return http.delete(
          Uri.parse('$url/$param'),
        );
    }
  }

  //Establish a connection to the logger via SSH
  connectSSH() async {
    try {
      print("trying connection");
      sleep(Duration(seconds: 2));
      client = SSHClient(
          await SSHSocket.connect('raspberrypi.local', 22,
              timeout: const Duration(seconds: 5)),
          username: 'pi',
          onPasswordRequest: () => 'easv2021');

      //Subscribe for the event where the connection closes, and handle it
      client.done.then((value) {
        print('yoooo');
        connected = false;
        configRead = false;
        config = defaultConfig;
        notifyListeners();
      });

      //If successful, we set the connected variable, and read the config file next
      connected = true;
      readConfigFile();
    } catch (e) {print("nope" + e.toString());}
  }

  //Read the config file on the raspberry through the sftp protocol
  readConfigFile() async {
    print('trying to read config');
    if (configRead) return; //Guard clause

    final sftp = await client.sftp();
    sftp.close();
    final file = await sftp.open('/home/pi/denis/plant-control-logger/config.ini');
    final content = await file.readBytes();

    config = Config.fromString(latin1.decode(content));
    configRead = true;

    notifyListeners();
    print('notifying');
  }

  //Stop the logger program so we can write a config file safely
  stopProgram() async{
    var res = client.run('pkill -f -2 -e python3');
    print(res);
  }

  //Start the logger program
  startProgram() async{
   await client.run('(cd ~/denis/plant-control-logger; python3 .)');
  }


  //Initialize a default config for when a raspberry is not connected, or when a config file could not be found
  initConfig() {
    defaultConfig.addSection("Logging");
    defaultConfig.addSection("Air");
    defaultConfig.addSection("Soil");

    defaultConfig.set("Logging", "LoggerId", "");
    defaultConfig.set("Logging", "PairingId", "");
    defaultConfig.set("Logging", "Active", "False");
    defaultConfig.set("Logging", "SocketUrl", "");
    defaultConfig.set("Logging", "RestUrl", "");

    defaultConfig.set("Air", "MinHumid", "");
    defaultConfig.set("Air", "MaxHumid", "");
    defaultConfig.set("Air", "MinTemp", "");
    defaultConfig.set("Air", "MaxTemp", "");

    defaultConfig.set("Soil", "Moist", "");
    defaultConfig.set("Soil", "Dry", "");
    config = defaultConfig;
  }

  //Save the config file on the raspberry through the sftp protocol
  Future<bool> saveOnClick() async {
    try {
      await stopProgram();
      final sftp = await client.sftp();
      sftp.close();
      final file = await sftp.open('/home/pi/denis/plant-control-logger/config.ini', mode: SftpFileOpenMode.write);
      await file.writeBytes(utf8.encode(config.toString()) as Uint8List);
      configRead = false;
      readConfigFile();
      await startProgram();
      return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }
}
