part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthLoadingState extends AuthState {
  const AuthLoadingState();

  @override
  List<Object> get props => [];
}

final class AuthenticatedState extends AuthState {

  final Benutzer benutzer;

  const AuthenticatedState(this.benutzer);

  @override
  List<Object> get props => [];
}

final class UnauthenticatedState extends AuthState {
  const UnauthenticatedState();

  @override
  List<Object> get props => [];
}
