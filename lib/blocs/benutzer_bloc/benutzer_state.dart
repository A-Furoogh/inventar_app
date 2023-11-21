part of 'benutzer_bloc.dart';

sealed class BenutzerState extends Equatable {
  const BenutzerState();
  
  @override
  List<Object> get props => [];
}

// Initial state
final class BenutzerInitial extends BenutzerState {
  const BenutzerInitial();

  @override
  List<Object> get props => [];
}

final class BenutzerLoading extends BenutzerState {
  const BenutzerLoading();

  @override
  List<Object> get props => [];
}

final class BenutzerLoaded extends BenutzerState {
  final List<Benutzer> benutzer;

  const BenutzerLoaded(this.benutzer);

  @override
  List<Object> get props => [benutzer];
}

final class BenutzerError extends BenutzerState {
  final String message;

  const BenutzerError(this.message);

  @override
  List<Object> get props => [message];
}


