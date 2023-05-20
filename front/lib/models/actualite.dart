import 'package:front/models/users.dart';

class Actualite{
  String id;
  String titre;
  String texte;
  Users createur;
  String created;
  String updated;

  Actualite(
    this.id,
    this.titre,
    this.texte,
    this.createur,
    this.created,
    this.updated,
  );
}