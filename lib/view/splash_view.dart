import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:riber_cerra/controller/login_controller.dart';
import 'package:riber_cerra/view/tela_pos_login.dart';
import 'package:riber_cerra/view/tela_principal.dart';

class TelaSplashView extends StatelessWidget {
  const TelaSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      // FONTE DO GIF: Plant Grow GIF By Michael Shillingburg
      logo: Image.asset('lib/images/splashGif.gif'),
      logoWidth: 150,
      backgroundColor: const Color.fromARGB(255, 255, 203, 210),
      title: const Text(
        'carregando...',
        style: TextStyle(
            fontFamily: 'Inder',
            letterSpacing: 3,
            fontSize: 30,
            color: Color.fromARGB(132, 255, 255, 255)),
      ),
      durationInSeconds: 5,
      navigator: FutureBuilder<String>(
          future: LoginController().idUsuario(),
          builder: (context, snapshot) {
            return snapshot.data == null
                ? const TelaPrincipal()
                : const TelaPosLogin();
          }),
      loaderColor: Colors.white,
    );
  }
}
