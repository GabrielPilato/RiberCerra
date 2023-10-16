// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:riber_cerra/view/tela_principal.dart';
import 'view/registrar_view.dart';
import 'view/tela_sobre.dart';
import 'view/tela_pos_login.dart';
import 'view/esqueciMinhaSenha_view.dart';
import 'view/perfil_view.dart';
import 'view/splash_view.dart';
import 'view/mapa_view.dart';
import 'view/enciclopedia_view.dart';
import 'view/Plantas_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(DevicePreview(
    builder: (context) => MaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        title: 'RiberCerra',
        initialRoute: 'splash',
        routes: {
          'principal': (context) => TelaPrincipal(),
          'registrar': (context) => RegistrarView(),
          'sobre': (context) => TelaSobreView(),
          'posLogin': (context) => TelaPosLogin(),
          'esqueciSenha': (context) => TelaEsqueciSenhaView(),
          'perfil': (context) => TelaPerfilView(),
          'splash': (context) => TelaSplashView(),
          'mapa': (context) => TelaMapaView(),
          'enciclopedia': (context) => TelaEnciclopediaView(),
          'plantas': (context) => TelaPlantasView()
        }),
  ));
}
