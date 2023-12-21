import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventar_app/blocs/artikel_bloc/artikel_bloc.dart';
import 'package:inventar_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:inventar_app/models/artikel.dart';
import 'package:inventar_app/pages/barcode_page/barcode_page.dart';

class ArtikelUDPage extends StatefulWidget {

  final Artikel artikel;

  const ArtikelUDPage({super.key, required this.artikel});

  @override
  State<ArtikelUDPage> createState() => _ArtikelUDPageState();
}

class _ArtikelUDPageState extends State<ArtikelUDPage> {
  final TextEditingController _bezeichnungController = TextEditingController();
  final TextEditingController _bestandController = TextEditingController();
  final TextEditingController _minBestandController = TextEditingController();
  final TextEditingController _bestellgrenzeController = TextEditingController();
  final TextEditingController _beschreibungController = TextEditingController();
  String _lagerplatzIdController = '';
  String _artikelNrController = '';
  // Image controller
  String? _imageController;

  final _lagerplatzCodeController = TextEditingController();
  final _artikelNrCodeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _artikelChanged = false;
  bool _imageChanged = false;

  bool _isLogisticsManager = false;

  @override
  void initState(){
    
    super.initState();

    _isLogisticsManager = context.read<AuthBloc>().state.benutzer.rolle == 'logistics manager';
  
    _bezeichnungController.text = widget.artikel.bezeichnung ?? '';
    if (widget.artikel.bestand != null) {
      _bestandController.text = widget.artikel.bestand.toString();
    }
    if (widget.artikel.mindestbestand != null) {
      _minBestandController.text = widget.artikel.mindestbestand.toString();
    }
    if (widget.artikel.bestellgrenze != null) {
      _bestellgrenzeController.text = widget.artikel.bestellgrenze.toString();
    }
    _beschreibungController.text = widget.artikel.beschreibung ?? '';
    _lagerplatzIdController = widget.artikel.lagerplatzId ?? '';
    _lagerplatzCodeController.text = widget.artikel.lagerplatzId ?? '';
    _artikelNrController = widget.artikel.ean ?? '';
    _artikelNrCodeController.text = widget.artikel.ean ?? '';

    // Füge Listener hinzu, um zu prüfen, ob sich die Eingaben geändert haben
    _bezeichnungController.addListener(_onControllerChanged);
    _bestandController.addListener(_onControllerChanged);
    _minBestandController.addListener(_onControllerChanged);
    _bestellgrenzeController.addListener(_onControllerChanged);
    _beschreibungController.addListener(_onControllerChanged);
    _lagerplatzCodeController.addListener(_onControllerChanged);
    _artikelNrCodeController.addListener(_onControllerChanged);
  }

  // Prüfe, ob sich die Eingaben geändert haben
  void _onControllerChanged() {
    if (_bezeichnungController.text != widget.artikel.bezeichnung ||
        _bestandController.text != widget.artikel.bestand.toString() ||
        _minBestandController.text != widget.artikel.mindestbestand.toString() ||
        _bestellgrenzeController.text != widget.artikel.bestellgrenze.toString() ||
        _beschreibungController.text != widget.artikel.beschreibung ||
        _lagerplatzIdController != widget.artikel.lagerplatzId ||
        _artikelNrCodeController.text != widget.artikel.ean) {
      setState(() {
        _artikelChanged = true;
      });
    } else {
      setState(() {
        _artikelChanged = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produkt Updaten'), centerTitle: true),
      body: SingleChildScrollView(
        child: Form(
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
                          Column(
                            children: [
                              GestureDetector(
                                  onTap: _isLogisticsManager ? null : () {
                                    // Das Bild groß anzeigen
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          content: SizedBox(
                                            height: 300,
                                            child: _imageChanged
                                      ? SizedBox(
                                          width: 150,
                                          height: 150,
                                          child: Image.file(
                                            File(_imageController!),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : widget.artikel.image != null
                                          ? SizedBox(
                                              width: 150,
                                              height: 150,
                                              child: CachedNetworkImage(
                                                imageUrl: widget.artikel.image!,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            )
                                          : SizedBox(
                                              width: 150,
                                              height: 150,
                                              child: Image.asset(
                                                  'assets/images/default_artikel.png'),
                                            )
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: _imageChanged
                                      ? SizedBox(
                                          width: 150,
                                          height: 150,
                                          child: Image.file(
                                            File(_imageController!),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : widget.artikel.image != null
                                          ? SizedBox(
                                              width: 150,
                                              height: 150,
                                              child: CachedNetworkImage(
                                                imageUrl: widget.artikel.image!,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            )
                                          : SizedBox(
                                              width: 150,
                                              height: 150,
                                              child: Image.asset(
                                                  'assets/images/default_artikel.png'),
                                            )),
                                TextButton.icon(
                                                  onPressed: _isLogisticsManager ? null : _changeImage,
                                                  icon: const Icon(Icons.edit),
                                                  label: const Text('Bild ändern'),
                                                ),
                            ],
                          ),
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
                                            decoration: InputDecoration(
                                              border: const OutlineInputBorder(),
                                              hintText: 'Bezeichnung',
                                              fillColor: Colors.white60,
                                              filled: true,
                                              enabled: _isLogisticsManager ? false : true,
                                            ),
                                            style: const TextStyle(
                                                color: Colors.black87,
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
                                              fillColor: Colors.white60,
                                              filled: true,
                                            ),
                                            enabled: _isLogisticsManager ? false : true,
                                            keyboardType: TextInputType.number,
                                            controller: _bestandController,
                                            style: const TextStyle(
                                                color: Colors.black87),
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
                                              fillColor: Colors.white60,
                                              filled: true,
                                            ),
                                            enabled: _isLogisticsManager ? false : true,
                                            keyboardType: TextInputType.number,
                                            controller: _minBestandController,
                                            style: const TextStyle(
                                                color: Colors.black87),
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
                                    fillColor: Colors.white60,
                                    filled: true,
                                  ),
                                  keyboardType: TextInputType.number,
                                  controller: _bestellgrenzeController,
                                  enabled: _isLogisticsManager ? false : true,
                                  style: const TextStyle(
                                      color: Colors.black87),
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
                            padding: const EdgeInsets.all(2.0),
                            child: TextField(
                              decoration: const InputDecoration( 
                                border: OutlineInputBorder(),
                                hintText: 'Beschreibung (optional)',
                                fillColor: Colors.white60,
                                filled: true,
                                contentPadding: EdgeInsets.all(4),
                              ),
                              enabled: _isLogisticsManager ? false : true,
                              controller: _beschreibungController,
                              style: const TextStyle(color: Colors.black87),
                              maxLines: 5,
                            ),
                          ),
                        ],
                      ),
                    ),Container(
                      color: Colors.blue[100],
                      child: Padding(                            // ProduktNr
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
                                      'ProduktNr: ${_artikelNrCodeController.text}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(padding: const EdgeInsets.all(4),
                              child: SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: _artikelNrController.isNotEmpty && _artikelNrController != 'Ungültiger QR-Code' && _artikelNrController != 'Fehlgeschlagen beim erhalten der Platform-version.' ? () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BarcodeGeneratedPage(barcodeData: _artikelNrController)));
                                  } : null,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      )), 
                                  child: const Row(
                                    children: [
                                      Icon(CupertinoIcons.barcode),
                                      Text(' Barcode',
                                          style: TextStyle(fontSize: 22)),
                                    ],
                                  )),
                              ),),
                            ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SizedBox(
                                      width: 220,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          String result = await scanBarcode(_artikelNrCodeController);
                                          setState(() {
                                            if (result == 'Ungültiger QR-Code' || result == 'Fehlgeschlagen beim erhalten der Platform-version.') {
                                              // show a snackbar
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text('Ungültiger QR-Code'),
                                                ),
                                              );
                                            } else {
                                              _artikelNrController = result;
                                              _artikelNrCodeController.text = result;
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber,
                                            foregroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            )),
                                        child: const Row(
                                          children: [
                                            Icon(CupertinoIcons.barcode_viewfinder),
                                            Text(' Produkt Scanen',
                                                style: TextStyle(fontSize: 22)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.green[200],
                      child: Padding(                          // Lagerplatz
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
                                  width: 195,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      String result = await scanBarcode(_lagerplatzCodeController);
                                      setState(() {
                                        if (result == 'Ungültiger QR-Code' || result == 'Fehlgeschlagen beim erhalten der Platform-version.') {
                                          // show a snackbar
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Ungültiger QR-Code'),
                                            ),
                                          );
                                        } else {
                                          _lagerplatzIdController = result;
                                          _lagerplatzCodeController.text = result;
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        )),
                                    child: const Row(
                                      children: [
                                        Icon(CupertinoIcons.barcode_viewfinder),
                                        Text(' Platz Scanen',
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
                    ),
                    // Button zum Speichern
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: _artikelChanged ? () {
                            if (_formKey.currentState!.validate()) {
                              Artikel artikel = Artikel(
                                  artikelId: widget.artikel.artikelId,
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
                                      _lagerplatzIdController.isNotEmpty && _lagerplatzIdController != 'Ungültiger QR-Code' && _lagerplatzIdController != 'Fehlgeschlagen beim erhalten der Platform-version.'
                                          ? _lagerplatzIdController
                                          : null,
                                  image: _imageController,
                                      ean: _artikelNrController.isNotEmpty && _artikelNrController != 'Ungültiger QR-Code' && _artikelNrController != 'Fehlgeschlagen beim erhalten der Platform-version.'
                                          ? _artikelNrController
                                          : null);
                              // Mit dem ArtikelAddEvent wird der Artikel in der Datenbank gespeichert
                              try {
                                BlocProvider.of<ArtikelBloc>(context).add(ArtikelUpdateEvent(artikel));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.green[300],
                                        content: const Text(
                                            'Artikel erfolgreich geupdatet',
                                            style:
                                                TextStyle(color: Colors.black))));
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(e.toString())));
                              }
                              Navigator.pop(context);
                            }
                          } : null,
                          // Button-Style
                          style: ElevatedButton.styleFrom(
                              backgroundColor:  Colors.green,
                              foregroundColor:  Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                          child: const Text('Speichern',
                              style: TextStyle(fontSize: 26)),
                        ),
                      ),
                    ),
                    // Button zum Löschen
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: _isLogisticsManager ? null : () {
                            // Mit dem ArtikelDeleteEvent wird der Artikel in der Datenbank gelöscht
                            // Ein ShowDialog bestätigt das Löschen
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Artikel löschen'),
                                  content: const Text(
                                      'Sind Sie sicher, dass Sie den Artikel löschen möchten?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Abbrechen'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        try {
                                          BlocProvider.of<ArtikelBloc>(context).add(ArtikelDeleteEvent(widget.artikel));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor:
                                                      Colors.orange[300],
                                                  content: const Text(
                                                      'Artikel erfolgreich gelöscht',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black))));
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(e.toString())));
                                        }
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Löschen'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          // Button-Style
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                          child: const Text('Löschen',
                              style: TextStyle(fontSize: 26)),
                        ),
                      ),
                    ),
                    // Button zum Abbrechen
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          // Button-Style
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[900],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                          child: const Text('Abbrechen',
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
      ),
    );
  }

  Future<String> scanBarcode(TextEditingController barcode) async {
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
      scanResult = 'Fehlgeschlagen beim erhalten der Platform-version.';
    }
    if (!mounted) return '';

    return scanResult;
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
                    final pickedFile = await picker.pickImage(source: ImageSource.camera);
                    _processImage(pickedFile);
                  },
                  label: const Text('Kamera'),
                  icon: const Icon(Icons.camera_alt),
                ),
                TextButton.icon(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
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
                  setState(() {
                    _imageController = /*File(pickedFile.path).readAsBytesSync();*/ File(pickedFile.path).path;
                    //widget.artikel.image = File(pickedFile.path).path;  // nicht relevant für jetzt
                    _imageChanged = true;
                    _artikelChanged = true;
                  });
                  Navigator.of(context).pop();
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
