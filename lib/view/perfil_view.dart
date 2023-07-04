// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riber_cerra/controller/login_controller.dart';
import 'package:riber_cerra/model/drawer.dart';
import 'package:riber_cerra/view/tela_principal.dart';

class TelaPerfilView extends StatefulWidget {
  const TelaPerfilView({super.key});

  @override
  State<TelaPerfilView> createState() => _TelaPerfilViewState();
}

class _TelaPerfilViewState extends State<TelaPerfilView> {
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
      body: Center(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: LoginController().usuarioLogado(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Column(
                        children: [
                          Container(
                            child: Icon(
                              Icons.person,
                              size: 70,
                              color: Color.fromARGB(255, 112, 143, 112),
                            ),
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Color.fromARGB(255, 77, 86, 80)),
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 224, 255, 223),
                            ),
                            height: 150,
                            width: 150,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Não foi possível acessar o nome de usuário',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'Inder',
                                    letterSpacing: 3),
                              ),
                              IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Conexão indisponível')));
                                },
                                icon: Icon(
                                  Icons.edit_note,
                                  color: Colors.black26,
                                ),
                                tooltip: 'Alterar nome',
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Não foi possível acessar o email do usuário',
                                style: TextStyle(fontSize: 15),
                              ),
                              IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Conexão indisponível')));
                                },
                                icon: Icon(
                                  Icons.edit_note,
                                  color: Colors.black26,
                                ),
                                tooltip: 'Editar email',
                              )
                            ],
                          ),
                        ],
                      );
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      dynamic usuario = snapshot.requireData.docs[0].data();
                      return Column(
                        children: [
                          Container(
                            child: Icon(
                              Icons.person,
                              size: 70,
                              color: Color.fromARGB(255, 112, 143, 112),
                            ),
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Color.fromARGB(255, 77, 86, 80)),
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 224, 255, 223),
                            ),
                            height: 150,
                            width: 150,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                usuario['nome'].toString(),
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'Inder',
                                    letterSpacing: 3),
                              ),
                              IconButton(
                                onPressed: () {
                                  var txtusuario = TextEditingController();
                                  txtusuario.text = usuario['nome'].toString();
                                  showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return AlertDialog(
                                          title:
                                              Text("Alterar nome de usuario"),
                                          content: TextField(
                                            controller: txtusuario,
                                            decoration: InputDecoration(
                                              label: Text("usuario"),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text(
                                                "fechar",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 197, 150, 80)),
                                              ),
                                              onPressed: () {
                                                txtusuario.clear();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ElevatedButton(
                                              child: Text("salvar"),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 54, 179, 118)),
                                              onPressed: () {
                                                LoginController().atualizaNome(
                                                    context,
                                                    txtusuario.text.toString(),
                                                    snapshot.requireData.docs[0]
                                                        .id);
                                              },
                                            ),
                                          ],
                                        );
                                      }));
                                },
                                icon: Icon(
                                  Icons.edit_note,
                                  color: Colors.black26,
                                ),
                                tooltip: 'Alterar nome',
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                FirebaseAuth.instance.currentUser!.email
                                    .toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit_note,
                                  color: Colors.black26,
                                ),
                                tooltip: 'Editar email',
                              )
                            ],
                          ),
                        ],
                      );
                  }
                }),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 60,
                  icon: Icon(Icons.explore),
                  color: Color.fromARGB(255, 57, 129, 85),
                  tooltip: 'Mapa',
                  onPressed: () {
                    Navigator.pushNamed(context, 'mapa');
                  },
                ),
                IconButton(
                  iconSize: 60,
                  icon: Icon(Icons.library_books),
                  tooltip: 'Enciclopédia',
                  color: Color.fromARGB(255, 57, 129, 85),
                  onPressed: () {
                    Navigator.pushNamed(context, 'enciclopedia');
                  },
                ),
                IconButton(
                  iconSize: 60,
                  icon: Icon(Icons.settings),
                  tooltip: 'Configurações',
                  color: Color.fromARGB(255, 57, 129, 85),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 40),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => TelaPrincipal()),
                    (Route<dynamic> route) => false);
              },
              child: Text(
                'Sair',
                style: TextStyle(
                    color: Color.fromARGB(255, 197, 150, 80),
                    fontSize: 18,
                    fontFamily: 'EB Garamond',
                    letterSpacing: 3,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
      drawerEnableOpenDragGesture: true,
      drawer: CreateDrawer().drawer(context),
    );
  }
}
