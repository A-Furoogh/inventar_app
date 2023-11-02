import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventar_app/repositories/artikel_repository.dart';

part 'artikel_event.dart';
part 'artikel_state.dart';

class ArtikelBloc extends Bloc<ArtikelEvent, ArtikelState> {

  final ArtikelRepository _artikelRepository;

  ArtikelBloc(this._artikelRepository) : super(ArtikelInitial()) {


    on<ArtikelEvent>((event, emit) {
    });
    
  }
}
