import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:dartssh2/dartssh2.dart';
import 'package:image/image.dart';
class HomePageViewModel{
  static final HomePageViewModel instance = HomePageViewModel._();
  var client;
  var img = NetworkImage("https://www.kindpng.com/picc/m/63-636289_computer-chip-computer-chip-icon-png-transparent-png.png");
  //var img = NetworkImage("https://cdn-icons-png.flaticon.com/512/964/964748.png");


  HomePageViewModel._();

  init() async {
    client = SSHClient(
      await SSHSocket.connect('raspberrypi.local', 22),
      username: 'pi',
      onPasswordRequest: () => 'easv2021',
    );
  }

  pressed(){
    if (client == null) init();




  }
}