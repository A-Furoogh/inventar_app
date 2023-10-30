class Lagerplatz {
  final int? platzId;
  final String lager;
  final String regal;
  final String fach;
  final String ebene;

  Lagerplatz({
    this.platzId,
    required this.lager,
    required this.regal,
    required this.fach,
    required this.ebene,
  });

  factory Lagerplatz.fromJson(Map<String, dynamic> json) {
    return Lagerplatz(
      platzId: int.parse(json['platzId']),
      lager: json['lager'],
      regal: json['regal'],
      fach: json['fach'],
      ebene: json['ebene'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platzId': platzId,
      'lager': lager,
      'regal': regal,
      'fach': fach,
      'ebene': ebene,
    };
  }
}