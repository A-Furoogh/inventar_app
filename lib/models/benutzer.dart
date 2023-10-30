class Benutzer {
  final int? benutzerId;
  final String benutzername;
  final String passwort;

  Benutzer({this.benutzerId, required this.benutzername, required this.passwort});

  factory Benutzer.fromJson(Map<String, dynamic> json) {
    return Benutzer(
      benutzerId: int.parse(json['benutzerId']),
      benutzername: json['benutzername'],
      passwort: json['passwort'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'benutzerId': benutzerId,
      'benutzername': benutzername,
      'passwort': passwort,
    };
  }
}