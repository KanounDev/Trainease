import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainease/screens/Connexion.dart';
import 'package:trainease/screens/Inscription.dart';

class ConnexionInscription extends StatefulWidget {
  const ConnexionInscription({super.key});

  @override
  State<ConnexionInscription> createState() => _ConnexionInscriptionState();
}

class _ConnexionInscriptionState extends State<ConnexionInscription> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFECAB55),
      child: SafeArea(
        child: Container(
            color: Colors.white,
            child: Column(
              children: [
               
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width /16,
                      MediaQuery.of(context).size.height/6,
                      (MediaQuery.of(context).size.width - 300) / 4,
                      0),
                  child: Container(
                    width: 400,
                    height: 300,
                    child: Image.asset(
                      "images/img1.png",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB((MediaQuery.of(context).size.width-250)/2, MediaQuery.of(context).size.height /8,(MediaQuery.of(context).size.width-250)/2 , 0),
                  child: Container(
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
                    onPressed: () {
                      Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>  Inscription()));
                    },
                    child: Text(
                      'Première inscription',
                      style: GoogleFonts.vollkorn(
                        fontSize: 19,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                              ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB((MediaQuery.of(context).size.width-250)/2, 15,(MediaQuery.of(context).size.width-250)/2 , 0),
                  child: Container(
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
                    onPressed: () {
                      Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>  Connexion()));
                    },
                    child: Text(
                      'Connexion',
                      style: GoogleFonts.vollkorn(
                        fontSize: 19,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                              ),
                ),
              ],
            )),
      ),
    );
  }
}
