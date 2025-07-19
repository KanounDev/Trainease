import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainease/screens/Accueil.dart';
import 'package:trainease/screens/BilletsAchetes.dart';
import 'package:trainease/screens/SuiteReservation.dart';
import 'package:intl/intl.dart';

String HoraireChoisi = '---------------------------';
List<bool> boolList = List.filled(5, false);
List<bool> boolList1 = List.filled(5, false);
List<bool> boolList2 = List.filled(5, false);

bool De = false;
bool DeColor = false;
bool A = false;
bool AColor = false;
String selectedSource = '';
String selectedDestination = '';

String getStringFromBoolean(List<String> stringList, List<bool> booleanList) {
  if (stringList.length != booleanList.length) {
    throw ArgumentError("Both lists must have the same length");
  }

  for (int i = 0; i < booleanList.length; i++) {
    if (booleanList[i]) {
      return stringList[i];
    }
  }

  return '---------------------------';
}

bool TunDepart = false;
bool TunArrivee = false;
bool SfaxDepart = false;
bool SfaxArrivee = false;

String Depart = '---------------------------';
String Arrive = '---------------------------';
String DateDepart = '---------------------------';

bool InfoEmpty() {
  if (Depart == '---------------------------' ||
      Arrive == '---------------------------' ||
      DateDepart == '---------------------------' ||
      HoraireChoisi == '---------------------------') {
    return true;
  }
  return false;
}

String DepTunSfax(String x) {
  if (DepartTun(x)) {
    TunDepart = true;
  } else if (DepartSfax(x)) {
    SfaxDepart = true;
  } else {
    TunDepart = false;
    SfaxDepart = false;
  }
  Depart = x;
  return x;
}

String Date(String x) {
  DateDepart = x;
  return x;
}

String ArriveTunSfax(String x) {
  if (ArriveeTun(x)) {
    TunArrivee = true;
  } else if (ArriveeSfax(x)) {
    SfaxArrivee = true;
  } else {
    TunArrivee = false;
    SfaxArrivee = false;
  }
  Arrive = x;
  return x;
}

bool DepartTun(String x) {
  if (x == 'Tunis') {
    return true;
  }
  return false;
}

bool ArriveeTun(String x) {
  if (x == 'Tunis') {
    return true;
  }
  return false;
}

bool ArriveeSfax(String x) {
  if (x == 'Sfax') {
    return true;
  }
  return false;
}

bool DepartSfax(String x) {
  if (x == 'Sfax') {
    return true;
  }
  return false;
}

List<bool> InvupdateListExceptAtIndex(List<bool> boolList, int specificIndex) {
  for (int i = 0; i < boolList.length; i++) {
    if (i == specificIndex) {
      boolList[i] = true;
    } else {
      boolList[i] = false;
    }
  }
  return boolList;
}

List<bool> updateListExceptAtIndex2(List<bool> boolList, int specificIndex) {
  for (int i = 0; i < boolList.length; i++) {
    if (i == specificIndex) {
      boolList[i] = false;
    }
  }
  return boolList;
}

List<bool> updateListExceptAtIndex(List<bool> boolList, int specificIndex) {
  for (int i = 0; i < boolList.length; i++) {
    if (i == specificIndex) {
      boolList[i] = false;
    } else {
      boolList[i] = true;
    }
  }
  return boolList;
}

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  String? signedInUsername;
  DateTime? selectedDate;
  bool isVisble = false;
  bool EmptyInfo = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    EmptyInfo = InfoEmpty();
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

  bool Accueil1 = false;
  bool Reservation1 = true;
  bool Billets1 = false;
  bool Parametres1 = false;

  bool Horaire = false;
  bool HoraireColor = false;
  bool Tat = true;
  bool Gab = true;
  bool Sfa = true;
  bool Sou = true;
  bool Tun = true;

  List<String> sources = ['Sfax', 'Tunis', 'Tataouine', 'Gabes', 'Sousse'];
  List<String> destinations = ['Sfax', 'Tunis', 'Tataouine', 'Gabes', 'Sousse'];

  List<String> HorairesTunSfax = [
    '05:45',
    '08:35',
    '13:05',
    '20:16',
    '18:00',
    '21:45',
    '20:30'
  ];
  List<String> HorairesSfaxTun = [
    '02:15',
    '05:30',
    '06:55',
    '11:10',
    '13:25',
    '17:25'
  ];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    String formattedDate = selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(selectedDate!)
        : '---------------------------';
    return Material(
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0,
                            MediaQuery.of(context).size.height / 64,
                            MediaQuery.of(context).size.width / 6,
                            0),
                        child: Text(
                          'Réservez votre billet ici',
                          style: GoogleFonts.vollkorn(
                            fontSize: 28 * fem,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            color: Color.fromARGB(255, 84, 55, 17),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25 * fem,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 1.75,
                        width: MediaQuery.of(context).size.width / 1.25,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(
                              color: Color.fromARGB(255, 84, 55, 17),
                              width: 2.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 64,
                                        MediaQuery.of(context).size.height /
                                            128,
                                        0,
                                        MediaQuery.of(context).size.height /
                                            128),
                                    child: Text(
                                      'De :',
                                      style: GoogleFonts.vollkorn(
                                        fontSize: 17 * fem,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 32,
                                        0,
                                        0,
                                        0),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      width: MediaQuery.of(context).size.width /
                                          1.4,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(
                                            color: Colors.black87,
                                            width: 2.5 * fem),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  De = !De;
                                                  DeColor = !DeColor;
                                                });
                                              },
                                              child: RotatedBox(
                                                quarterTurns: 1,
                                                child: Icon(
                                                  Icons
                                                      .arrow_forward_ios, // Replace with your desired icon
                                                  size: 18.0 *
                                                      fem, // Adjust the icon size as needed
                                                  color: DeColor
                                                      ? Colors.brown
                                                      : Colors.black87,
                                                  // Icon color
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Text(
                                              DepTunSfax(getStringFromBoolean(
                                                  sources, boolList)),
                                              style: GoogleFonts.vollkorn(
                                                color: Colors.black,
                                                fontSize: 16.0 *
                                                    fem, // Adjust the text size as needed
                                              ),
                                            ),
                                          ),
                                          // Add other widgets as needed
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 64,
                                        MediaQuery.of(context).size.height / 64,
                                        0,
                                        MediaQuery.of(context).size.height /
                                            128),
                                    child: Text(
                                      'A :',
                                      style: GoogleFonts.vollkorn(
                                        fontSize: 17 * fem,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 32,
                                        0,
                                        0,
                                        0),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      width: MediaQuery.of(context).size.width /
                                          1.4,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(
                                            color: Colors.black87,
                                            width: 2.5 * fem),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  A = !A;
                                                  AColor = !AColor;
                                                });
                                              },
                                              child: RotatedBox(
                                                quarterTurns: 1,
                                                child: Icon(
                                                    Icons
                                                        .arrow_forward_ios, // Replace with your desired icon
                                                    size: 18.0 *
                                                        fem, // Adjust the icon size as needed
                                                    color: AColor
                                                        ? Colors.brown
                                                        : Colors
                                                            .black // Icon color
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Text(
                                              ArriveTunSfax(
                                                  getStringFromBoolean(
                                                      destinations, boolList2)),
                                              style: GoogleFonts.vollkorn(
                                                color: Colors.black,
                                                fontSize: 16.0 *
                                                    fem, // Adjust the text size as needed
                                              ),
                                            ),
                                          ),
                                          // Add other widgets as needed
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 64,
                                        MediaQuery.of(context).size.height / 64,
                                        0,
                                        MediaQuery.of(context).size.height /
                                            128),
                                    child: Text(
                                      'Départ :',
                                      style: GoogleFonts.vollkorn(
                                        fontSize: 17 * fem,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 32,
                                        0,
                                        0,
                                        0),
                                    child: Container(
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                _selectDate(context);
                                              },
                                              child: RotatedBox(
                                                quarterTurns: 1,
                                                child: Icon(
                                                    Icons
                                                        .arrow_forward_ios, // Replace with your desired icon
                                                    size: 18.0 *
                                                        fem, // Adjust the icon size as needed
                                                    color: Colors
                                                        .black // Icon color
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Text(
                                              Date(formattedDate),
                                              style: GoogleFonts.vollkorn(
                                                color: Colors.black,
                                                fontSize: 16.0 *
                                                    fem, // Adjust the text size as needed
                                              ),
                                            ),
                                          ),
                                          // Add other widgets as needed
                                        ],
                                      ),
                                      padding: EdgeInsets.all(5),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      width: MediaQuery.of(context).size.width /
                                          1.4,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(
                                            color: Colors.black87,
                                            width: 2.5 * fem),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 64,
                                        MediaQuery.of(context).size.height / 64,
                                        0,
                                        MediaQuery.of(context).size.height /
                                            128),
                                    child: Text(
                                      'Horaire :',
                                      style: GoogleFonts.vollkorn(
                                        fontSize: 17 * fem,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 32,
                                        0,
                                        0,
                                        0),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      width: MediaQuery.of(context).size.width /
                                          1.4,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(
                                            color: Colors.black87, width: 2.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  Horaire = !Horaire;
                                                  HoraireColor = !HoraireColor;
                                                });
                                              },
                                              child: RotatedBox(
                                                quarterTurns: 1,
                                                child: Icon(
                                                  Icons
                                                      .arrow_forward_ios, // Replace with your desired icon
                                                  size: 18.0 *
                                                      fem, // Adjust the icon size as needed
                                                  color: HoraireColor
                                                      ? Colors.brown
                                                      : Colors
                                                          .black, // Icon color
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Text(
                                              TunDepart && SfaxArrivee
                                                  ? HoraireChoisi
                                                  : SfaxDepart && TunArrivee
                                                      ? HoraireChoisi
                                                      : '---------------------------',
                                              style: GoogleFonts.vollkorn(
                                                color: Colors.black,
                                                fontSize: 16.0 *
                                                    fem, // Adjust the text size as needed
                                              ),
                                            ),
                                          ),
                                          // Add other widgets as needed
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 7.5,
                                        MediaQuery.of(context).size.height / 16,
                                        0,
                                        0),
                                    child: Container(
                                        width: 200 * fem,
                                        height: 40 * fem,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (InfoEmpty()) {

                                              Navigator.pushReplacementNamed(
                                                  context, '/HorairesTrain');
                                            } else {
                                              Navigator.pushReplacementNamed(
                                                  context, '/SuiteReservation');
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(
                                                255, 239, 192, 132),
                                          ),
                                          child: Text('continuer'),
                                        )),
                                  )
                                ]),
                            Positioned(
                              child: Visibility(
                                visible: De,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(12.5, 73, 0, 0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 9,
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black87,
                                          width: 1.5 * fem),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Expanded(
                                      child: SingleChildScrollView(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                          sources.length,
                                          (index) => VilleSource(
                                            ville: sources[index],
                                            de: boolList[index],
                                            i: index,
                                          ),
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              child: Visibility(
                                visible: A,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      12 * fem, 149 * fem, 0, 0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 9,
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black87,
                                          width: 1.5 * fem),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Expanded(
                                      child: SingleChildScrollView(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                          sources.length,
                                          (index) => VilleDest(
                                            ville: destinations[index],
                                            a: boolList1[index],
                                            i: index,
                                          ),
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              child: Visibility(
                                visible: Horaire,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      12 * fem, 307 * fem, 0, 0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 9,
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black87,
                                          width: 1.5 * fem),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Expanded(
                                      child: SingleChildScrollView(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            TunDepart && SfaxArrivee
                                                ? HorairesTunSfax.length
                                                : SfaxDepart && TunArrivee
                                                    ? HorairesSfaxTun.length
                                                    : 0,
                                            (index) => TunDepart && SfaxArrivee
                                                ? Horaire1(
                                                    HorairesTunSfax[index],
                                                    fem,
                                                  )
                                                : SfaxDepart && TunArrivee
                                                    ? Horaire1(
                                                        HorairesSfaxTun[index],
                                                        fem,
                                                      )
                                                    : Empty()),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Accueil()));
                      }),
                      _buildIconAndTitle(
                          Icons.event_seat, 'Réservation', Reservation1, () {
                        Navigator.pushReplacementNamed(
                            context, '/HorairesTrain');
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
        ));
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

class VilleSource extends StatefulWidget {
  final String ville;
  final bool de;
  final int i;
  VilleSource({
    required this.ville,
    required this.de,
    required this.i,
  });

  @override
  State<VilleSource> createState() => _VilleSourceState();
}

class _VilleSourceState extends State<VilleSource> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return GestureDetector(
      onTap: () {
        setState(() {
          InvupdateListExceptAtIndex(boolList, widget.i);
          updateListExceptAtIndex(boolList1, widget.i);
          updateListExceptAtIndex2(boolList2, widget.i);
        });
      },
      child: Visibility(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 5 * fem,
                ),
                Text(
                  widget.ville,
                  style: GoogleFonts.vollkorn(
                    color: Colors.black,
                    fontSize: 16.0, // Adjust the text size as needed
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class VilleDest extends StatefulWidget {
  final String ville;
  final bool a;
  final int i;
  VilleDest({
    required this.ville,
    required this.a,
    required this.i,
  });

  @override
  State<VilleDest> createState() => _VilleDestState();
}
 void inverse(bool x){
  x = !x ;
 }
class _VilleDestState extends State<VilleDest> {
  
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return GestureDetector(
      onTap: () {
        InvupdateListExceptAtIndex(boolList2, widget.i);
      },
      child: Visibility(
        visible: widget.a,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 5 * fem,
                ),
                Text(
                  widget.ville,
                  style: GoogleFonts.vollkorn(
                    color: Colors.black,
                    fontSize: 16.0, // Adjust the text size as needed
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

Widget Horaire1(String Horaire, double fem) {
  return GestureDetector(
    onTap: () {
      if (TunDepart && SfaxArrivee || SfaxDepart && TunArrivee) {
        HoraireChoisi = Horaire;
      } else {
        HoraireChoisi = '---------------------------';
      }
    },
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 5 * fem,
            ),
            Text(
              Horaire,
              style: GoogleFonts.vollkorn(
                color: Colors.black,
                fontSize: 16.0, // Adjust the text size as needed
              ),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          color: Colors.black,
        ),
      ],
    ),
  );
}

Widget Empty() {
  return GestureDetector(
    child: Column(
      children: [
        Row(children: []),
      ],
    ),
  );
}
