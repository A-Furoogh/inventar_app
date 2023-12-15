import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class GlobalFunctions{

  static Future<String> scanBarcode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "abbrechen", true, ScanMode.BARCODE);
      // Extrahiere den Code aus scanned URL
      if (scanResult.isNotEmpty) {
        Uri scannedUri = Uri.parse(scanResult);
        if (scannedUri.pathSegments.isNotEmpty) {
          if (scannedUri.pathSegments.last == "-1") {
            scanResult = 'Ungültiger QR-Code';
          } else {
            scanResult = scannedUri.pathSegments.last;
          }
        } else {
          scanResult = 'Ungültiger QR-Code';
        }
      } else {
        scanResult = 'Ungültiger QR-Code';
      }
      // ignore: avoid_print
      print(scanResult);
    } on PlatformException {
      scanResult = 'Fehlgeschlagen beim erhalten der Platform-version. (QR-Code))';
    }
    return scanResult;
  }
}