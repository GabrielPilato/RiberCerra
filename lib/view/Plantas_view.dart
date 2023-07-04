// ignore_for_file: file_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:riber_cerra/controller/plantas_controller.dart';

class TelaPlantasView extends StatefulWidget {
  const TelaPlantasView({super.key});

  @override
  State<TelaPlantasView> createState() => _TelaPlantasViewState();
}

class _TelaPlantasViewState extends State<TelaPlantasView> {
  @override
  Widget build(BuildContext context) {
    var pid = ModalRoute.of(context)!.settings.arguments as String;

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
        body: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: FutureBuilder<QuerySnapshot>(
                    future: PlantaController().listarPlanta(pid),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: Text(
                                "Não foi possivel conectar, verifique sua conexão de internet e tente novamente"),
                          );
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          dynamic planta = snapshot.requireData.docs[0].data();
                          Timestamp dataCadastro =
                              planta['dataCadastro'] as Timestamp;
                          Timestamp dataAtualizacao =
                              planta['dataAtualizacao'] as Timestamp;
                          DateTime cadastro = dataCadastro.toDate();
                          DateTime atualizacao = dataAtualizacao.toDate();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder<String>(
                                  future: PlantaController().getlink(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: Text('Carregando a foto...'));
                                    } else {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 12),
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxHeight: 400,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                snapshot.data.toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                              Text(
                                "Nome",
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'EB Garamond'),
                              ),
                              Text(
                                planta['nome'],
                                style: TextStyle(
                                    fontSize: 22, fontFamily: 'Inder'),
                              ),
                              Divider(),
                              Text("Nome Científico",
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'EB Garamond')),
                              Text(
                                planta['nomeCientifico'],
                                style: TextStyle(
                                    fontSize: 22, fontFamily: 'Inder'),
                              ),
                              Divider(),
                              Text("Sobre",
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'EB Garamond')),
                              Text(
                                planta['sobre'],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'Inder',
                                ),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text("Data de Cadastro",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'EB Garamond')),
                                      Text(
                                        "${cadastro.day.toString().padLeft(2, '0')}/${cadastro.month.toString().padLeft(2, '0')}/${cadastro.year}",
                                        style: TextStyle(
                                            fontSize: 18, fontFamily: 'Inder'),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Data de Atualização",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'EB Garamond')),
                                      Text(
                                        "${atualizacao.day.toString().padLeft(2, '0')}/${atualizacao.month.toString().padLeft(2, '0')}/${atualizacao.year}",
                                        style: TextStyle(
                                            fontSize: 18, fontFamily: 'Inder'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                            ],
                          );
                      }
                    }))));
  }
}
