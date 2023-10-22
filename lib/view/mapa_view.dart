// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../model/drawer.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:riber_cerra/controller/plantas_controller.dart';

class TelaMapaView extends StatefulWidget {
  const TelaMapaView({super.key});

  @override
  State<TelaMapaView> createState() => _TelaMapaViewState();
}

class _TelaMapaViewState extends State<TelaMapaView> {
  /*
  static final _markers = List<Marker>.generate(
    1,
    (x) => Marker(
      point: latLng.LatLng(-21.1767, -47.8208),
      width: 80,
      height: 80,
      child: Icon(
        Icons.location_on,
        color: Color.fromARGB(255, 54, 179, 118),
        size: 40,
      ),
    ),
  );
  */

  

  Widget loadMap() {
    List<Marker> _markers = [];
    return FutureBuilder<QuerySnapshot>(
        future: PlantaController()
            .listarPlanta("df2959d0-0a73-11ee-a420-7f416d02b24a"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text("Carregando mapa...");

          dynamic planta = snapshot.requireData.docs[0].data();
          List<dynamic> coordenadas = planta['markers'];

          for (int i = 0; i < coordenadas.length; i++) {
            _markers.add(Marker(
              point: latLng.LatLng(
                  coordenadas[i].latitude, coordenadas[i].longitude),
              child: Icon(
                Icons.location_on,
                color: Color.fromARGB(255, 54, 179, 118),
                size: 40,
              ),
            ));
          }
          return FlutterMap(
            options: MapOptions(
              center: latLng.LatLng(-21.1767, -47.8208),
              zoom: 12,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: _markers),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 255, 244),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'RiberCerra',
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Color.fromARGB(255, 121, 226, 175),
        actions: [
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Função indisponível no momento')));
            },
            icon: Icon(
              Icons.accessibility,
              color: Color.fromARGB(255, 54, 179, 118),
              size: 40,
            ),
            tooltip: 'Acessibilidade',
          )
        ],
      ),
      body: Stack(
        children: [loadMap()],
      ),
      drawer: CreateDrawer().drawer(context),
    );
  }
}
