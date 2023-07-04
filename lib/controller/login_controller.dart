import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {
  criarConta(context, nome, email, senha) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((resultado) {
      FirebaseFirestore.instance.collection('usuarios').add({
        'uid': resultado.user!.uid,
        'nome': nome,
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Usuário cadastrado com sucesso!")));
      Navigator.pop(context);
    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("O email digitado já se encontra cadastrado")));
          break;
        case 'invalid-email':
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Digite um email válido")));
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Erro: ${e.code.toString()}")));
      }
    });
  }

  login(context, email, senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((resultado) {
      Navigator.pushReplacementNamed(context, 'posLogin');
    }).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Email digitado é inválido")));
          break;
        case 'user-not-found':
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Usuário não encontrado")));
          break;
        case 'wrong-password':
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Senha digitada não coincide com o usuário')));
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Erro: ${e.code.toString()}")));
      }
    });
  }

  esqueceuSenha(context, String email) {
    if (email.isNotEmpty) {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.pushNamed(context, 'esqueciSenha', arguments: email);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Digite o email na qual deseja recuperar a senha')));
    }
  }

  logout() {
    FirebaseAuth.instance.signOut();
  }

  // Função IDusuario foi alterada para Future para utilização na splashscreen
  Future<String> idUsuario() async {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  usuarioLogado() {
    return FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots();
  }

  atualizaNome(context, String novoNome, id) {
    Map<String, dynamic> nome = {'nome': novoNome};
    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(id)
        .update(nome)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nome de usuário atualizado'))))
        .catchError((e) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erro: ${e.code.toString()}"))))
        .whenComplete(() => Navigator.of(context).pop());
  }

  verificaLogado() {
    return FirebaseAuth.instance.authStateChanges();
  }

  bool usuarioEstaLogado() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
