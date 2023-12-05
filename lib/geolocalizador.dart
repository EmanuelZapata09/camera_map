import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Mapa extends StatefulWidget {
  const Mapa({Key? key}) : super(key: key);

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  late Position _currentPosition;
  late String _locationInfo;

  @override
  void initState() {
    super.initState();
    _getLocationInfo();
  }

  Future<void> _getLocationInfo() async {
    try {
      Position position = await getPosicion();
      setState(() {
        _currentPosition = position;
        _locationInfo =
            'Latitud: ${position.latitude}\nLongitud: ${position.longitude}';
      });
    } catch (e) {
      print('Error al obtener la ubicación: $e');
      setState(() {
        _locationInfo = 'Error al obtener la ubicación';
      });
    }
  }

  Future<Position> getPosicion() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Acceso a la ubicación denegado.");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 1, 158),
        title: const Text('MAPA'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _locationInfo ?? 'Presiona el botón para obtener la ubicación',
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getLocationInfo();
              },
              child: const Text('Obtener Ubicación'),
            ),
          ],
        ),
      ),
    );
  }
}
