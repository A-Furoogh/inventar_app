class Artikel {
  final String? artikelId;
  final String? bezeichnung;
  final String? beschreibung;
  final int? bestand;
  final int? mindestbestand;
  final int? bestellgrenze;
  String? image;
  final String? lagerplatzId;
  final String? ean;
  final String? taxId;


  Artikel({
    this.artikelId,
    required this.bezeichnung,
    this.beschreibung,
    required this.bestand,
    this.mindestbestand,
    this.bestellgrenze,
    this.image,
    this.lagerplatzId,
    this.ean,
    this.taxId,
  });

  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
      artikelId: json['id'] as String?,
      bezeichnung: json['name'] as String?,
      beschreibung: json['description'] as String?,
      bestand: json['stock'] as int?,
      mindestbestand: json['customFields']?['rmd_wawi_min_stock'] as int?,
      bestellgrenze: json['customFields']?['rmd_wawi_order_amount'] as int?,
      image: json['included']?['url'] as String?,
      lagerplatzId: json['customFields']?['rmd_wawi_lagerplatz'] as String?, // falls das Feld nicht existiert.
      ean: json['ean'] as String?,
    );
  }

  Map<String, dynamic> toJson({String? taxId}) {
    Map<String, dynamic> json = {
      if (bezeichnung != null) 'name': bezeichnung, // required
      if (beschreibung != null) 'description': beschreibung,
      if (bestand != null) 'stock': bestand, // required
      'customFields': {
        if (mindestbestand != null) 'rmd_wawi_min_stock': mindestbestand,
        if (bestellgrenze != null) 'rmd_wawi_order_amount': bestellgrenze,
        if (lagerplatzId != null) 'rmd_wawi_lagerplatz': lagerplatzId,
      },
      if (image != null) 'image': image,
      if (ean != null) 'ean': ean,
      if (artikelId == null) 'taxId': taxId, // required
      if (artikelId == null) 'productNumber': generateProductNumber(), // required  !!! wird mit einer Random productNumber generiert
      
  };
    if (artikelId == null){ 
      json['price'] = [
        {
          'gross': 0.0, // required
          'net': 0.0, // required
          'linked': false, // required
          'currencyId': 'b7d2554b0ce847cd82f3ac9bd1c0dfca', // required
        }
      ];
    }
  return json;
}

 // generiere eine Random productNumber für den Artikel
  static String generateProductNumber() {
    return 'RMD-${DateTime.now().millisecondsSinceEpoch}';
  }

  /*static String removeHtmlTags(String htmlString) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlString.replaceAll(exp, '');
  }*/

}