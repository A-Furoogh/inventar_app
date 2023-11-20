import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';


class BarcodeGeneratedPage extends StatefulWidget {
  const BarcodeGeneratedPage({super.key, required this.barcodeData});

  final String barcodeData;

  @override
  State<BarcodeGeneratedPage> createState() => _BarcodeGeneratedPageState();
}

class _BarcodeGeneratedPageState extends State<BarcodeGeneratedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                _printBarcode();
              },
              icon: const Icon(Icons.print_rounded),
              label: const Text('Barcode drucken'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
            ),
            const SizedBox(height: 20),
            BarcodeWidget(
              barcode: Barcode.code128(),
              data: widget.barcodeData,
              width: 200,
              height: 100,
              drawText: true,
            ),
            const SizedBox(height: 20),
            Text(
              widget.barcodeData,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Button, zurück zur Artikel-Übersicht
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Zurück'),
            ),
          ]
        ),
    ),
    );
  }
  Future<void> _printBarcode() async {
  }
}