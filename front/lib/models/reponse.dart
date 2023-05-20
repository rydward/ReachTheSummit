import 'package:front/models/users.dart';

class Reponse{
  String id;
  String texte;
  Users utilisateur;
  String created;
  String updated;

  Reponse(
    this.id,
    this.texte,
    this.utilisateur,
    this.created,
    this.updated,
  );
}