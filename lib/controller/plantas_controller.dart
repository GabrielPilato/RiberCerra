// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/plantas.dart';

class PlantaController {
  void adicionar(context, Planta p) {
    FirebaseFirestore.instance
        .collection('plantas')
        .add(p.toJson())
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Planta cadastrada com sucesso!"))))
        .catchError(
          (e) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Erro: ${e.code.toString()}"))),
        )
        .whenComplete(() => Navigator.of(context).pop());
  }

  void atualizar(context, id, Planta t) {
    FirebaseFirestore.instance
        .collection('plantas')
        .doc(id)
        .update(t.toJsonUpdate())
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Planta atualizada com sucesso!"))))
        .catchError((e) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erro: ${e.code.toString()}"))))
        .whenComplete(() => Navigator.of(context).pop());
  }

  void excluir(context, id) {
    FirebaseFirestore.instance
        .collection('plantas')
        .doc(id)
        .delete()
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Planta excluída com sucesso!"))))
        .catchError((e) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erro: ${e.code.toString()}"))));
  }

  listar() {
    return FirebaseFirestore.instance.collection('plantas');
  }

  listarPlanta(pid) { 
    return FirebaseFirestore.instance
        .collection('plantas')
        .where('pid', isEqualTo: pid)
        .get();
  }

  Future<String> getlink() async {
    final ref = FirebaseStorage.instance.ref().child('plantas/angelim.jpeg');
    String link = await ref.getDownloadURL();
    return link;
  }

  Future getImagefromGallery() async {
    var pickedfile = await ImagePicker().pickImage(source: ImageSource.gallery);

    return File(pickedfile!.path);
  }
}

  // CASO SEJA NECESSARIO ADQUIRIR UMA STRING DE UMA COLEÇÃO
  /*Future<String> A(uid) async {
    var a = await FirebaseFirestore.instance.collection("usuarios")
    .where("uid", isEqualTo: uid)
    .get();

    return a.docs[0].data()["nome"];
  }
    */

