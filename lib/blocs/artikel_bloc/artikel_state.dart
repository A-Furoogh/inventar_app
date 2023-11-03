part of 'artikel_bloc.dart';

sealed class ArtikelState extends Equatable {
  const ArtikelState();
  
  @override
  List<Object> get props => [];
}

final class ArtikelLoadingState extends ArtikelState {
  const ArtikelLoadingState();

  @override
  List<Object> get props => [];
}

final class ArtikelLoadedState extends ArtikelState {
  final List<Artikel> artikel;

  const ArtikelLoadedState(this.artikel);

  @override
  List<Object> get props => [artikel];
}

final class ArtikelErrorState extends ArtikelState {
  final String errorMessage;

  const ArtikelErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class ArtikelEmptyState extends ArtikelState {
  const ArtikelEmptyState();

  @override
  List<Object> get props => [];
}
