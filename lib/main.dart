import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Band {
  String nombre;
  String album;
  int anio;
  int votos;

  Band(
      {required this.nombre,
      required this.album,
      required this.anio,
      this.votos = 0});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Votos',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: CrearBanda(),
    );
  }
}

class CrearBanda extends StatefulWidget {
  @override
  _CrearBandaScreenState createState() => _CrearBandaScreenState();
}

class _CrearBandaScreenState extends State<CrearBanda> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _albumController = TextEditingController();
  final TextEditingController _anioController = TextEditingController();

  List<Band> bands = [];

  void _addBand() {
    setState(() {
      bands.add(
        Band(
          nombre: _nombreController.text,
          album: _albumController.text,
          anio: int.parse(_anioController.text),
        ),
      );
    });

    _nombreController.clear();
    _albumController.clear();
    _anioController.clear();
  }

  void _viewBands() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BandListScreen(bands: bands),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Banda'),
        backgroundColor: Colors.purple[300],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre de la banda'),
            ),
            TextField(
              controller: _albumController,
              decoration: InputDecoration(labelText: 'Nombre del album'),
            ),
            TextField(
              controller: _anioController,
              decoration: InputDecoration(labelText: 'Año de lanzamiento'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _addBand,
              child: Text('Añadir Banda'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple[100],
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _viewBands,
              child: Text('Vizualizar Banda'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple[100],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.purple[200],
    );
  }
}

class BandListScreen extends StatefulWidget {
  final List<Band> bands;

  BandListScreen({required this.bands});

  @override
  _BandListScreenState createState() => _BandListScreenState();
}

class _BandListScreenState extends State<BandListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Bandas'),
        backgroundColor: Colors.purple[300],
      ),
      body: ListView.builder(
        itemCount: widget.bands.length,
        itemBuilder: (context, index) {
          final band = widget.bands[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                band.votos++;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 218, 125, 197),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre de la Banda: ${band.nombre}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Nombre del album: ${band.album}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Año de lanzamiento: ${band.anio}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Votos: ${band.votos}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.purple[200],
    );
  }
}
