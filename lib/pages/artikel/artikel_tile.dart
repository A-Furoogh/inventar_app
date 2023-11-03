import 'package:flutter/material.dart';

class ArtikelTile extends StatelessWidget {

  final String? image;
  final String bezeichnung;
  final String artikelId;
  final int bestand;
  final int? mindestbestand;
  final int? bestellgrenze;
  final int? lagerplatzId;
  final String? beschreibung;


  const ArtikelTile({super.key, this.image, required this.bezeichnung, required this.artikelId, required this.bestand, this.mindestbestand = 0, this.bestellgrenze = 0, this.lagerplatzId = 0, this.beschreibung= ' '});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: const Color.fromARGB(255, 209, 235, 212),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded( flex: 1,
                child: Column(
                  children: [
                    Image(
                        image: AssetImage(image ?? 'assets/images/default_artikel.png'),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'Art.ID: $artikelId',
                        style: const TextStyle(fontSize: 16),
                      ),
                  ],
                )),
              const SizedBox(width: 2),
              Expanded(flex: 2,
                child: Column(
                  children: [
                    Text(
                      bezeichnung,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Bestand: $bestand',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text( 
                      'Min.bestand: $mindestbestand',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),),
                const SizedBox(width: 2),
                Expanded(flex: 2,
                  child: Column(
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
                        'Beschreibung: $beschreibung',
                        style: const TextStyle(fontSize: 16),
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