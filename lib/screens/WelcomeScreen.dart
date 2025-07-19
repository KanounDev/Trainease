import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainease/screens/ConnexionInscription.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

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
                      (MediaQuery.of(context).size.width - 300) / 2,
                      MediaQuery.of(context).size.height /5,
                      (MediaQuery.of(context).size.width - 300) / 2,
                      0),
                  child: Container(
                    width: 300,
                    height: 300,
                    child: Image.asset(
                      "images/img1.png",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 32,0, MediaQuery.of(context).size.height/32, 0),
                  child: Text('TRAINEASE',
                      style: GoogleFonts.vollkorn(
                        fontStyle: FontStyle.italic,
                        fontSize: 48,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFECAB55),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 32,
                      MediaQuery.of(context).size.height / 5,
                      0,
                      0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>  ConnexionInscription()));
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xFFECAB55),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text('Commencer',
                            style: GoogleFonts.vollkorn(
                              fontSize: 20,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFECAB55),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
