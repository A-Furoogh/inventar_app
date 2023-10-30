part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class LoadBenutzerEvent extends AuthEvent {

  final List<Benutzer> benutzer;

  const LoadBenutzerEvent(this.benutzer);

  @override
  List<Object> get props => [];
}

final class SignUpEvent extends AuthEvent {

  final Benutzer benutzer;

  const SignUpEvent(this.benutzer);

  @override
  List<Object> get props => [];
}

final class LoginEvent extends AuthEvent {

  final String benutzername;
  final String passwort;

  const LoginEvent(this.benutzername, this.passwort);

  @override
  List<Object> get props => [];
}

final class LogoutEvent extends AuthEvent {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}
