import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventar_app/models/benutzer.dart';
import 'package:inventar_app/repositories/benutzer_repository.dart';

part 'benutzer_event.dart';
part 'benutzer_state.dart';

class BenutzerBloc extends Bloc<BenutzerEvent, BenutzerState> {

  final BenutzerRepository _benutzerRepository;

  BenutzerBloc(this._benutzerRepository) : super(const BenutzerInitial()) {

    on<AddbenutzerEvent>((event, emit) async {
      emit(const BenutzerLoading());
      try {
        await _benutzerRepository.addBenutzer(event.benutzer);
        List<Benutzer> benutzer = await _benutzerRepository.getBenutzer();
        emit(BenutzerLoaded(benutzer));
      } catch (e) {
        emit(BenutzerError(e.toString()));
      }
    });

    
  }
}
