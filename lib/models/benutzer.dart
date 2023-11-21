class Benutzer {
  final int? benutzerId;
  final String benutzername;
  final String passwort;
  final String rolle;

  Benutzer({this.benutzerId, required this.benutzername, required this.passwort, required this.rolle});

  factory Benutzer.fromJson(Map<String, dynamic> json) {
    return Benutzer(
      benutzerId: int.parse(json['benutzerId']),
      benutzername: json['benutzername'],
      passwort: json['passwort'],
      rolle: json['rolle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'benutzerId': benutzerId,
      'benutzername': benutzername,
      'passwort': passwort,
      'rolle': rolle,
    };
  }
}