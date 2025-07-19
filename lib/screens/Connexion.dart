import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainease/screens/Accueil.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  TextEditingController Email = TextEditingController();
  TextEditingController mdp = TextEditingController();

  bool isEmailEmpty = true;
  bool ismdpEmpty = true;
  String NomPrenom = '';
  void initState() {
    super.initState();
    Email.addListener(EmailListener);
    mdp.addListener(mdpListener);
  }

  void mdpListener() {
    setState(() {
      ismdpEmpty = mdp.text.isEmpty;
    });
  }

  void EmailListener() {
    setState(() {
      isEmailEmpty = Email.text.isEmpty;
    });
  }

  void clearTextField(TextEditingController controller) {
    controller.clear();
  }

  void clearTextFields() {
    Email.clear();
    mdp.clear();
  }

  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFECAB55),
      child: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text(
                      'Se Connecter',
                      style: GoogleFonts.vollkorn(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        color: Color.fromARGB(255, 84, 55, 17),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 130,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  controller: Email,
                  decoration: InputDecoration(
                    labelText: 'Adresse Email',
                    labelStyle:
                        GoogleFonts.vollkorn(color: Colors.grey, fontSize: 18),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        clearTextField(Email);
                      },
                      child: Icon(
                        isEmailEmpty ? Icons.mail : Icons.cancel,
                        color: Color.fromARGB(255, 84, 55, 17),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  controller: mdp,
                  obscureText: passToggle ? true : false,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    labelStyle:
                        GoogleFonts.vollkorn(color: Colors.grey, fontSize: 18),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          if (ismdpEmpty) {
                            passToggle = !passToggle;
                          } else {
                            clearTextField(mdp);
                          }
                        });
                      },
                      child: Icon(
                        passToggle && ismdpEmpty
                            ? CupertinoIcons.eye_slash_fill
                            : !passToggle && ismdpEmpty
                                ? CupertinoIcons.eye_fill
                                : Icons.cancel,
                        color: Color.fromARGB(255, 84, 55, 17),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 170,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Mot de passe oublié?',
                        style: GoogleFonts.vollkorn(
                          fontSize: 19,
                          decoration: TextDecoration.none,
                          color: Colors.grey,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFECAB55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () async {
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);

                      if (user != null) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Accueil()));
                      }
                    } catch (e) {
                      print(e);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Color.fromARGB(255, 240, 232, 232),
                            elevation: 5,
                            contentPadding: EdgeInsets.all(20),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Mot de passe éroné!",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Vérifier votre mot de passe ou adresse mail !!",
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                                Divider(color: Colors.black),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: Text(
                                      "OK",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    'Se connecter',
                    style: GoogleFonts.vollkorn(
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
