import 'package:camara/camara.dart';
import 'package:camara/geolocalizador.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
    Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 6, 1, 158),
          title: const Text('Configuraciones'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camara'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Imagen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.map_outlined),
                title: const Text('Geolocalizacion'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Mapa()));
                },
              ),
            
            ],
          ),
        ),

      ),
    );
  }
}