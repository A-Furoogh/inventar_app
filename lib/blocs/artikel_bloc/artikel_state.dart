part of 'artikel_bloc.dart';

sealed class ArtikelState extends Equatable {
  const ArtikelState();
  
  @override
  List<Object> get props => [];
}

final class ArtikelInitial extends ArtikelState {}
