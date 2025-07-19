import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainease/screens/BilletsAchetes.dart';
import 'package:trainease/screens/Reservation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trainease/screens/WelcomeScreen.dart';


class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  String? signedInUsername;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

 

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          signedInUser = user;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  bool Accueil1 = true;
  bool Reservation1 = false;
  bool Billets1 = false;
  bool Parametres1 = false;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future(() => true);
      },
      child: Material(
          color: Color(0xFFECAB55),
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: Column(children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            height: 40 * fem,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 196, 183, 165),
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Color.fromARGB(255, 118, 70, 6),
                                    ),
                                    SizedBox(
                                      width: 5 * fem,
                                    ),
                                    StreamBuilder<QuerySnapshot>(
                                      stream: _firestore
                                          .collection('users')
                                          .where('email',
                                              isEqualTo: signedInUser?.email)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Text(
                                            'Loading...',
                                            style: GoogleFonts.vollkorn(
                                              fontSize: 22,
                                            ),
                                          );
                                        } else if (snapshot.hasData &&
                                            snapshot.data!.docs.isNotEmpty) {
                                          final userDoc =
                                              snapshot.data!.docs.first;
                                          final username =
                                              userDoc.get('username') as String;
                                          return Text(
                                            username,
                                            style: GoogleFonts.vollkorn(
                                              fontSize: 22,
                                            ),
                                          );
                                        } else {
                                          return Text(
                                            'N/A',
                                            style: GoogleFonts.vollkorn(
                                              fontSize: 22,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    _auth.signOut();
                                    Navigator.popUntil(
                                        context, ModalRoute.withName('/'));
                                  },
                                  icon: Icon(
                                    Icons.exit_to_app,
                                    size: 32,
                                    color: Color.fromARGB(255, 118, 70, 6),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,
                              MediaQuery.of(context).size.height * 0.15, 0, 0),
                          child: Container(
                            child: Image.asset(
                              "images/img3.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                    ),
                    color: Colors.grey.shade300,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height / 128, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildIconAndTitle(Icons.home, 'Accueil', Accueil1, () {
                          Navigator.pushReplacementNamed(context, '/Accueil');
                        }),
                        _buildIconAndTitle(
                            Icons.event_seat, 'Réservation', Reservation1, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Reservation()));
                        }),
                        _buildIconAndTitle(
                            Icons.confirmation_number, 'Billets', Billets1, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BilletsAchetes()));
                        }),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          )),
    );
  }
}

Widget _buildIconAndTitle(
    IconData icon, String title, bool Screen, VoidCallback onTap) {
  return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: Screen
                ? Color.fromARGB(255, 130, 86, 29)
                : Color.fromARGB(255, 215, 154, 75),
          ),
          SizedBox(height: 1),
          Text(
            title,
            style: GoogleFonts.vollkorn(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
              color: Screen
                  ? Color.fromARGB(255, 130, 86, 29)
                  : Color.fromARGB(255, 215, 154, 75),
            ),
          ),
        ],
      ));
}
