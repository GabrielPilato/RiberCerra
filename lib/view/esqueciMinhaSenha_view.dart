// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TelaEsqueciSenhaView extends StatefulWidget {
  const TelaEsqueciSenhaView({super.key});

  @override
  State<TelaEsqueciSenhaView> createState() => _TelaEsqueciSenhaViewState();
}

class _TelaEsqueciSenhaViewState extends State<TelaEsqueciSenhaView> {
  @override
  Widget build(BuildContext context) {
    final argument =
        (ModalRoute.of(context)?.settings.arguments ?? '') as String;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 255, 244),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'RiberCerra',
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: const Color.fromARGB(255, 121, 226, 175),
          actions: [
            IconButton(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Função indisponível no momento')));
              },
              icon: const Icon(
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
                Icons.mark_email_read,
                size: 125,
                color: Color.fromARGB(255, 112, 143, 112),
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.all(50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 224, 255, 223),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2, 4),
                      blurRadius: 5),
                ],
              ),
              height: 200,
              width: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Enviamos um link de confirmação para o e-mail cadastrado $argument\nCheque sua caixa de Entrada e Spam. Caso tenha mudado de ideia, apenas ignore a mensagem. ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Inder',
                  )),
            ),
          ],
        ));
  }
}
