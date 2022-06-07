import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class BarcodeWidget extends StatefulWidget {
  const BarcodeWidget(
      {Key? key,
      required this.qrCenterImg,
      required this.qrPlaceholderImg,
      required this.size,
      required this.content})
      : super(key: key);
  final ImageProvider qrPlaceholderImg;
  final String content;
  final ImageProvider qrCenterImg;
  final double size;

  @override
  State<BarcodeWidget> createState() => _BarcodeWidgetState();
}

class _BarcodeWidgetState extends State<BarcodeWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.size,
        height: widget.size,
        child: Center(
            child: widget.content.isNotEmpty
                ? //Conditional widget
                PrettyQr(
                    image: widget.qrCenterImg,
                    typeNumber: 6,
                    size: widget.size * 0.66,
                    data: widget.content,
                    errorCorrectLevel: QrErrorCorrectLevel.H,
                    roundEdges: false,
                  )
                : Column(
                    children: [
                      Image(
                          image: widget.qrPlaceholderImg,
                          width: widget.size * 0.66),
                      const Text("Register to generate a QR code")
                    ],
                  )));
  }
}
