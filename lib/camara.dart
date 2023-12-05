import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';

class Imagen extends StatefulWidget {
  const Imagen({Key? key}) : super(key: key);

  @override
  State<Imagen> createState() => _ImagenState();
}

File? imagen;
final picker = ImagePicker();

class _ImagenState extends State<Imagen> {
  Future<void> selImagen(int op) async {
    var pickedFile;
    if (op == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      setState(() {
        imagen = File(pickedFile.path);
      });

      // Guardar la imagen en la galería
      GallerySaver.saveImage(imagen!.path).then((result) {
        if (result != null) {
          print('Imagen guardada en la galería: $result');
        } else {
          print('Error al guardar la imagen en la galería');
        }
      });
    }
  }

  opciones(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    selImagen(1);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey))),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tomar una foto',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(Icons.camera_alt, color: Colors.blue)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    selImagen(2);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Seleccionar una foto',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(Icons.image, color: Colors.blue)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(color: Colors.red),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text('Cancelar',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camara'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    opciones(context);
                  },
                  child: const Text('Seleccione la imagen'),
                ),
                const SizedBox(
                  height: 30,
                ),
                imagen == null ? const Center() : Image.file(imagen!)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
