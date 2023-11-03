import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventar_app/blocs/artikel_bloc/artikel_bloc.dart';
import 'package:inventar_app/pages/artikel/artikel_tile.dart';
import 'package:inventar_app/repositories/artikel_repository.dart';

class ArtikelPage extends StatefulWidget {
  const ArtikelPage({super.key});

  @override
  State<ArtikelPage> createState() => _ArtikelPageState();
}

class _ArtikelPageState extends State<ArtikelPage> {

  final ArtikelRepository _artikelRepository = ArtikelRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artikel'), centerTitle: true),
      body: Center(
        child: BlocProvider(create: (context) => ArtikelBloc( _artikelRepository)..add(const ArtikelLoadEvent()), child: BlocBuilder<ArtikelBloc, ArtikelState>(builder: (context, state) {
          if (state is ArtikelLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ArtikelLoadedState) {
            if(state is ArtikelSearchState){ ////////////////////////////////
              return ListView.builder(
                itemCount: state.artikel.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ArtikelTile(image: state.artikel[index].image, bezeichnung: state.artikel[index].bezeichnung, artikelId: state.artikel[index].artikelId.toString(), bestand: state.artikel[index].bestand)
                  );
                },
              );
            }
            else {
            return ListView.builder(
              itemCount: state.artikel.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ArtikelTile(image: state.artikel[index].image, bezeichnung: state.artikel[index].bezeichnung, artikelId: state.artikel[index].artikelId.toString(), bestand: state.artikel[index].bestand)
                );
              },
            );
            }
          } else if (state is ArtikelErrorState) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const Center(child: Text('Unbekannter Fehler'));
          }
        })
        ),
      ),
    );
  }
}