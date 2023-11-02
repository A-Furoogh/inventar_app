class Lagerplatz {
  final int? platzId;
  final String lager;
  final int regal;
  final int fach;
  final int ebene;

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
      regal: int.parse(json['regal']),
      fach: int.parse(json['fach']),
      ebene: int.parse(json['ebene']),
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