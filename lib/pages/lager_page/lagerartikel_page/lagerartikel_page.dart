import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventar_app/models/artikel.dart';

class LagerArtikelPage extends StatefulWidget {
  final Artikel artikel;

  const LagerArtikelPage({super.key, required this.artikel});

  @override
  State<LagerArtikelPage> createState() => _LagerArtikelPageState();
}

class _LagerArtikelPageState extends State<LagerArtikelPage> {
  final TextEditingController _bestandController = TextEditingController();
  final TextEditingController _minBestandController = TextEditingController();
  final TextEditingController _bestellgrenzeController =
      TextEditingController();
  String _lagerplatzIdController = '';
  String _artikelNrController = '';
  // Image controller
  Uint8List? _imageController;

  final _lagerplatzCodeController = TextEditingController();
  final _artikelNrCodeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _artikelChanged = false;

  @override
  void initState() {
    super.initState();

    _bestandController.text = widget.artikel.bestand.toString();
    _minBestandController.text = widget.artikel.mindestbestand.toString();
    _bestellgrenzeController.text = widget.artikel.bestellgrenze.toString();
    _lagerplatzIdController = widget.artikel.lagerplatzId ?? '';
    _lagerplatzCodeController.text = widget.artikel.lagerplatzId ?? '';
    _artikelNrController = widget.artikel.artikelNr ?? '';
    _artikelNrCodeController.text = widget.artikel.artikelNr ?? '';
    if (widget.artikel.image != null) {
      _imageController = base64Decode(widget.artikel.image!);
    }

    // Füge Listener hinzu, um zu prüfen, ob sich die Eingaben geändert haben
    _bestandController.addListener(_onControllerChanged);
    _minBestandController.addListener(_onControllerChanged);
    _bestellgrenzeController.addListener(_onControllerChanged);
    _lagerplatzCodeController.addListener(_onControllerChanged);
    _artikelNrCodeController.addListener(_onControllerChanged);
  }

  // Prüfe, ob sich die Eingaben geändert haben
  void _onControllerChanged() {
    if (_bestandController.text != widget.artikel.bestand.toString() ||
        _minBestandController.text !=
            widget.artikel.mindestbestand.toString() ||
        _bestellgrenzeController.text !=
            widget.artikel.bestellgrenze.toString() ||
        _lagerplatzIdController != widget.artikel.lagerplatzId ||
        _artikelNrCodeController.text != widget.artikel.artikelNr) {
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
      appBar: AppBar(
        title: const Text('Produkt Umlagern'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
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
                          _imageController != null
                              ? Image.memory(_imageController!,
                                  width: 150, height: 150, fit: BoxFit.cover)
                              : const Image(
                                  image: AssetImage(
                                      'assets/images/default_artikel.png'),
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover),
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
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white60,
                                              border: Border.all(
                                                  color: Colors.black54),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.artikel.bezeichnung,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
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
                                          child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white60,
                                              border: Border.all(
                                                  color: Colors.black54),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.artikel.bestand
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
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
                                          child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white60,
                                              border: Border.all(
                                                  color: Colors.black54),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.artikel.mindestbestand
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold, color: int.parse(_minBestandController.text) > int.parse(_bestandController.text) ? Colors.red : Colors.black87),
                                              ),
                                            ),
                                          ),
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
                                child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white60,
                                              border: Border.all(
                                                  color: Colors.black54),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.artikel.bestellgrenze
                                                    .toString(),
                                                    textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.artikel.beschreibung ??
                                        'Keine Beschreibung vorhanden.',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blue[100],
                      child: Padding(
                        // ProduktNr
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: SizedBox(
                                      width: 150,
                                      child: ElevatedButton(
                                          onPressed: _artikelNrController
                                                      .isNotEmpty &&
                                                  _artikelNrController !=
                                                      'Ungültiger QR-Code' &&
                                                  _artikelNrController !=
                                                      'Fehlgeschlagen beim erhalten der Platform-version.'
                                              ? () {
                                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => BarcodeGeneratedPage(barcodeData: _artikelNrController)));
                                                }
                                              : null,
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
                                                  style:
                                                      TextStyle(fontSize: 22)),
                                            ],
                                          )),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SizedBox(
                                      width: 220,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          /*
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
                                          */
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
                                            Icon(CupertinoIcons
                                                .barcode_viewfinder),
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
                      child: Padding(
                        // Lagerplatz
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
                                      /*
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
                                      */
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
                    
                    // Button zum Löschen aus Lagerplatz
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Mit dem ArtikelDeleteEvent wird der Artikel in der Datenbank gelöscht
                            // Ein ShowDialog bestätigt das Löschen
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Artikel aus Lagerplatz löschen'),
                                  content: const Text(
                                      'Sind Sie sicher, dass Sie den Artikel aus diesem Lagerplatz löschen möchten?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Abbrechen'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        //BlocProvider.of<ArtikelBloc>(context).add(ArtikelDeleteEvent(widget.artikel));
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Ja'),
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
                          child: const Text('Aus Lagerplatz löschen',
                              style: TextStyle(fontSize: 26)),
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
                          onPressed: _artikelChanged
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    Artikel artikel = Artikel(
                                        artikelId: widget.artikel.artikelId,
                                        bezeichnung: widget.artikel.bezeichnung,
                                        bestand:
                                            int.parse(_bestandController.text),
                                        mindestbestand: _minBestandController.text.isNotEmpty
                                            ? int.parse(
                                                _minBestandController.text)
                                            : 0,
                                        bestellgrenze: _bestellgrenzeController.text.isNotEmpty
                                            ? int.parse(
                                                _bestellgrenzeController.text)
                                            : 0,
                                        beschreibung:
                                            widget.artikel.beschreibung,
                                        lagerplatzId: _lagerplatzIdController.isNotEmpty &&
                                                _lagerplatzIdController !=
                                                    'Ungültiger QR-Code' &&
                                                _lagerplatzIdController !=
                                                    'Fehlgeschlagen beim erhalten der Platform-version.'
                                            ? _lagerplatzIdController
                                            : null,
                                        image: _imageController != null
                                            ? widget.artikel.image
                                            : null,
                                        artikelNr: _artikelNrController.isNotEmpty &&
                                                _artikelNrController != 'Ungültiger QR-Code' &&
                                                _artikelNrController != 'Fehlgeschlagen beim erhalten der Platform-version.'
                                            ? _artikelNrController
                                            : null);
                                    // Mit dem ArtikelAddEvent wird der Artikel in der Datenbank gespeichert
                                    //BlocProvider.of<ArtikelBloc>(context).add(ArtikelUpdateEvent(artikel));
                                    Navigator.pop(context);
                                  }
                                }
                              : null,
                          // Button-Style
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                          child: const Text('Speichern',
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
}
