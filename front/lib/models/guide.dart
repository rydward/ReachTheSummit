import 'package:front/models/users.dart';

class Guide{
  String id;
  String titre;
  String texte;
  Users utilisateur;
  String created;
  String updated;

  Guide(
    this.id,
    this.titre,
    this.texte,
    this.utilisateur,
    this.created,
    this.updated,
  );
}