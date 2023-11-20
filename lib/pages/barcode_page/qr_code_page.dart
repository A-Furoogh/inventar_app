import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:printing/printing.dart';

class GeneratedQRPage extends StatefulWidget {
  const GeneratedQRPage({Key? key, required this.qrData}) : super(key: key);

  final String qrData;

  @override
  State<GeneratedQRPage> createState() => _GeneratedQRPageState();
}

class _GeneratedQRPageState extends State<GeneratedQRPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                _printQRCode();
              },
              icon: const Icon(Icons.print_rounded),
              label: const Text('QR Code drucken'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
            ),
            QrImageView(
              data: widget.qrData,
              version: QrVersions.auto,
              size: 200.0,
              gapless: false,
            ),
            const SizedBox(height: 20),
            Text(widget.qrData, style: const TextStyle(fontSize: 24)),
            // Button, zurück zur Artikel-Übersicht
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Zurück'),
            ),
          ],
        ),
      ),
    );
  }

  // Funktion zum Drucken des QR Codes
  void _printQRCode() {
    Printing.layoutPdf(onLayout: (format) {
      return Printing.convertHtml(
        html: '<html><img src="data:image/png;base64,${_generateQRBase64()}"><body><p>${widget.qrData}</p></body></html>',
        format: format,
      );
    });
  }

  Future<String> _generateQRBase64() async {
    final image = await QrPainter(
      data: widget.qrData,
      version: QrVersions.auto,
      gapless: false,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: Color(0xFF000000),
      ),
      dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.circle,
        color: Color(0xFF000000),)
    ).toImage(200);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    return base64Encode(byteData!.buffer.asUint8List());
  }
  
}
