import 'package:flutter/material.dart';
import 'package:front/connexion.dart';
import 'package:front/inscription.dart';

void main() => runApp(HomeApp());

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page de connexion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenSize.height * 0.1),
            Image.asset(
              'assets/images/Pngwing1.png',
              height: screenSize.height * 0.4,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ConnexionPage()));
              },
              child: Text('Se connecter'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF70C9DE),
                onPrimary: Colors.white,
                minimumSize: Size(screenSize.width * 0.6, 50),
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InscriptionPage()));
              },
              child: Text("S'inscrire"),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF70C9DE),
                onPrimary: Colors.white,
                minimumSize: Size(screenSize.width * 0.6, 50),
              ),
            ),
            SizedBox(height: screenSize.height * 0.3),
          ],
        ),
      ),
    );
  }
}