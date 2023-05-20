import 'package:front/models/categorie_speedrun.dart';
import 'package:front/models/users.dart';

class Speedrun{
  String id;
  String video;
  String note;
  String plateforme;
  String version;
  Users createur;
  Users verified_by;
  bool is_verified;
  CategorieSpeedrun categorie;
  int igt;
  String created;
  String updated;

  Speedrun(
    this.id,
    this.video,
    this.note,
    this.plateforme,
    this.version,
    this.createur,
    this.verified_by,
    this.is_verified,
    this.categorie,
    this.igt,
    this.created,
    this.updated,
  );
}