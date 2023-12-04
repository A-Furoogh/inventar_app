import 'dart:convert';

import 'package:flutter/material.dart';

class ArtikelTile extends StatelessWidget {

  final String? image;
  final String bezeichnung;
  final String artikelId;
  final int bestand;
  final int? mindestbestand;
  final int? bestellgrenze;
  final String? lagerplatzId;
  final String? beschreibung;
  final String? artikelNr;

  final bool? isLagerArtikel;


  const ArtikelTile({super.key, this.image, required this.bezeichnung, required this.artikelId, required this.bestand, this.mindestbestand = 0, this.bestellgrenze = 0, this.lagerplatzId = '', this.beschreibung= ' ', this.artikelNr = '', this.isLagerArtikel = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: isLagerArtikel == true ? const Color.fromARGB(255, 209, 226, 235) : const Color.fromARGB(255, 209, 235, 212),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded( flex: 1,
                child: Column(
                  children: [
                    if (image != null)
                      Image.memory(
                        base64Decode(image!),
                        width: 100,
                        height: 100,
                      ),
                    if (image == null)
                      Image.asset(
                        'assets/images/default_artikel.png',
                        width: 100,
                        height: 100,
                      ),
                      
                  ],
                )),
              const SizedBox(width: 2),
              Expanded(flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bezeichnung,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                        'Prod.Nr: $artikelNr',
                        style: const TextStyle(fontSize: 16),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      'Bestand: $bestand',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text( 
                      'Min.bestand: $mindestbestand',
                      style: TextStyle(fontSize: 16, color: mindestbestand! > bestand ? Colors.red : Colors.black87), // Hier wurde eine Änderung durchgeführt.
                    ),
                  ],
                ),),
                const SizedBox(width: 2),
                Expanded(flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LagerPlatz ID: $lagerplatzId',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Bestellgrenze: $bestellgrenze',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$beschreibung',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}