import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventar_app/models/benutzer.dart';
import 'package:inventar_app/repositories/benutzer_repository.dart';

part 'benutzer_event.dart';
part 'benutzer_state.dart';

class BenutzerBloc extends Bloc<BenutzerEvent, BenutzerState> {

  final BenutzerRepository _benutzerRepository;

  BenutzerBloc(this._benutzerRepository) : super(const BenutzerLoadingState()) {

    on<AddbenutzerEvent>((event, emit) async {
      emit(const BenutzerLoadingState());
      try {
        await _benutzerRepository.addBenutzer(event.benutzer);
        List<Benutzer> benutzer = await _benutzerRepository.getBenutzer();
        emit(BenutzerLoadedState(benutzer));
      } catch (e) {
        emit(BenutzerErrorState(e.toString()));
      }
    });

    on<DeletebenutzerEvent>((event, emit) async {
      emit(const BenutzerLoadingState());
      try {
        await _benutzerRepository.deleteBenutzer(event.benutzer);
        List<Benutzer> benutzer = await _benutzerRepository.getBenutzer();
        emit(BenutzerLoadedState(benutzer));
      } catch (e) {
        emit(BenutzerErrorState(e.toString()));
      }
    });

    on<UpdatebenutzerEvent>((event, emit) async {
      emit(const BenutzerLoadingState());
      try {
        await _benutzerRepository.updateBenutzer(event.benutzer);
        List<Benutzer> benutzer = await _benutzerRepository.getBenutzer();
        emit(BenutzerLoadedState(benutzer));
      } catch (e) {
        emit(BenutzerErrorState(e.toString()));
      }
    });

    on<LoadbenutzerEvent>((event, emit) async {
      emit(const BenutzerLoadingState());
      try {
        List<Benutzer> benutzer = await _benutzerRepository.getBenutzer();
        emit(BenutzerLoadedState(benutzer));
      } catch (e) {
        emit(BenutzerErrorState(e.toString()));
      }
    });
    
  }
}
