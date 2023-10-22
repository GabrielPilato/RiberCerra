import 'package:cloud_firestore/cloud_firestore.dart';

class Planta {
  final String nome;
  final String nomeCientifico;
  final String pid;
  final DateTime dataCadastro;
  final DateTime dataAtualizacao;
  final String sobre;

  Planta(this.nome, this.nomeCientifico, this.pid, this.dataCadastro,
      this.dataAtualizacao, this.sobre);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'nome': nome,
      'nomeCientifico': nomeCientifico,
      'pid': pid,
      'dataCadastro': dataCadastro,
      'dataAtualizacao': dataAtualizacao,
      'sobre': sobre
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return <String, dynamic>{
      'nome': nome,
      'nomeCientifico': nomeCientifico,
      'pid': pid,
      'dataAtualizacao': dataAtualizacao,
      'sobre': sobre
    };
  }

  factory Planta.fromJson(DocumentSnapshot<Object?> json) {
    return Planta(
      json['nome'],
      json['nomeCientifico'],
      json['pid'],
      json['dataCadastro'],
      json['dataAtualizacao'],
      json['sobre'],
    );
  }
}
