// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riber_cerra/model/drawer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class TelaPosLogin extends StatefulWidget {
  const TelaPosLogin({super.key});

  @override
  State<TelaPosLogin> createState() => _TelaPosLoginState();
}

class _TelaPosLoginState extends State<TelaPosLogin> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference dados =
      FirebaseFirestore.instance.collection('usuarios');

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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(22, 5, 22, 0),
            height: MediaQuery.of(context).size.height * 0.44,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 3, color: Color.fromARGB(255, 197, 150, 80)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Scaffold(
              body: Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: latLng.LatLng(-21.1767, -47.8208),
                      initialZoom: 8.8,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'mapa');
                      },
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 3.5, color: Colors.white),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.photo_camera,
                      ),
                      backgroundColor: Color.fromARGB(255, 172, 83, 11),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  'Destaque do dia',
                  style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 3,
                      fontFamily: 'Inder',
                      color: Color.fromARGB(255, 37, 105, 62)),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Image.asset('lib/images/Angelim-do-cerrado.png'),
                  ),
                ),
              ],
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(22, 20, 22, 0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width * 1,
          ),
        ],
      ),
      drawer: CreateDrawer().drawer(context),
    );
  }
}
