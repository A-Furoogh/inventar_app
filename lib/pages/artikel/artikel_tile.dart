import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtikelTile extends StatelessWidget {
  final String? image;
  final String bezeichnung;
  final String artikelId;
  final int? bestand;
  final int? mindestbestand;
  final int? bestellgrenze;
  final String? lagerplatzId;
  final String? artikelNr;

  final bool? isLagerArtikel;

  const ArtikelTile(
      {super.key,
      this.image,
      required this.bezeichnung,
      required this.artikelId,
      this.bestand = 0,
      this.mindestbestand = 0,
      this.bestellgrenze = 0,
      this.lagerplatzId = '',
      this.artikelNr = '',
      this.isLagerArtikel = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: isLagerArtikel == true
            ? const Color.fromARGB(255, 209, 226, 235)
            : const Color.fromARGB(255, 209, 235, 212),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                // check if image is null or does not start with 'file://' (local image)
                child: image == null || image!.startsWith('file://')
                    ? Image.asset(
                        'assets/images/default_artikel.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ) :
                      CachedNetworkImage(
                        imageUrl: image!,
                        placeholder: (context, url) => Image.asset('assets/images/default_artikel.png', height: 100, width: 100, fit: BoxFit.cover,),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
              ),
              const SizedBox(width: 2),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      bezeichnung,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Prod.Nr: ${artikelNr ?? 'keine Nr.'}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Bestand: ${bestand ?? 0} stk',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Min.bestand: ${mindestbestand ?? 0}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: /*widget.mindestbestand! > widget.bestand ? Colors.red :*/
                                        Colors
                                            .black87), // Hier wurde eine Änderung durchgeführt.
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LagerPlatz ID: ${lagerplatzId ?? '  nicht zugeordnet'}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Bestellgrenze: $bestellgrenze',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'ID: $artikelId',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
