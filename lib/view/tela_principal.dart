// ignore_for_file: unused_import, prefer_const_constructors, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:riber_cerra/controller/plantas_controller.dart';
import 'package:riber_cerra/model/login.dart';
import 'package:riber_cerra/controller/login_controller.dart';
import 'package:riber_cerra/view/esqueciMinhaSenha_view.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  bool _flag = false;
  bool _flag2 = false;
  //Atributos
  List<Login> lista = [];
  var index;
  var txtUsuario = TextEditingController();
  var txtSenha = TextEditingController();

  @override
  void initState() {
    index = -1;
    lista.add(Login('admin', 'nimda'));
    super.initState();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: ElevatedButton.icon(
                  onPressed: () => setState(() {
                    if (_flag2) {
                      _flag2 = false;
                      _flag = true;
                    } else if (_flag) {
                      _flag = false;
                    } else {
                      _flag = true;
                    }
                  }),
                  icon: Icon(
                    Icons.person,
                    color: Color.fromARGB(178, 0, 0, 0),
                    size: 130,
                  ),
                  label: Text(""),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      padding: EdgeInsets.zero,
                      backgroundColor: _flag
                          ? Color.fromARGB(255, 179, 203, 187)
                          : Color.fromARGB(255, 213, 234, 215),
                      side: BorderSide(
                        color: _flag
                            ? Color.fromARGB(255, 77, 86, 80)
                            : Color.fromARGB(255, 191, 205, 190),
                        width: 3,
                      ),
                      minimumSize: Size(140, 140)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 25, 0, 0),
                child: ElevatedButton.icon(
                  onPressed: () => setState(() {
                    if (_flag) {
                      _flag = false;
                      _flag2 = true;
                    } else if (_flag2) {
                      _flag2 = false;
                    } else {
                      _flag2 = true;
                    }
                  }),
                  icon: Icon(
                    Icons.book,
                    color: Color.fromARGB(178, 0, 0, 0),
                    size: 130,
                  ),
                  label: Text(""),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      padding: EdgeInsets.zero,
                      backgroundColor: _flag2
                          ? Color.fromARGB(255, 179, 203, 187)
                          : Color.fromARGB(255, 213, 234, 215),
                      side: BorderSide(
                          color: _flag2
                              ? Color.fromARGB(255, 77, 86, 80)
                              : Color.fromARGB(255, 191, 205, 190),
                          width: 3),
                      minimumSize: Size(140, 140)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('usuário',
                    style: TextStyle(fontSize: 18, fontFamily: 'Inder')),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('pesquisador',
                    style: TextStyle(fontSize: 18, fontFamily: 'Inder')),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(25, 25, 25, 10),
              child: Text(
                'login',
                style: TextStyle(fontSize: 24, fontFamily: 'EB Garamond'),
              )),
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
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(204, 200, 237, 156),
                ),
                onPressed: () {
                  LoginController().esqueceuSenha(context, txtUsuario.text);
                },
                child: Text(
                  'esqueci minha senha',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'EB Garamond',
                      letterSpacing: 3,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 21, 0, 0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  LoginController()
                      .login(context, txtUsuario.text, txtSenha.text);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 197, 150, 80),
                    minimumSize: Size(340, 45)),
                child: Text(
                  'Logar',
                  style: TextStyle(
                      fontSize: 27, fontFamily: 'Inder', letterSpacing: 5),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'registrar');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 57, 129, 85),
                    minimumSize: Size(340, 45)),
                child: Text(
                  'Registrar',
                  style: TextStyle(
                      fontSize: 27, fontFamily: 'Inder', letterSpacing: 5),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'sobre');
                },
                child: Text(
                  'Ajuda',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'EB Garamond',
                      letterSpacing: 3,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
