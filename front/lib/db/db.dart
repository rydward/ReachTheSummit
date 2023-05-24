import 'package:front/models/actualite.dart';
import 'package:front/models/commentaire.dart';
import 'package:front/models/guide.dart';
import 'package:front/models/sujet.dart';
import 'package:front/models/users.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:collection/collection.dart';

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

}