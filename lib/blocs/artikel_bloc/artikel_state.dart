part of 'artikel_bloc.dart';

sealed class ArtikelState extends Equatable {

  final List<Artikel> artikel;

  const ArtikelState(this.artikel);
  
  @override
  List<Object> get props => [];
}

final class ArtikelLoadingState extends ArtikelState {
  const ArtikelLoadingState() : super( const []);

  @override
  List<Object> get props => [];
}

final class ArtikelLoadedState extends ArtikelState {

  final List<Artikel> loadedArtikel;

  const ArtikelLoadedState(this.loadedArtikel)  : super(loadedArtikel);

  @override
  List<Object> get props => [loadedArtikel];
}

final class ArtikelErrorState extends ArtikelState {
  final String errorMessage;

  const ArtikelErrorState(this.errorMessage) : super(const []);

  @override
  List<Object> get props => [errorMessage];
}

final class ArtikelEmptyState extends ArtikelState {
  const ArtikelEmptyState() : super(const []);

  @override
  List<Object> get props => [];
}

final class ArtikelSearchState extends ArtikelState {

  final List<Artikel> searchedArtikel;

  const ArtikelSearchState( this.searchedArtikel) : super(searchedArtikel);

  @override
  List<Object> get props => [ searchedArtikel];
}

// Artikel auswählen und zurückgeben (für Inventur)
final class ArtikelSelectState extends ArtikelState {

  final Artikel selectedArtikel;

  const ArtikelSelectState( this.selectedArtikel) : super(const []);

  @override
  List<Object> get props => [ selectedArtikel];
}