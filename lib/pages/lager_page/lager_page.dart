import 'package:flutter/material.dart';

class LagerPage extends StatelessWidget {
  const LagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lager'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lager Code Scannen um nach Artikeln zu suchen
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.blue[100],
              child: Column(
                children: [
                  const Text('Lagerplatz scannen', style: TextStyle(fontSize: 20)),
            ElevatedButton.icon(
              onPressed: () {

              }, 
              icon: Icon(Icons.qr_code_scanner), 
              label: Text('Lager Code Scannen'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
              ),),
            // Lager Code manuell eingeben um nach Artikeln zu suchen
            Text('Lager Code manuell eingeben', style: TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Lager Code',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                  }, 
                  child: Text('Suchen'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                  ),),
              ],
            ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}