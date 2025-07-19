import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trainease/screens/Accueil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  late String email = '';
  late String password = '';
  late String username = '';

  TextEditingController NomPrenom = TextEditingController();
  TextEditingController numPhone = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController mdp = TextEditingController();
  TextEditingController Etablissement = TextEditingController();

  bool isNomPrenomEmpty = true;
  bool isEtablissementEmpty = true;
  bool isnumPhoneEmpty = true;
  bool isEmailEmpty = true;
  bool ismdpEmpty = true;

  void initState() {
    super.initState();
    NomPrenom.addListener(NomPrenomListener);
    Etablissement.addListener(EtablissementListener);
    Email.addListener(EmailListener);
    numPhone.addListener(numPhoneListener);
    mdp.addListener(mdpListener);
  }

  void NomPrenomListener() {
    setState(() {
      isNomPrenomEmpty = NomPrenom.text.isEmpty;
    });
  }

  void EtablissementListener() {
    setState(() {
      isEtablissementEmpty = Etablissement.text.isEmpty;
    });
  }

  void EmailListener() {
    setState(() {
      isEmailEmpty = Email.text.isEmpty;
    });
  }

  void numPhoneListener() {
    setState(() {
      isnumPhoneEmpty = numPhone.text.isEmpty;
    });
  }

  void mdpListener() {
    setState(() {
      ismdpEmpty = mdp.text.isEmpty;
    });
  }

  @override
  void dispose() {
    NomPrenom.dispose();
    Email.dispose();
    mdp.dispose();
    numPhone.dispose();
    Etablissement.dispose();
    super.dispose();
  }

  void clearTextField(TextEditingController controller) {
    controller.clear();
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
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 32,
                          5,
                          MediaQuery.of(context).size.width / 4,
                          0),
                      child: Text(
                        'Inscription',
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: TextField(
                            onChanged: (value) {
                              username = value;
                            },
                            controller: NomPrenom,
                            decoration: InputDecoration(
                              labelText: 'Nom&Prénom',
                              labelStyle: GoogleFonts.vollkorn(
                                  color: Colors.grey, fontSize: 18),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  if (!isNomPrenomEmpty) {
                                    clearTextField(NomPrenom);
                                  }
                                  ;
                                },
                                child: Icon(
                                  isNomPrenomEmpty
                                      ? Icons.person
                                      : Icons.cancel,
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
                              email = value;
                            },
                            controller: Email,
                            decoration: InputDecoration(
                              labelText: 'Adresse Email',
                              labelStyle: GoogleFonts.vollkorn(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  if (!isEmailEmpty) {
                                    clearTextField(Email);
                                  }
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
                              labelStyle: GoogleFonts.vollkorn(
                                  color: Colors.grey, fontSize: 18),
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
                                child: passToggle && ismdpEmpty
                                    ? Icon(
                                        CupertinoIcons.eye_slash_fill,
                                        color: Color.fromARGB(255, 84, 55, 17),
                                      )
                                    : !passToggle && ismdpEmpty
                                        ? Icon(
                                            CupertinoIcons.eye_fill,
                                            color:
                                                Color.fromARGB(255, 84, 55, 17),
                                          )
                                        : Icon(
                                            Icons.cancel,
                                            color:
                                                Color.fromARGB(255, 84, 55, 17),
                                          ),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
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
                              if (username == '' ||
                                  email == '' ||
                                  password == '') {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor:
                                          Color.fromARGB(255, 240, 232, 232),
                                      elevation: 5,
                                      contentPadding: EdgeInsets.all(20),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Veuillez remplir tous les champs!",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Ne laisse aucun champ vide",
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
                              } else {
                                try {
                                  final newUser = await _auth
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password);
                                  _firestore.collection('users').add({
                                    'username': username,
                                    'email': email,
                                  });

                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(255, 240, 232, 232),
                                        elevation: 5,
                                        contentPadding: EdgeInsets.all(20),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Votre compte a été créé avec succés!",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFFECAB55),
                                                fontWeight: FontWeight.bold,
                                              ),
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
                                  clearTextField(NomPrenom);
                                  clearTextField(mdp);
                                  clearTextField(Email);
                                } catch (e) {
                                  print(e);

                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(255, 240, 232, 232),
                                        elevation: 5,
                                        contentPadding: EdgeInsets.all(20),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Utilisateur existant\nou adresse email et mot de passe non valides!",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "Veuillez utiliser d'autres adresse Email\net mot de passe",
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
                              }
                            },
                            child: Text(
                              'Envoyer',
                              style: GoogleFonts.vollkorn(
                                fontSize: 20,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
