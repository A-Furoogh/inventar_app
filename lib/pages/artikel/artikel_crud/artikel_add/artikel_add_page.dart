import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventar_app/blocs/artikel_bloc/artikel_bloc.dart';
import 'package:inventar_app/models/artikel.dart';
import 'package:inventar_app/pages/artikel/artikel_crud/artikel_add/qr_code.dart';

class ArtikelAddPage extends StatefulWidget {
  const ArtikelAddPage({super.key});

  @override
  State<ArtikelAddPage> createState() => _ArtikelAddPageState();
}

class _ArtikelAddPageState extends State<ArtikelAddPage> {
  final TextEditingController _bezeichnungController = TextEditingController();
  final TextEditingController _bestandController = TextEditingController();
  final TextEditingController _minBestandController = TextEditingController();
  final TextEditingController _bestellgrenzeController = TextEditingController();
  final TextEditingController _beschreibungController = TextEditingController();
  String _lagerplatzIdController = '';
  // Image controller
  File? _pickedImage;

  final _lagerplatzCodeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Neues Artikel'), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.grey[300],
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: _changeImage,
                            child: _pickedImage != null
                                ? Image.file(_pickedImage!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover)
                                : const Image(
                                    image: AssetImage(
                                        'assets/images/default_artikel.png'),
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover)),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.label_important,
                                                color: Colors.grey),
                                            Text('Bezeichnung: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 22)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Bezeichnung',
                                          ),
                                          controller: _bezeichnungController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Bitte geben Sie eine Bezeichnung ein.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.label_important,
                                                  color: Colors.grey),
                                              Text('Bestand: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        height: 40,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                          keyboardType: TextInputType.number,
                                          controller: _bestandController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Bitte geben Sie einen Bestand ein.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.label_important,
                                                  color: Colors.grey),
                                              Text(
                                                'Min.Bestand: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        height: 40,
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                          keyboardType: TextInputType.number,
                                          controller: _minBestandController,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Icon(Icons.label_important,
                                    color: Colors.grey),
                                Text('Bestellgrenze: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Bestellgrenze',
                                ),
                                keyboardType: TextInputType.number,
                                controller: _bestellgrenzeController,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Icon(Icons.label_important, color: Colors.grey),
                              Text('Beschreibung: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Beschreibung (optional)',
                            ),
                            controller: _beschreibungController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              const Icon(Icons.label_important,
                                  color: Colors.grey),
                              Text(
                                  'Lagerplatz: ${_lagerplatzCodeController.text}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SizedBox(
                              width: 135,
                              child: ElevatedButton(
                                onPressed: scanBarcode,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0),
                                    )),
                                child: const Row(
                                  children: [
                                    Icon(Icons.qr_code_scanner),
                                    Text(' Scanen',
                                        style: TextStyle(fontSize: 22)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Button zum Speichern
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Artikel artikel = Artikel(
                                bezeichnung: _bezeichnungController.text,
                                bestand: int.parse(_bestandController.text),
                                mindestbestand: _minBestandController
                                        .text.isNotEmpty
                                    ? int.parse(_minBestandController.text)
                                    : 0,
                                bestellgrenze: _bestellgrenzeController
                                        .text.isNotEmpty
                                    ? int.parse(_bestellgrenzeController.text)
                                    : 0,
                                beschreibung:
                                    _beschreibungController.text.isNotEmpty
                                        ? _beschreibungController.text
                                        : null,
                                lagerplatzId:
                                    _lagerplatzIdController.isNotEmpty
                                        ? _lagerplatzIdController
                                        : null,
                                image: _pickedImage != null
                                    ? _pickedImage!.path
                                    : null);
                                    // Add artikel, when added, then go to GeneratedQRCodePage and show QR Code and pop this page
                            BlocProvider.of<ArtikelBloc>(context)
                                .add(ArtikelAddEvent(artikel));
                                // Wait for artikel to be added and show CircularProgressIndicator
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>GeneratedQRPage(qrData: artikel.artikelId.toString(),)));
                            });
                          }
                        },
                        child: const Text('Hinzufügen',
                            style: TextStyle(fontSize: 26)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future scanBarcode() async {
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
            _lagerplatzIdController = '';
          } else {
            scanResult = scannedUri.pathSegments.last;
            _lagerplatzIdController = scanResult;
          }
        } else {
          scanResult = 'Ungültiger QR-Code';
          _lagerplatzIdController = '';
        }
      } else {
        scanResult = 'Ungültiger QR-Code';
        _lagerplatzIdController = '';
      }
      // ignore: avoid_print
      print(scanResult);
    } on PlatformException {
      scanResult = 'Fehlgeschlagen beim erhalten der Platform-version.';
    }
    if (!mounted) return;

    setState(() => _lagerplatzCodeController.text = scanResult);
  }

  Future<void> _changeImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quelle für Bild auswählen'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.camera);
                    _processImage(pickedFile);
                  },
                  label: const Text('Kamera'),
                  icon: const Icon(Icons.camera_alt),
                ),
                TextButton.icon(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      _processImage(pickedFile);
                    },
                    label: const Text('Galerie'),
                    icon: const Icon(Icons.photo_library)),
              ],
            ),
          ],
        );
      },
    );
  }

  void _processImage(XFile? pickedFile) {
    if (pickedFile != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const Text('Bild bestätigen'),
            content: SizedBox(
              height: 300,
              child: Image.file(
                File(pickedFile.path),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Abbrechen'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _pickedImage = File(pickedFile.path);
                  });
                },
                child: const Text('Bestätigen'),
              ),
            ],
          );
        },
      );
    }
  }
}
