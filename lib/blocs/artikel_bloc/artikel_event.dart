part of 'artikel_bloc.dart';

sealed class ArtikelEvent extends Equatable {
  const ArtikelEvent();

  @override
  List<Object> get props => [];
}

final class ArtikelLoadEvent extends ArtikelEvent {
  const ArtikelLoadEvent();

  @override
  List<Object> get props => [];
}

final class ArtikelAddEvent extends ArtikelEvent {
  final Artikel artikel;

  const ArtikelAddEvent(this.artikel);

  @override
  List<Object> get props => [artikel];
}

final class ArtikelUpdateEvent extends ArtikelEvent {
  final Artikel artikel;

  const ArtikelUpdateEvent(this.artikel);

  @override
  List<Object> get props => [artikel];
}

final class ArtikelDeleteEvent extends ArtikelEvent {
  final Artikel artikel;

  const ArtikelDeleteEvent(this.artikel);

  @override
  List<Object> get props => [artikel];
}

final class ArtikelSearchEvent extends ArtikelEvent {
  final String search;

  const ArtikelSearchEvent(this.search);

  @override
  List<Object> get props => [search];
}

// Artikel auswählen und zurückgeben (für Inventur)
final class ArtikelSelectEvent extends ArtikelEvent {
  final Artikel artikel;

  const ArtikelSelectEvent(this.artikel);

  @override
  List<Object> get props => [artikel];
}

/*
final class ArtikelClearEvent extends ArtikelEvent {
  const ArtikelClearEvent();

  @override
  List<Object> get props => [];
}


final class ArtikelSortEvent extends ArtikelEvent {
  final String sort;

  const ArtikelSortEvent(this.sort);

  @override
  List<Object> get props => [sort];
}

final class ArtikelFilterEvent extends ArtikelEvent {
  final String filter;

  const ArtikelFilterEvent(this.filter);

  @override
  List<Object> get props => [filter];
}
*/


