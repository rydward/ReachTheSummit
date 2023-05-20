import 'package:front/models/users.dart';

class Commentaire{
  String id;
  String texte;
  Users utilisateur;
  String created;
  String updated;

  Commentaire(
    this.id,
    this.texte,
    this.utilisateur,
    this.created,
    this.updated,
  );
}