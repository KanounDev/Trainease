import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainease/main.dart';
import 'package:trainease/screens/Accueil.dart';
import 'package:trainease/screens/BilletClicked.dart';
import 'package:trainease/screens/Reservation.dart';
import 'package:trainease/screens/appconfig.dart';
import "package:http/http.dart" as http;

String Depart2 = '';
String Arrive2 = '';
String DateDepart2 = '';
String HoraireDeDepart2 = '';
String Place2 = '';
String Prix2 = '';

String QrCode5 = '';
String Billet1 = '';
bool search = false;

String extractDepart(String input) {
  List<String> parts = input.split('/');
  if (parts.length > 0) {
    return parts[0];
  } else {
    return ''; // Handle the case where there are not enough parts.
  }
}

String extractArrive(String input) {
  List<String> parts = input.split('/');
  if (parts.length > 1) {
    return parts[1];
  } else {
    return ''; // Handle the case where there are not enough parts.
  }
}

String extractDateDepart(String input) {
  List<String> parts = input.split('/');
  if (parts.length > 2) {
    return parts[2];
  } else {
    return ''; // Handle the case where there are not enough parts.
  }
}

String extractHoraireDepart(String input) {
  List<String> parts = input.split('/');
  if (parts.length > 3) {
    return parts[3];
  } else {
    return ''; // Handle the case where there are not enough parts.
  }
}

String extractPlace(String input) {
  List<String> parts = input.split('/');
  if (parts.length > 4) {
    return parts[4];
  } else {
    return ''; // Handle the case where there are not enough parts.
  }
}

class BilletsAchetes extends StatefulWidget {
  const BilletsAchetes({super.key});

  @override
  State<BilletsAchetes> createState() => _BilletsAchetesState();
}

class _BilletsAchetesState extends State<BilletsAchetes> {
  List<String> Voyages = [];
  List<String> Places = [];
  List<String> Prix = [];
  List<String> QrCodes = [];
  List<bool> trueList = [];
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  String? signedInUsername;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    GetVoyages();
    //searchCollectionsByEmailValue('mohamed@gmail.com', matchingCollections);
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  String getDepart(String input) {
    final parts = input.split('-');
    if (parts.length >= 2) {
      return parts[0];
    }
    return '';
  }

  String getDestination(String input) {
    final parts = input.split('-');
    if (parts.length >= 2) {
      final afterFirstDash = parts[1].split(' ');
      if (afterFirstDash.isNotEmpty) {
        return afterFirstDash[0];
      }
    }
    return '';
  }

  String getDateDepart(String input) {
    final datePattern = RegExp(r'\d{4}-\d{2}-\d{2}');
    final match = datePattern.firstMatch(input);
    if (match != null) {
      return match.group(0)!;
    }
    return '';
  }

  String getHour(String input) {
    if (input.length >= 5) {
      return input.substring(input.length - 5);
    }
    return '';
  }

  bool Accueil1 = false;
  bool Reservation1 = false;
  bool Billets1 = true;
  bool Parametres1 = false;

  Future<void> GetVoyages() async {
    var url = Uri.http("${AppConfig.baseIP}", '/TrainEase/RetrieveVoyages.php',
        {'q': '{http}'});

    var response1 = await http.post(url, body: {
      "email": signedInUser.email,
    });

    List<dynamic> decodedData = [];

    if (response1.statusCode == 200) {
      if (jsonDecode(response1.body).toString() != "NoUser") {
        decodedData = jsonDecode(response1.body);

        List<String> voyages = [];
        List<String> places = [];
        List<String> prix = [];
        List<String> qrcodes = [];
        for (var item in decodedData) {
          voyages.add(item["voyage"]);
          places.add(item["place"]);
          prix.add(item["prix"]);
          qrcodes.add(item["qrcode"]);
        }

        setState(() {
          Voyages = voyages;
          Places = places;
          Prix = prix;
          QrCodes = qrcodes;
          trueList = List<bool>.generate(voyages.length, (index) => true);
        });
      } else {
        print("NoUser");
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Material(
        color: Color(0xFFECAB55),
        child: SafeArea(
          child: Container(
                  color: Colors.white,
                  child: Column(children: [
                    SizedBox(
                      height: 20 * fem,
                    ),
                    Container(
                      height: 70 * fem,
                      width: 350 * fem,
                      decoration: BoxDecoration(
                        color: Colors.brown[400],
                        border: Border.all(
                          color: Colors.black38,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10 * fem)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10 * fem,
                          ),
                          Container(
                            width: 290,
                            child: TextField(
                              onChanged: (value) {
                                Billet1 = value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Rechercher un billet',
                                filled: true,
                                fillColor: Colors.brown[200],
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black, // Set the border color
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5 * fem,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                search = true;
                              });
                            },
                            icon: Icon(Icons.search),
                            iconSize: 40 * fem,
                          )
                          //icon: Icons.search, ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 350,
                      child: Text(
                        'En tappant : Depart(Sfax)/Arrive(Tunis)/DateDepart(2023-11-03)/HoraireDeDepart(02:15)/Place(10-W1)',
                        style:
                            GoogleFonts.vollkorn(color: Colors.black54, fontSize: 12),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              Voyages.length,
                              (index) => BilletAchete(
                                    depart: getDepart(Voyages[index]), // NomPrenom
                                    destination:
                                        getDestination(Voyages[index]), // Type
                                    dateDepart: getDateDepart(Voyages[index]), // Date
                                    horaireDepart: getHour(Voyages[index]),
                                    place: Places[index],
                                    qrCode5: QrCodes[index],
                                    prix: Prix[index],
                                    height: 15 * fem,
                                  )),
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
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Accueil()));
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
                              Navigator.pushReplacementNamed(
                                  context, '/BilletsAchetes');
                            }),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
            
          ),
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

class BilletAchete extends StatefulWidget {
  final String depart;
  final String destination;
  final String dateDepart;
  final String horaireDepart;
  final String place;
  final String qrCode5;
  final String prix;

  final double height;

  BilletAchete({
    required this.depart,
    required this.destination,
    required this.dateDepart,
    required this.horaireDepart,
    required this.place,
    required this.qrCode5,
    required this.prix,
    required this.height,
  });

  @override
  _BilletAcheteState createState() => _BilletAcheteState();
}

class _BilletAcheteState extends State<BilletAchete> {
  final _auth = FirebaseAuth.instance;
  late User signedInUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Billet1 == ''
          ? true
          : search &&
                  (extractArrive(Billet1) == widget.destination ||
                      extractDepart(Billet1) == widget.depart ||
                      extractDateDepart(Billet1) == widget.dateDepart ||
                      extractHoraireDepart(Billet1) == widget.horaireDepart ||
                      extractPlace(Billet1) == widget.place)
              ? true
              : search &&
                      !(extractArrive(Billet1) == widget.destination ||
                          extractDepart(Billet1) == widget.depart ||
                          extractDateDepart(Billet1) == widget.dateDepart ||
                          extractHoraireDepart(Billet1) ==
                              widget.horaireDepart ||
                          extractPlace(Billet1) == widget.place)
                  ? false
                  : true,
      child: Column(
        children: [
          SizedBox(
            height: widget.height,
          ),
          GestureDetector(
            onTap: () {
              Depart2 = widget.depart;
              Arrive2 = widget.destination;
              DateDepart2 = widget.dateDepart;
              HoraireDeDepart2 = widget.horaireDepart;
              Place2 = widget.place;
              QrCode5 = widget.qrCode5;
              Prix2 = widget.prix;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BilletClicked()));
            },
            child: Container(
              height: widget.height * 12,
              width: widget.height * 22.2,
              decoration: BoxDecoration(
                color: Colors.amber[200],
                border: Border.all(
                  color: Colors.black45,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.depart + ' ',
                              style: GoogleFonts.vollkorn(fontSize: 27),
                            ),
                            Text(
                              '- ',
                              style: GoogleFonts.vollkorn(fontSize: 27),
                            ),
                            Text(
                              widget.destination,
                              style: GoogleFonts.vollkorn(fontSize: 27),
                            ),
                          ],
                        ),
                        SizedBox(width: widget.height * 9),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.calendar_month,
                          size: 24,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.dateDepart,
                          style: GoogleFonts.vollkorn(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.access_time, size: 24),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.horaireDepart,
                          style: GoogleFonts.vollkorn(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.event_seat, size: 24),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.place,
                          style: GoogleFonts.vollkorn(fontSize: 18),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
