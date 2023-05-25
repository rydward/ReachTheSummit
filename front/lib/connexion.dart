import 'package:flutter/material.dart';
import 'package:front/accueil.dart';
import 'package:front/db/db.dart';
import 'package:front/inscription.dart';

void main() => runApp(ConnexionApp());

class ConnexionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page de connexion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConnexionPage(),
    );
  }
}

class ConnexionPage extends StatefulWidget {
  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final _formKey = GlobalKey<FormState>();
  String _pseudo = '';
  String _password = '';
  String error = '';

  void _disconnect() async {
    Database().disconnect();
  }

  void _checkConnexion() async {
    var isConnected = Database().checkConnexion();
    print(isConnected);
  }

  void _connectUser() async {
    var result = await Database().connectUser(_pseudo, _password);
    if (result == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AccueilPage()));
    } else {
      setState(() {
        error = "Pseudo ou mot de passe incorrect";
      });
    }
  }

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Connexion',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Pseudo ou email',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un pseudo ou un email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _pseudo = value;
                        });
                      },
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un mot de passe';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InscriptionPage()));
                      },
                      child: Text(
                        'Je n\'ai pas de compte',
                        style: TextStyle(
                          color: Colors.black,
                      ),
                    ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _connectUser();
                        }
                      },
                      child: Text('Se connecter'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InscriptionPage()));
                      },
                      child: Text(
                        'J\'ai oublié mon mot de passe',
                        style: TextStyle(
                          color: Colors.black,
                      ),
                    ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _checkConnexion();
                      },
                      child: Text('Check connexion'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _disconnect();
                      },
                      child: Text('Disconnect'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}