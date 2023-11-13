import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventar_app/pages/artikel/qr_code_page.dart';

class LagerPage extends StatefulWidget {
  const LagerPage({super.key});

  @override
  State<LagerPage> createState() => _LagerPageState();
}

class _LagerPageState extends State<LagerPage> {
  final TextEditingController _lagerSearchController = TextEditingController();
  final TextEditingController _lagerCreateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lager'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Lager Code Scannen um nach Artikeln zu suchen
            Flexible(
              flex: 2,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                color: Colors.blue[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(30),
                      child: Text('Lager durchsuchen',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    const Text('Lagerplatz scannen',
                        style: TextStyle(fontSize: 20)),
                    ElevatedButton.icon(
                      onPressed: () async {
                        String scanResult = await scanBarcode();
                        setState(() {
                          _lagerSearchController.text = scanResult;
                        });
                      },
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('Lager Code Scannen'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blueAccent),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Lager Code manuell eingeben um nach Artikeln zu suchen
                    const Text('Lager Code manuell eingeben',
                        style: TextStyle(fontSize: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Lager Code',
                            ),
                            controller: _lagerSearchController,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blueAccent),
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(100, 45)),
                          ),
                          child: const Text('Suchen'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.indigo[100],
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('QR-Code für Lagerplatz erstellen',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 50,
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Nr. des Lagerplatzes',
                              ),
                              controller: _lagerCreateController,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GeneratedQRPage(
                                            qrData: _lagerCreateController.text,
                                          )));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.indigoAccent),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(100, 45)),
                            ),
                            child: const Text('Erstellen'),
                          ),
                        ],
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> scanBarcode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "abbrechen", true, ScanMode.QR);
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
      scanResult = 'Fehlgeschlagen beim erhalten der Platform-version.';
    }
    if (!mounted) return '';

    return scanResult;
  }
}
