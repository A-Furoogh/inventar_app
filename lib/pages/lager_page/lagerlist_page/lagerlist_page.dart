import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventar_app/blocs/artikel_bloc/artikel_bloc.dart';
import 'package:inventar_app/pages/artikel/artikel_tile.dart';
import 'package:inventar_app/pages/lager_page/lagerlist_page/lagerartikel_page/lagerartikel_page.dart';

class LagerListPage extends StatefulWidget {

  final String lagerId;

  const LagerListPage({super.key, required this.lagerId});

  @override
  State<LagerListPage> createState() => _LagerListPageState();
}

class _LagerListPageState extends State<LagerListPage> {

  @override
  void initState() {
    super.initState();
    context.read<ArtikelBloc>().add(LoadLagerArtikelEvent(widget.lagerId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lager: ${widget.lagerId}'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<ArtikelBloc, ArtikelState>(
        builder: (context, state) {
          if ( state is ArtikelLoadingState) 
          {
            return const Center(child: CircularProgressIndicator(color: Colors.blue,));
          } 
          else if (state is LagerArtikelLoadedState) 
          {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.artikel.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Padding(padding: const EdgeInsets.all(8.0),
                          child: ArtikelTile(
                            isLagerArtikel: true,
                            image: state.artikel[index].image,
                            bezeichnung: state.artikel[index].bezeichnung,
                            artikelId: state.artikel[index].artikelId.toString(),
                             bestand: state.artikel[index].bestand,
                             mindestbestand: state.artikel[index].mindestbestand,
                             lagerplatzId: state.artikel[index].lagerplatzId,
                             bestellgrenze: state.artikel[index].bestellgrenze,
                             beschreibung: state.artikel[index].beschreibung,
                             artikelNr: state.artikel[index].artikelNr,
                        ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LagerArtikelPage(artikel: state.artikel[index],)));
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
          else if (state is ArtikelErrorState) 
          {
            return Center(child: Text(state.errorMessage));
          }
          else 
          {
            return const Center(child: Text('Ein Fehler aufgetreten!'));
          }
        },
      ),
    );
  }
}