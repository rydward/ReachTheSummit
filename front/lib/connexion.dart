import 'package:flutter/material.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page de connexion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Pngwing1.png',
                height: screenSize.height * 0.3,
              ),
              SizedBox(height: screenSize.height * 0.05),
              ElevatedButton(
                onPressed: () {
                  // Add your logic for "Se connecter" button
                },
                child: Text('Se connecter'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF70C9DE),
                  onPrimary: Colors.white,
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              ElevatedButton(
                onPressed: () {
                  // Add your logic for "S'inscrire" button
                },
                child: Text("S'inscrire"),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF70C9DE),
                  onPrimary: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}