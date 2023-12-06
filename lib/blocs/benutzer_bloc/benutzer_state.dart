part of 'benutzer_bloc.dart';

sealed class BenutzerState extends Equatable {
  const BenutzerState();
  
  @override
  List<Object> get props => [];
}

// Initial state
final class BenutzerInitialState extends BenutzerState {
  const BenutzerInitialState();

  @override
  List<Object> get props => [];
}

final class BenutzerLoadingState extends BenutzerState {
  const BenutzerLoadingState();

  @override
  List<Object> get props => [];
}

final class BenutzerLoadedState extends BenutzerState {
  final List<Benutzer> benutzer;

  const BenutzerLoadedState(this.benutzer);

  @override
  List<Object> get props => [benutzer];
}

final class BenutzerErrorState extends BenutzerState {
  final String message;

  const BenutzerErrorState(this.message);

  @override
  List<Object> get props => [message];
}


