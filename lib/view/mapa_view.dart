// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../model/drawer.dart';
import 'package:latlong2/latlong.dart' as latLng;

class TelaMapaView extends StatefulWidget {
  const TelaMapaView({super.key});

  @override
  State<TelaMapaView> createState() => _TelaMapaViewState();
}

class _TelaMapaViewState extends State<TelaMapaView> {
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
        children: [
          FlutterMap(
            options: MapOptions(
              center: latLng.LatLng(51.509364, -0.128928),
              zoom: 3.2,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
            ],
          ),
        ],
      ),
      drawer: CreateDrawer().drawer(context),
    );
  }
}
