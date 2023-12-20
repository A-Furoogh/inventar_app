import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventar_app/blocs/benutzer_bloc/benutzer_bloc.dart';
import 'package:inventar_app/pages/benutzer_page/crud_benutzer/add_benutzer.dart';

class BenutzerPage extends StatefulWidget {
  const BenutzerPage({super.key});

  @override
  State<BenutzerPage> createState() => _BenutzerPageState();
}

class _BenutzerPageState extends State<BenutzerPage> {

  @override
  void initState() {
    super.initState();
    context.read<BenutzerBloc>().add(const LoadbenutzerEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Benutzer Page'), centerTitle: true),
      body: Center(
        child: BlocBuilder<BenutzerBloc, BenutzerState>(
          builder: (context, state) {
            if (state is BenutzerLoadingState) 
            {
              return const Center(child: CircularProgressIndicator(color: Colors.blue,));
            }
            else if (state is BenutzerLoadedState)
            {
              return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.person, size: 150, color: Colors.grey),
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddbenutzerPage()));
                    },
                    icon: const Icon(Icons.person_add),
                    label: const Text('Benutzer hinzufügen')),
                Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: state.benutzer.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.person, size: 30, ),
                              title: Text(state.benutzer[index].benutzername),
                              titleTextStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                              subtitle: Text(state.benutzer[index].rolle),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red[300]),
                                onPressed: () {
                                  showDialog(context: context, builder:(context) {
                                    return AlertDialog(
                                      title: const Text('Benutzer löschen'),
                                      content: const Text('Möchten Sie den Benutzer wirklich löschen?'),
                                      actions: [
                                        TextButton(onPressed: () {
                                          Navigator.pop(context);
                                        }, child: const Text('Abbrechen')),
                                        TextButton(onPressed: () {
                                          try {
                                            context.read<BenutzerBloc>().add(DeletebenutzerEvent(state.benutzer[index]));
                                          } catch (e) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(e.toString())));
                                          }
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                               backgroundColor: Colors.orange[300],
                                               content: const Text(
                                                    'Benutzer erfolgreich gelöscht', style: TextStyle(color: Colors.black))));
                                          Navigator.pop(context);
                                        }, child: const Text('Löschen')),
                                      ],
                                    );
                                  },);
                                },
                              ),
                              iconColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              tileColor: Colors.grey[200],
                              minVerticalPadding: 20,
                              minLeadingWidth: 20,
                              // style: ListTileStyle.values[index % 2],
                            ),
                            const Divider(
                              height: 20,
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                            ),
                          ],
                        );
                      }),
                ),
              ],
            );
            }
            else
            {
              return const Center(child: Text('Ein Fehler aufgetreten!'));
            }
          },
        ),
      ),
    );
  }
}
