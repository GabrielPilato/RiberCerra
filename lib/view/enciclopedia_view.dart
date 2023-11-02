// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riber_cerra/model/plantas.dart';
import 'package:riber_cerra/controller/plantas_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uuid/uuid.dart';

import '../model/drawer.dart';

class TelaEnciclopediaView extends StatefulWidget {
  const TelaEnciclopediaView({super.key});

  @override
  State<TelaEnciclopediaView> createState() => _TelaEnciclopediaViewState();
}

class _TelaEnciclopediaViewState extends State<TelaEnciclopediaView> {
  List<Planta> lista = [];
  var index = -1;
  var txtNome = TextEditingController();
  var txtNomeCientifico = TextEditingController();
  var txtSobre = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: PlantaController().listar().snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Text('Não foi possível conectar.'),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                final dados = snapshot.requireData;
                if (dados.size > 0) {
                  return ListView.builder(
                    itemCount: dados.size,
                    itemBuilder: (context, index) {
                      String id = dados.docs[index].id;
                      dynamic planta = dados.docs[index].data();
                      return Slidable(
                        startActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) =>
                                    PlantaController().excluir(context, id),
                                backgroundColor: Colors.red,
                                icon: Icons.macro_off,
                                label: 'Deletar',
                              ),
                              SlidableAction(
                                onPressed: (context) => salvarPlanta(context,
                                    docId: id,
                                    nome: planta['nome'].toString(),
                                    nomeCientifico:
                                        planta['nomeCientifico'].toString(),
                                    sobre: planta['sobre']),
                                backgroundColor:
                                    Color.fromARGB(255, 69, 173, 109),
                                icon: Icons.update,
                                label: 'Atualizar',
                              )
                            ]),
                        child: Card(
                          child: ListTile(
                            leading: Icon(Icons.description),
                            title: Text(
                              planta['nome'],
                              style: TextStyle(
                                fontFamily: 'Inder',
                                fontSize: 19,
                              ),
                            ),
                            subtitle: Text(planta['nomeCientifico'],
                                style: TextStyle(
                                  fontFamily: 'EB Garamond',
                                  fontSize: 19,
                                )),
                            onTap: () {
                              var plantaSelecionada = planta['pid'];
                              Navigator.pushNamed(context, 'plantas',
                                  arguments: plantaSelecionada);
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      'Nenhuma planta cadastrada.',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
            }
          },
        ),
      ),
      drawer: CreateDrawer().drawer(this.context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 54, 179, 118),
        onPressed: () {
          salvarPlanta(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void salvarPlanta(context, {docId, nome, nomeCientifico, sobre}) {
    if (docId != null) {
      txtNome.text = nome;
      txtNomeCientifico.text = nomeCientifico;
      txtSobre.text = sobre;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text("Adicionar Planta"),
          icon: Icon(Icons.local_florist),
          content: SizedBox(
            height: 550,
            width: 300,
            child: Column(
              children: [
                SizedBox(
                    height: 130,
                    width: 130,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ElevatedButton(
                        onPressed: () {
                          FutureBuilder(
                              future: PlantaController().getImagefromGallery(),
                              builder: ((context, snapshot) {
                                return snapshot.data == null
                                    ? AlertDialog(
                                        title: Text('Não foi selecionado'),
                                      )
                                    : Text('Selecionado');
                              }));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(5),
                            shadowColor: Colors.black,
                            elevation: 5,
                            backgroundColor:
                                Color.fromARGB(204, 121, 226, 175)),
                        child: Icon(
                          Icons.add_photo_alternate,
                          color: Color.fromARGB(179, 42, 116, 71),
                          size: 90,
                        ),
                      ),
                    )),
                TextField(
                  controller: txtNome,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: txtNomeCientifico,
                  decoration: InputDecoration(
                    labelText: 'Nome Científico',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: txtSobre,
                  maxLines: 7,
                  decoration: InputDecoration(
                    labelText: 'Sobre',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          actions: [
            TextButton(
              child: Text(
                "fechar",
                style: TextStyle(color: Color.fromARGB(255, 197, 150, 80)),
              ),
              onPressed: () {
                txtNome.clear();
                txtNomeCientifico.clear();
                txtSobre.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 54, 179, 118)),
              child: Text("salvar"),
              onPressed: () {
                if (txtNome.text.isEmpty ||
                    txtNomeCientifico.text.isEmpty ||
                    txtSobre.text.isEmpty) {
                } else {
                  var uuid = Uuid();
                  String pid = uuid.v1();
                  var p = Planta(txtNome.text, txtNomeCientifico.text, pid,
                      DateTime.now(), DateTime.now(), txtSobre.text);
                  if (docId == null) {
                    PlantaController().adicionar(context, p);
                  } else {
                    PlantaController().atualizar(context, docId, p);
                  }
                  txtNome.clear();
                  txtNomeCientifico.clear();
                  txtSobre.clear();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
