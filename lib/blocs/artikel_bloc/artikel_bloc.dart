import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventar_app/models/artikel.dart';
import 'package:inventar_app/repositories/artikel_repository.dart';

part 'artikel_event.dart';
part 'artikel_state.dart';

class ArtikelBloc extends Bloc<ArtikelEvent, ArtikelState> {

  final ArtikelRepository _artikelRepository;

  ArtikelBloc(this._artikelRepository) : super(const ArtikelLoadingState()) {

    on<ArtikelLoadEvent>((event, emit) async {
      emit(const ArtikelLoadingState());
      try {
        final List<Artikel> artikel = await _artikelRepository.getArtikels();
        emit(ArtikelLoadedState(artikel));
      } catch (e) {
        emit(ArtikelErrorState(e.toString()));
      }
    });

    on<ArtikelAddEvent>((event, emit) async {
      emit(const ArtikelLoadingState());
      try {
        await _artikelRepository.addArtikel(event.artikel);
        final List<Artikel> artikel = await _artikelRepository.getArtikels();
        emit(ArtikelLoadedState(artikel));
      } catch (e) {
        emit(ArtikelErrorState(e.toString()));
      }
    });

    on<ArtikelUpdateEvent>((event, emit) async {
      try {
        emit(const ArtikelLoadingState());
        await _artikelRepository.updateArtikel(event.artikel);
        final List<Artikel> artikel = await _artikelRepository.getArtikels();
        emit(ArtikelLoadedState(artikel));
      } catch (e) {
        emit(ArtikelErrorState(e.toString()));
      }
    });

    on<ArtikelDeleteEvent>((event, emit) async {
      try {
        emit(const ArtikelLoadingState());
        await _artikelRepository.deleteArtikel(event.artikel);
        final List<Artikel> artikel = await _artikelRepository.getArtikels();
        emit(ArtikelLoadedState(artikel));
      } catch (e) {
        emit(ArtikelErrorState(e.toString()));
      }
    });

    on<ArtikelSearchEvent>((event, emit) async {
      try {
        final List<Artikel> artikel = await _artikelRepository.searchArtikel(event.search);
        emit(ArtikelSearchState(artikel));
      } catch (e) {
        emit(ArtikelErrorState(e.toString()));
      }
    });

    on<ArtikelSelectEvent>((event, emit) async {
      try {
        final Artikel artikel = await _artikelRepository.getArtikel(event.artikel.artikelId!);
        emit(ArtikelSelectState(artikel));
      } catch (e) {
        emit(ArtikelErrorState(e.toString()));
      }
    });
    
  }

  Stream<ArtikelState> mapEventToState(ArtikelEvent event) async* {
    if (event is ArtikelSelectEvent) {
      yield ArtikelSelectState(event.artikel);
    }
  }

}
