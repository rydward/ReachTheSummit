import 'package:front/models/actualite.dart';
import 'package:front/models/guide.dart';
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
  

}