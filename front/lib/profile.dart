import 'package:flutter/material.dart';
import 'package:front/home.dart';
import 'package:front/models/users.dart';
import 'package:front/db/db.dart';
import 'package:front/share/bottom_navigation_bar_widget.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Users? user;
  int nbSpeedruns = 0;
  int nbSujet = 0;
  int nbCommentaire = 0;
  int nbAide = 0;
  int nbReponse = 0;

  @override
  void initState() {
    super.initState();
    _getConnectedUser();
  }

  Future<void> _getConnectedUser() async {
    user = await Database().getConnectedUser();

    setState(() {
      user = user;
    });

    _getNbSpeedruns();
    _getNbSujet();
    _getNbCommentaire();
    _getNbAide();
  }

  void _disconnect() async {
    Database().disconnect();
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeApp()));
  }

  Future<void> _getNbSpeedruns() async {
    nbSpeedruns = await Database().getNbSpeedruns(user!.id);

    setState(() {
      nbSpeedruns = nbSpeedruns;
    });
  }

  Future<void> _getNbSujet() async {
    nbSujet = await Database().getNbSujets(user!.id);

    setState(() {
      nbSujet = nbSujet;
    });
  }

  Future<void> _getNbCommentaire() async {
    nbCommentaire = await Database().getNbCommentaires(user!.id);

    setState(() {
      nbCommentaire = nbCommentaire;
    });
  }

  Future<void> _getNbAide() async {
    nbAide = await Database().getNbAides(user!.id);

    setState(() {
      nbAide = nbAide;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Image6.png'),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.75),
              BlendMode.dstATop,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Profil de ${user?.username}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                user?.avatar.isEmpty ?? true
                    ? 'https://cdn-icons-png.flaticon.com/512/6386/6386976.png'
                    : 'http://127.0.0.1:8090/api/files/_pb_users_auth_/kqtl5vuixxmfxqo/${user?.avatar}',
              ),
            ),
            SizedBox(height: 20),
            Text(
              user?.username ?? '',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              user?.email ?? '',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Stats',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Nombre de Speedruns: $nbSpeedruns',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Nombre de Sujets: $nbSujet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Nombre de Commentaires: $nbCommentaire',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Nombre d\'Aides: $nbAide',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _disconnect();
              },
              child: Text('Se déconnecter'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(3),
    );
  }
}
