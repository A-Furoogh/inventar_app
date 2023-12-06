import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventar_app/blocs/artikel_bloc/artikel_bloc.dart';
import 'package:inventar_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:inventar_app/pages/artikel/artikel_crud/artikel_update_delete/artikel_update_delete_page.dart';
import 'package:inventar_app/pages/artikel/artikel_tile.dart';
import 'package:inventar_app/pages/artikel/artikel_crud/artikel_add/artikel_add_page.dart';

class ArtikelPage extends StatefulWidget {
  const ArtikelPage({super.key});

  @override
  State<ArtikelPage> createState() => _ArtikelPageState();
}

class _ArtikelPageState extends State<ArtikelPage> {

  final TextEditingController _artikelSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ArtikelBloc>().add(const ArtikelLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artikel'), centerTitle: true),
      body: Center(
        child: BlocBuilder<ArtikelBloc, ArtikelState>(
          builder: (context, state) {
            if (state is ArtikelLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ArtikelLoadedState ||
                state is ArtikelSearchState) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 2, 4),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Suche nach Bezeichnung oder Nr.',
                                border: const OutlineInputBorder(),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    scanBarcode().then((value) async {
                                      value.contains("QR-Code")
                                          ? null
                                          : _artikelSearchController.text =
                                              value;
                                      if (value.isNotEmpty) {
                                        context
                                            .read<ArtikelBloc>()
                                            .add(ArtikelSearchEvent(value));
                                      } else {
                                        BlocProvider.of<ArtikelBloc>(context)
                                            .add(const ArtikelLoadEvent());
                                      }
                                    });
                                  },
                                  child: const Icon(Icons.barcode_reader,
                                      color: Colors.teal, size: 35),
                                ),
                              ),
                              controller: _artikelSearchController,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  //BlocProvider.of<ArtikelBloc>(context).add(ArtikelSearchEvent(value));
                                  context
                                      .read<ArtikelBloc>()
                                      .add(ArtikelSearchEvent(value));
                                } else {
                                  BlocProvider.of<ArtikelBloc>(context)
                                      .add(const ArtikelLoadEvent());
                                }
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _artikelSearchController.clear();
                            BlocProvider.of<ArtikelBloc>(context)
                                .add(const ArtikelLoadEvent());
                          },
                          icon: Icon(Icons.clear, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                  // Add artikel button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: ElevatedButton(
                        onPressed: context.read<AuthBloc>().state.benutzer.rolle == 'logistics manager' ? null : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ArtikelAddPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          surfaceTintColor: Colors.grey,
                        ),
                        child: const Text('Artikel hinzufügen +'),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: state.artikel.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ArtikelTile(
                            image: state.artikel[index].image,
                            bezeichnung: state.artikel[index].bezeichnung,
                            artikelId:
                                state.artikel[index].artikelId.toString(),
                            bestand: state.artikel[index].bestand,
                            mindestbestand:
                                state.artikel[index].mindestbestand,
                            lagerplatzId: state.artikel[index].lagerplatzId,
                            bestellgrenze: state.artikel[index].bestellgrenze,
                            beschreibung: state.artikel[index].beschreibung,
                            artikelNr: state.artikel[index].artikelNr,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArtikelUDPage(
                                      artikel: state.artikel[index])));
                        },
                      );
                    },
                  )),
                ],
              );
            } else if (state is ArtikelErrorState) {
              return Center(child: Text(state.errorMessage));
            } else {
              return const Center(child: Text('Unbekannter Fehler'));
            }
          },
        ),
      ),
    );
  }

/* Das Problem mit Triggern!
void _handleArtikelSearch(String value) {
  if (value.isNotEmpty) {
    //BlocProvider.of<ArtikelBloc>(context).add(ArtikelSearchEvent(value));
    context.read<ArtikelBloc>().add(ArtikelSearchEvent(value));
  } else {
    BlocProvider.of<ArtikelBloc>(context).add(const ArtikelLoadEvent());
  }
}
*/
  Future<String> scanBarcode() async {
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
}
