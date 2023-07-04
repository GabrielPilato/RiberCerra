// ignore: avoid_web_libraries_in_flutter
// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controller/login_controller.dart';
import '../view/tela_pos_login.dart';
import '../view/tela_principal.dart';

class CreateDrawer {
  Widget drawer(context) {
    return Drawer(
      backgroundColor: Color.fromARGB(180, 121, 226, 175),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: LoginController().usuarioLogado(),
              builder: (context, snapshot) {
                if (LoginController().usuarioLogado() == null) {
                  return SizedBox.shrink();
                } else {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return UserAccountsDrawerHeader(
                          currentAccountPicture: CircleAvatar(),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('lib/images/fundo.png')),
                          ),
                          accountName: Text("conexão indisponível"),
                          accountEmail: Text("Conexão indisponível"));
                    case ConnectionState.waiting:
                      return UserAccountsDrawerHeader(
                          currentAccountPicture: CircleAvatar(),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('lib/images/fundo.png')),
                          ),
                          accountName: Text("Carregando..."),
                          accountEmail: Text("Carregando..."));
                    default:
                      dynamic usuario = snapshot.requireData.docs[0].data();
                      return UserAccountsDrawerHeader(
                          currentAccountPicture: CircleAvatar(),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('lib/images/fundo.png')),
                          ),
                          accountName: Text(usuario['nome'].toString()),
                          accountEmail: Text(FirebaseAuth
                              .instance.currentUser!.email
                              .toString()));
                  }
                }
              }),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              'Menu Principal',
              style: TextStyle(
                  fontSize: 25, color: Colors.white, fontFamily: 'Inder'),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context as BuildContext,
                  MaterialPageRoute(builder: (context) => TelaPosLogin()),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
            title: Text('Perfil',
                style: TextStyle(
                    fontSize: 25, color: Colors.white, fontFamily: 'Inder')),
            onTap: () {
              Navigator.pushNamed(context, 'perfil');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.local_florist,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              'Sobre',
              style: TextStyle(
                  fontSize: 25, color: Colors.white, fontFamily: 'Inder'),
            ),
            onTap: () {
              Navigator.pushNamed(context as BuildContext, 'sobre');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.explore,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              'Mapa',
              style: TextStyle(
                  fontSize: 25, color: Colors.white, fontFamily: 'Inder'),
            ),
            onTap: () {
              Navigator.pushNamed(context as BuildContext, 'mapa');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.library_books,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              'Enciclopedia',
              style: TextStyle(
                  fontSize: 25, color: Colors.white, fontFamily: 'Inder'),
            ),
            onTap: () {
              Navigator.pushNamed(context as BuildContext, 'enciclopedia');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              'Sair',
              style: TextStyle(
                  fontSize: 25, color: Colors.white, fontFamily: 'Inder'),
            ),
            onTap: () {
              LoginController().logout();
              Navigator.pushAndRemoveUntil(
                  context as BuildContext,
                  MaterialPageRoute(builder: (context) => TelaPrincipal()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
