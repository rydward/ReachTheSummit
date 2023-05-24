import 'package:front/models/commentaire.dart';
import 'package:front/models/users.dart';

class Sujet{
  String id;
  String titre;
  String texte;
  Users utilisateur;
  List<Commentaire> commentaires;
  String created;
  String updated;

  Sujet(
    this.id,
    this.titre,
    this.texte,
    this.utilisateur,
    this.commentaires,
    this.created,
    this.updated,
  );
}