class Artikel {
  final int? artikelId;
  final String bezeichnung;
  final String? beschreibung;
  final int bestand;
  final int? mindestbestand;
  final int? bestellgrenze;
  String? image;
  final String? lagerplatzId;

  Artikel({
    this.artikelId,
    required this.bezeichnung,
    this.beschreibung,
    required this.bestand,
    this.mindestbestand,
    this.bestellgrenze,
    this.image,
    this.lagerplatzId,
  });

  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
      artikelId: int.parse(json['artikelId']),
      bezeichnung: json['bezeichnung'],
      beschreibung: json['beschreibung'],
      bestand: int.parse(json['bestand']),
      mindestbestand: json['mindestbestand'] != null ? int.parse(json['mindestbestand']) : null,
      bestellgrenze: json['bestellgrenze'] != null ? int.parse(json['bestellgrenze']) : null,
      image: json['image'],
      lagerplatzId: json['lagerplatzId'] ?? json['lagerplatzId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artikelId': artikelId,
      'bezeichnung': bezeichnung,
      'beschreibung': beschreibung,
      'bestand': bestand,
      'mindestbestand': mindestbestand,
      'bestellgrenze': bestellgrenze,
      'image': image,
      'lagerplatzId': lagerplatzId,
    };
  }
}