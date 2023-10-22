// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riber_cerra/model/drawer.dart';
import 'package:riber_cerra/view/mapa_view.dart' show TelaMapaView;

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
            child: TelaMapaView(),
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
