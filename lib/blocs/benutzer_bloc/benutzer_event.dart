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

class DeletebenutzerEvent extends BenutzerEvent {
  final Benutzer benutzer;

  const DeletebenutzerEvent(this.benutzer);

  @override
  List<Object> get props => [benutzer];
}

class UpdatebenutzerEvent extends BenutzerEvent {
  final Benutzer benutzer;

  const UpdatebenutzerEvent(this.benutzer);

  @override
  List<Object> get props => [benutzer];
}

class LoadbenutzerEvent extends BenutzerEvent {
  const LoadbenutzerEvent();

  @override
  List<Object> get props => [];
}
