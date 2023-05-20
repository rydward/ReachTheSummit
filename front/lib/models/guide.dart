import 'package:front/models/users.dart';

class Guide{
  String id;
  String titre;
  String texte;
  Users createur;
  String created;
  String updated;

  Guide(
    this.id,
    this.titre,
    this.texte,
    this.createur,
    this.created,
    this.updated,
  );
}