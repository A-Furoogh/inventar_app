part of 'benutzer_bloc.dart';

sealed class BenutzerEvent extends Equatable {
  const BenutzerEvent();

  @override
  List<Object> get props => [];
}

class AddbenutzerEvent extends BenutzerEvent {
  final Benutzer benutzer;

  const AddbenutzerEvent(this.benutzer);

  @override
  List<Object> get props => [benutzer];
}
