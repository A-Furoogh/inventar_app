import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventar_app/models/benutzer.dart';
import 'package:inventar_app/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const UnauthenticatedState()) {
    
    on<LoginEvent>((event, emit) async {
      emit(const AuthLoadingState());
      try {
        final benutzer = await _authRepository.login(event.benutzername, event.passwort);
        emit(AuthenticatedState(benutzer));
      } catch (e) {
        emit(const UnauthenticatedState());
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(const AuthLoadingState());
      try {
        await _authRepository.logout();
        emit(const UnauthenticatedState());
      } catch (e) {
        emit(const UnauthenticatedState());
      }
    });
  }
/*
  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoadBenutzerEvent) {
      yield* _mapLoadBenutzerEventToState(event);
    } else if (event is SignUpEvent) {
      yield* _mapSignUpEventToState(event);
    } else if (event is LoginEvent) {
      yield* _mapLoginEventToState(event);
    } else if (event is LogoutEvent) {
      yield* _mapLogoutEventToState(event);
    }
  }

  Stream<AuthState> _mapLoadBenutzerEventToState(LoadBenutzerEvent event) async* {
    yield AuthenticatedState(event.benutzer);
  }

  Stream<AuthState> _mapSignUpEventToState(SignUpEvent event) async* {
    yield AuthenticatedState(event.benutzer);
  }

  Stream<AuthState> _mapLoginEventToState(LoginEvent event) async* {
    yield AuthenticatedState(event.benutzername);
  }

  Stream<AuthState> _mapLogoutEventToState(LogoutEvent event) async* {
    yield const UnauthenticatedState();
  }
*/
}

