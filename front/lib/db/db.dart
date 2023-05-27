import 'package:front/addSpeedrun.dart';
import 'package:front/models/actualite.dart';
import 'package:front/models/aide.dart';
import 'package:front/models/commentaire.dart';
import 'package:front/models/guide.dart';
import 'package:front/models/niveau.dart';
import 'package:front/models/sujet.dart';
import 'package:front/models/users.dart';
import 'package:front/models/speedrun.dart';
import 'package:front/models/reponse.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:collection/collection.dart';
import 'package:front/models/categorie_speedrun.dart';

class Database{
  static final Database _instance = Database._internal();

  factory Database(){
    return _instance;
  }

  Database._internal();

  final pb = PocketBase('http://127.0.0.1:8090');

  Future<dynamic> createUser(String pseudo, String email, String password) async {
    final body = <String, dynamic>{
      "username": pseudo,
      "email": email,
      "emailVisibility": true,
      "password": password,
      "passwordConfirm": password,
      "role": "user"
    };

    try {
      final record = await pb.collection('users').create(body: body);
      return true;
    } catch (e) {
      String errorMessage = '';
      if (e is ClientException && e.response != null) {
        final responseData = e.response['data'];
        if (responseData != null) {
          if (responseData['email'] != null) {
            errorMessage += responseData['email']['message'];
          }
          if (responseData['username'] != null) {
            if (errorMessage.isNotEmpty) {
              errorMessage += '\n';
            }
            errorMessage += responseData['username']['message'];
          }
          if (responseData['password'] != null) {
            if (errorMessage.isNotEmpty) {
              errorMessage += '\n';
            }
            errorMessage += responseData['password']['message'];
          }
        }
      }
      return errorMessage.isNotEmpty ? errorMessage : e.toString();
    }
  }

  Future<Users> getConnectedUser() async {
    final record = await pb.collection('users').getOne(pb.authStore.model.id, expand: 'id');

    final user = Users(
      record.id,
      record.data['username'].toString(),
      record.data['email'].toString(),
      record.data['avatar'].toString(),
      record.data['role'].toString(),
      record.created,
      record.updated,
    );

    return user;
  }

  Future<dynamic> connectUser(String pseudo, String password) async {
    var authData;
    try {
      authData = await pb.collection('users').authWithPassword(
        pseudo,
        password,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  disconnect() {
    pb.authStore.clear(); 
  }

  bool checkConnexion() {
    return pb.authStore.isValid;
  }

  Future<List<Actualite>> getActualites() async {
    List<Actualite> actualites = [];

    final records = await pb.collection('actualite').getFullList(
      sort: '-created',
    );

    for (var record in records) {
        actualites.add(Actualite(
          record.id,
          record.data['titre'],
          record.data['texte'],
          await getUserById(record.data['createur'].toString()),
          record.created,
          record.updated,
        ));
    }

    return actualites;
  }

  Future<List<Guide>> getGuides() async {
    List<Guide> guides = [];

    final records = await pb.collection('guide').getFullList(
      sort: '-created',
    );

    for (var record in records) {
        guides.add(Guide(
          record.id,
          record.data['titre'],
          record.data['texte'],
          await getUserById(record.data['createur'].toString()),
          record.created,
          record.updated,
        ));
    }

    return guides;
  }

  Future<Guide> getGuideById(String id) async {
    final record = await pb.collection('guide').getOne(id, expand: 'id');
    
    final guide = Guide(
      record.id,
      record.data['titre'].toString(),
      record.data['texte'].toString(),
      await getUserById(record.data['createur'].toString()),
      record.created,
      record.updated,
    );

    return guide;
  }

  Future<Users> getUserById(String id) async {
    final record = await pb.collection('users').getOne(id, expand: 'id');
    
    final user = Users(
      record.id,
      record.data['username'].toString(),
      record.data['email'].toString(),
      record.data['avatar'].toString(),
      record.data['role'].toString(),
      record.created,
      record.updated,
    );

    return user;
  }

Future<List<Sujet>> getSubjects() async {
  List<Sujet> sujets = [];

  final records = await pb.collection('sujet').getFullList(
    sort: '-created',
  );

  for (var record in records) {
    try{
    sujets.add(Sujet(
      record.id,
      record.data['titre'],
      record.data['texte'],
      await getUserById(record.data['utilisateur'].toString()),
      await getCommentsByIdSujet(record.id),
      record.created,
      record.updated,
    ));
    }catch(e){
      print(e);
    }
  }

  return sujets;
}

  Future<Sujet> getSujetById(String id) async {
    final record = await pb.collection('sujet').getOne(id, expand: 'id');

    List<Commentaire> commentaires = await getCommentsByIdSujet(id);

    Sujet sujet = Sujet(
      record.id,
      record.data['titre'].toString(),
      record.data['texte'].toString(),
      await getUserById(record.data['utilisateur'].toString()),
      commentaires,
      record.created,
      record.updated,
    );

    return sujet;
  }

Future<List<Commentaire>> getCommentsByIdSujet(String id) async {
  final records = await pb.collection('commentaire').getFullList(
    filter: 'sujet = "$id"',
    sort: 'created',
  );

  List<Commentaire> commentaires = [];

  for (var record in records) {
    commentaires.add(Commentaire(
      record.id,
      record.data['texte'],
      await getUserById(record.data['utilisateur'].toString()),
      record.created,
      record.updated,
    ));
  }

  return commentaires;
}

Future<dynamic> addComment(String texte, String sujet) async {
  final body = <String, dynamic>{
    "texte": texte,
    "utilisateur": pb.authStore.model.id,
    "sujet": sujet,
  };

  try {
    final record = await pb.collection('commentaire').create(body: body);
    return true;
  } catch (e) {
    return "erreur lors de l'ajout du commentaire";
  }
}

Future<dynamic> addActualite(String titre, String texte) async{
  final body = <String, dynamic>{
    "titre": titre,
    "texte": texte,
    "createur": pb.authStore.model.id,
  };

  try {
    final record = await pb.collection('actualite').create(body: body);
    return true;
  } catch (e) {
    return "erreur lors de l'ajout de l'actualité";
  }
}

Future<dynamic> addSujet(String titre, String texte) async{
  final body = <String, dynamic>{
    "titre": titre,
    "texte": texte,
    "utilisateur": pb.authStore.model.id,
  };

  try {
    final record = await pb.collection('sujet').create(body: body);
    return true;
  } catch (e) {
    return "erreur lors de l'ajout du sujet";
  }
}

Future<List<Speedrun>> getVerifiedSpeedRuns() async {
  List<Speedrun> speedruns = [];

  final records = await pb.collection('speedrun').getFullList(
    sort: 'igt',
    filter: 'is_verified = true',
  );

  for (var record in records) {
    Users createur = await getUserById(record.data['createur'].toString());
    Users verifiedBy = await getUserById(record.data['verified_by'].toString());
    CategorieSpeedrun categorie = await getCategorieById(record.data['categorie'].toString());

      speedruns.add(Speedrun(
      record.id,
      record.data['video'],
      record.data['note'],
      record.data['plateforme'],
      record.data['version'],
      createur,
      verifiedBy,
      record.data['is_verified'],
      categorie,
      record.data['igt'],
      record.created,
      record.updated,
    ));
      
  }

  return speedruns;
}

Future<List<Speedrun>> getSpeedrunsToVerify() async{
  List<Speedrun> speedruns = [];

  final records = await pb.collection('speedrun').getFullList(
    sort: 'igt',
    filter: 'is_verified = false',
  );

  for (var record in records) {
    Users createur = await getUserById(record.data['createur'].toString());
    Users verifiedBy = await getUserById(record.data['verified_by'].toString());
    CategorieSpeedrun categorie = await getCategorieById(record.data['categorie'].toString());


      speedruns.add(Speedrun(
      record.id,
      record.data['video'],
      record.data['note'],
      record.data['plateforme'],
      record.data['version'],
      createur,
      verifiedBy,
      record.data['is_verified'],
      categorie,
      record.data['igt'],
      record.created,
      record.updated,
    ));
      
  }

  return speedruns;
}

Future<dynamic> verifySpeedrun(String id, bool isAccepted) async{
  if(isAccepted){
    final body = <String, dynamic>{
      "is_verified": true,
      "verified_by": pb.authStore.model.id,
    };

    try {
      final record = await pb.collection('speedrun').update(id, body: body);
      return true;
    } catch (e) {
      return "erreur lors de la vérification de la speedrun";
    }
  }else{
    try {
      final record = await pb.collection('speedrun').delete(id);
      return true;
    } catch (e) {
      return "erreur lors de la vérification de la speedrun";
    }
  }
}


Future<Speedrun> getSpeedRunById(String id) async {
    final record = await pb.collection('speedrun').getOne(id, expand: 'id');
    
    final speedrun = Speedrun(
      record.id,
      record.data['video'],
      record.data['note'],
      record.data['plateforme'],
      record.data['version'],
      await getUserById(record.data['createur'].toString()),
      await getUserById(record.data['verified_by'].toString()),
      record.data['is_verified'],
      await getCategorieById(record.data['categorie'].toString()),
      record.data['igt'],
      record.created,
      record.updated,
    );

    return speedrun;
  }

  Future<CategorieSpeedrun> getCategorieById(String id) async {
    final record = await pb.collection('categorie_speedrun').getOne(id, expand: 'id');
    
    final categorieSpeedrun = CategorieSpeedrun(
      record.id,
      record.data['libelle'].toString(),
      record.created,
      record.updated,
    );

    return categorieSpeedrun;
  }

  Future<dynamic> addSpeedrun(String link, String note, String plateforme, String version, String igt) async{
  final body = <String, dynamic>{
    "video": link,
    "note": note,
    "plateforme": plateforme,
    "version": version,
    "createur": pb.authStore.model.id,
    "verified_by": null,
    "is_verified": false,
    "categorie": null, 
    "igt": igt,
  };

  try {
    final record = await pb.collection('speedrun').create(body: body);
    return true;
  } catch (e) {
    return "erreur lors de l'ajout du sujet";
  }
}

Future<List<Aide>> getAides() async {
  List<Aide> aides = [];

  final records = await pb.collection('aide').getFullList(
    sort: '-created',
  );

  for (var record in records) {
    try{
    aides.add(Aide(
      record.id,
      record.data['type'],
      record.data['titre'],
      await getNiveauById(record.data['niveau'].toString()),
      await getUserById(record.data['utilisateur'].toString()),
      await getReponseByIdAide(record.id),
      record.created,
      record.updated,
    ));
    }catch(e){
      print(e);
    }
  }

  return aides;
}

  Future<dynamic> addAide(String type, String titre, String niveau) async{
  final body = <String, dynamic>{
    "type": type,
    "titre": titre,
    "niveau": niveau,
    "utilisateur": pb.authStore.model.id,
  };

  try {
    final record = await pb.collection('aide').create(body: body);
    return true;
  } catch (e) {
    return "erreur lors de l'ajout du sujet";
  }
}

Future<Niveau> getNiveauById(String id) async {
    final record = await pb.collection('niveau').getOne(id, expand: 'id');
    
    final niveau = Niveau(
      record.id,
      record.data['nom'].toString(),
      record.created,
      record.updated,
    );

    return niveau;
  }

  Future<List<Reponse>> getReponseByIdAide(String id) async {
  final records = await pb.collection('reponse').getFullList(
    filter: 'aide = "$id"',
    sort: 'created',
  );

  List<Reponse> reponses = [];

  for (var record in records) {
    reponses.add(Reponse(
      record.id,
      record.data['texte'],
      await getUserById(record.data['utilisateur'].toString()),
      record.created,
      record.updated,
    ));
  }

  return reponses;
}

Future<Aide> getAideById(String id) async {
    final record = await pb.collection('aide').getOne(id, expand: 'id');

    List<Reponse> reponses = await getReponseByIdAide(id);

    Aide sujet = Aide(
      record.id,
      record.data['type'],
      record.data['titre'],
      await getNiveauById(record.data['niveau'].toString()),
      await getUserById(record.data['utilisateur'].toString()),
      reponses,
      record.created,
      record.updated,
    );

    return sujet;
  }

  Future<dynamic> addReponse(String texte, String aide) async {
  final body = <String, dynamic>{
    "texte": texte,
    "utilisateur": pb.authStore.model.id,
    "aide": aide,
  };

  try {
    final record = await pb.collection('reponse').create(body: body);
    return true;
  } catch (e) {
    return "erreur lors de l'ajout du commentaire";
  }
}

  Future<List<Niveau>> getNiveaux() async {
    List<Niveau> niveaux = [];

    final records = await pb.collection('niveau').getFullList(
      sort: 'created',
    );

    for (var record in records) {
        niveaux.add(Niveau(
          record.id,
          record.data['nom'],
          record.created,
          record.updated,
        ));
    }

    return niveaux;
  }

  Future<dynamic> addLivesplit(int temps_total, int prologue, int forsaken_city, int old_site, int celestial_resort, int golden_ridge, int mirror_temple, int reflection, int summit) async{
  final body = <String, dynamic>{
    "temps_total": temps_total,
    "prologue": prologue,
    "forsaken_city": forsaken_city,
    "old_site": old_site,
    "celestial_resort": celestial_resort,
    "golden_ridge": golden_ridge,
    "mirror_temple": mirror_temple,
    "reflection": reflection,
    "the_summit": summit,
    "user": pb.authStore.model.id,
  };

  try {
    final record = await pb.collection('livesplit').create(body: body);
    return true;
  } catch (e) {
    return "erreur lors de l'ajout du sujet";
  }
  }

}