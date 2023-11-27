import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:pdf/widgets.dart' as pw;


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
              onPressed: () async {
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

  void _printBarcode() async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.BarcodeWidget(
                  barcode: pw.Barcode.code128(),
                  data: widget.barcodeData,
                  width: 400,
                  height: 200,
                  drawText: false,
                ),
                pw.SizedBox(height: 15),
                pw.Text(widget.barcodeData, style: const pw.TextStyle(fontSize: 30)),
              ],
              )
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }

  //Future<String> _generateBarcodeBase64() async {}

}