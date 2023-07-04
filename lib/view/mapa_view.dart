// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../model/drawer.dart';

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
      body: Image.asset(
        'lib/images/MapaPrincipal.png',
        fit: BoxFit.fill,
        height: double.infinity,
      ),
      drawer: CreateDrawer().drawer(context),
    );
  }
}
