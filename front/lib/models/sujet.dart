import 'package:front/models/commentaire.dart';
import 'package:front/models/users.dart';

class Sujet{
  String id;
  String titre;
  String texte;
  Users utilisateur;
  Commentaire commentaire;
  String created;
  String updated;

  Sujet(
    this.id,
    this.titre,
    this.texte,
    this.utilisateur,
    this.commentaire,
    this.created,
    this.updated,
  );
}