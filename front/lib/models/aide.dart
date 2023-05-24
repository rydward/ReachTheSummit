import 'package:front/models/niveau.dart';
import 'package:front/models/reponse.dart';
import 'package:front/models/users.dart';

class Aide{
  String id;
  String type;
  String titre;
  Niveau niveau;
  Users utilisateur;
  List<Reponse> reponses;
  String created;
  String updated;

  Aide(
    this.id,
    this.type,
    this.titre,
    this.niveau,
    this.utilisateur,
    this.reponses,
    this.created,
    this.updated,
  );
}