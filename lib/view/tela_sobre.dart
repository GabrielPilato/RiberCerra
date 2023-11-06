// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:riber_cerra/controller/login_controller.dart';

import '../model/drawer.dart';

class TelaSobreView extends StatelessWidget {
  const TelaSobreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey();
    return Scaffold(
      key: key,
      backgroundColor: Color.fromARGB(255, 245, 255, 244),
      appBar: AppBar(
        leading: LoginController().usuarioEstaLogado()
            ? IconButton(
                onPressed: () {
                  key.currentState!.openDrawer();
                },
                icon: Icon(Icons.menu))
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          'Sobre Nós',
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Icon(
              Icons.local_florist,
              size: 100,
              color: Color.fromARGB(255, 112, 143, 112),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.all(50),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 224, 255, 223),
                boxShadow: [
                  BoxShadow(color: Color.fromARGB(255, 224, 255, 223)),
                ],
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Color.fromARGB(255, 224, 255, 223),
                      Color.fromARGB(195, 200, 237, 156),
                      Color.fromARGB(204, 73, 163, 107),
                    ])),
            height: 200,
            width: 200,
          ),
          Text('Sobre o App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Inder',
              )),
          Container(
              margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Text(
                'Bem Vindo ao RiberCerra!\n Este é um pojeto open-source realizado por 2 estudantes da FATEC - Ribeirão Preto, a aplicação se encontra em constante desenvolvimento e ainda temos muitas ideias para implementar!\n\nIntegrantes: \n Gabriel Leandro de Araujo Pilato\n\nAna Carolina da Silva Gomes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Inder',
                ),
              )),
        ],
      ),
      drawer: CreateDrawer().drawer(context),
      drawerEnableOpenDragGesture: false,
    );
  }
}
