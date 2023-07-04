// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:riber_cerra/controller/login_controller.dart';

class RegistrarView extends StatefulWidget {
  const RegistrarView({super.key});

  @override
  State<RegistrarView> createState() => _RegistrarViewState();
}

var txtEmail = TextEditingController();
var txtUsuario = TextEditingController();
var txtSenha = TextEditingController();
var txtCredenciais = TextEditingController();
var txtCargo = TextEditingController();

class _RegistrarViewState extends State<RegistrarView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 255, 244),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Registro',
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
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
                height: 130,
                width: 130,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.add_a_photo,
                    color: Color.fromARGB(179, 42, 116, 71),
                    size: 90,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(5),
                      shadowColor: Colors.black,
                      elevation: 5,
                      backgroundColor: Color.fromARGB(204, 121, 226, 175)),
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(45, 0, 45, 10),
            child: TextField(
              controller: txtUsuario,
              decoration: InputDecoration(
                labelText: 'usuário',
                labelStyle: TextStyle(fontSize: 20, fontFamily: 'Inder'),
                suffixIcon: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(45, 0, 45, 10),
            child: TextField(
              controller: txtEmail,
              decoration: InputDecoration(
                labelText: 'e-mail',
                labelStyle: TextStyle(fontSize: 20, fontFamily: 'Inder'),
                suffixIcon: Icon(Icons.email),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(45, 0, 45, 10),
            child: TextField(
              obscureText: true,
              controller: txtSenha,
              decoration: InputDecoration(
                labelText: 'senha',
                labelStyle: TextStyle(fontSize: 20, fontFamily: 'Inder'),
                suffixIcon: Icon(Icons.lock),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(45, 0, 45, 10),
            child: TextField(
              controller: txtCredenciais,
              decoration: InputDecoration(
                labelText: 'credenciais de acesso',
                labelStyle: TextStyle(fontSize: 20, fontFamily: 'Inder'),
                suffixIcon: Icon(Icons.question_mark),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(45, 0, 45, 10),
            child: TextField(
              controller: txtCargo,
              decoration: InputDecoration(
                labelText: '(opcional) cargo ou afiliação',
                labelStyle: TextStyle(fontSize: 20, fontFamily: 'Inder'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  LoginController().criarConta(
                      context, txtUsuario.text, txtEmail.text, txtSenha.text);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 197, 150, 80),
                    minimumSize: Size(340, 45)),
                child: Text(
                  'Registrar',
                  style: TextStyle(
                      fontSize: 27, fontFamily: 'Inder', letterSpacing: 5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
