import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GeneratedQRPage extends StatefulWidget {

  const GeneratedQRPage({super.key, required this.qrData});

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
            QrImageView(
              data: widget.qrData,
              version: QrVersions.auto,
              size: 200.0,
            ),
            const SizedBox(height: 20),
            Text(widget.qrData),
            // Button, zurück zur Artikel-Übersicht
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Zurück'),
            ),
          ],
        ),
      ),
    );
  }
}