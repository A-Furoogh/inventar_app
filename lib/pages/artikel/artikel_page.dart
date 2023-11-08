import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventar_app/blocs/artikel_bloc/artikel_bloc.dart';
import 'package:inventar_app/pages/artikel/artikel_crud/artikel_update_delete_page.dart';
import 'package:inventar_app/pages/artikel/artikel_tile.dart';
import 'package:inventar_app/pages/artikel/artikel_crud/artikel_add/artikel_add_page.dart';
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
      child: BlocProvider(
        create: (context) => ArtikelBloc(_artikelRepository)..add(const ArtikelLoadEvent()),
        child: BlocBuilder<ArtikelBloc, ArtikelState>(
          builder: (context, state) {
            if (state is ArtikelLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ArtikelLoadedState || state is ArtikelSearchState) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 2, 4),
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Suche nach Bezeichnung oder ID',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  BlocProvider.of<ArtikelBloc>(context).add(ArtikelSearchEvent(value));
                                } else {
                                  BlocProvider.of<ArtikelBloc>(context).add(const ArtikelLoadEvent());
                                }
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<ArtikelBloc>(context).add(const ArtikelLoadEvent());
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ),
                  // Add artikel button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ArtikelAddPage()));
                        },
                        child: const Text('Artikel hinzufügen +'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                            itemCount: state.artikel.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ArtikelTile(
                                    image: state.artikel[index].image,
                                    bezeichnung: state.artikel[index].bezeichnung,
                                    artikelId: state.artikel[index].artikelId.toString(),
                                    bestand: state.artikel[index].bestand,
                                    mindestbestand: state.artikel[index].mindestbestand,
                                    lagerplatzId: state.artikel[index].lagerplatzId,
                                    bestellgrenze: state.artikel[index].bestellgrenze,
                                    beschreibung: state.artikel[index].beschreibung,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ArtikelUDPage(artikel: state.artikel[index])));
                                },
                              );
                            },
                          )
                  ),
                ],
              );
            } else if (state is ArtikelErrorState) {
              return Center(child: Text(state.errorMessage));
            } else {
              return const Center(child: Text('Unbekannter Fehler'));
            }
          },
        ),
      ),
    ),
  );
}
}