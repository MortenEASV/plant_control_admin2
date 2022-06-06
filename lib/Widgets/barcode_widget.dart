import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class BarcodeWidget extends StatelessWidget {
  const BarcodeWidget({Key? key, required this.img, required this.qrSize})
      : super(key: key);
  final img;
  final qrSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PrettyQr(
        image: img,
        typeNumber: 6,
        size: qrSize,
        data: '629b4aa3b0c62559fbc7226a',
        errorCorrectLevel: QrErrorCorrectLevel.M,
        roundEdges: false,
      ),
    );
  }
}
