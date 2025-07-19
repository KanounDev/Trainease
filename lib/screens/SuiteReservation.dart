import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:trainease/screens/Accueil.dart';
import 'package:trainease/screens/Billet.dart';
import 'package:trainease/screens/BilletsAchetes.dart';
import 'package:trainease/screens/Reservation.dart';
import "package:http/http.dart" as http;
import 'appconfig.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String Place = 'W0';
String Prix = '0,000 dt';
String PrixGetted(String x) {
  Prix = x;
  return x;
}

late String DocumentId = '';

List<String> Passengers = [];

class SuiteReservation extends StatefulWidget {
  const SuiteReservation({super.key});

  @override
  State<SuiteReservation> createState() => _SuiteReservationState();
}

class _SuiteReservationState extends State<SuiteReservation> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  String? signedInUsername;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    //PassengersStreams();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
      }
    } catch (e) {}
  }

  bool Accueil1 = false;
  bool Reservation1 = true;
  bool Billets1 = false;
  bool Parametres1 = false;
  List<Color> containerColors = List.generate(120, (index) => Colors.green);
  List<Color> textColors = List.generate(120, (index) => Colors.black);

  bool isTapped = false;
  String extractStringAfterDash(String inputString) {
    if (inputString.contains('-')) {
      int dashIndex = inputString.indexOf('-');
      // Add 1 to the dashIndex to get the string after the dash
      String result = inputString.substring(dashIndex + 1);
      return result;
    } else {
      // Handle cases where there is no dash in the inputString
      return ''; // You can return an empty string ("") or handle it differently if needed
    }
  }

  String QrCode0 = '';
  bool ShowTicket = false;
  Future AddVoyage() async {
    var url = Uri.http(
        "${AppConfig.baseIP}", '/TrainEase/AddVoyage.php', {'q': '{http}'});
    await http.post(url, body: {
      'voyage': '${Depart}-${Arrive} en ${DateDepart} à ${HoraireChoisi}',
      'email': signedInUser.email,
      'place': Place,
      'prix': extractStringAfterDash(Place) == 'W1' ? '17,000 dt' : '12,000 dt',
      'qrcode': QrCode0,
    });
  }

  bool integerExistsInConvertedStrings(
      int targetInteger, List<String> inputList) {
    List<int> ConvertedInput = [];
    for (String input in inputList) {
      List<String> parts = input.split('-W');
      int numPlace = int.parse(parts[0]); // Contains '*'
      int wagon = int.parse(parts[1]);
      if (wagon == 1) {
        ConvertedInput.add(numPlace - 1);
      } else if (wagon == 2) {
        ConvertedInput.add(numPlace + 39);
      } else {
        ConvertedInput.add(numPlace + 79);
      }
    }
    if (ConvertedInput.contains(targetInteger)) {
      return true;
    }
    return false;
    // The target integer does not exist in the list
  }

  Future<void> addDocumentToCollectionIfNotExists(String collectionName,
      dynamic field1Value, dynamic field2Value, dynamic field3Value) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the collection where you want to insert the document
      CollectionReference collectionReference =
          firestore.collection(collectionName);

      // Check if a document with the same field values exists
      QuerySnapshot querySnapshot = await collectionReference
          .where('field1', isEqualTo: field1Value)
          .where('field2', isEqualTo: field2Value)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Document with the same field values doesn't exist, so add it
        Map<String, dynamic> documentData = {
          'Place': field1Value,
          'Prix': field2Value,
          'E-mail': field3Value,
        };
        DocumentReference documentReference =
            await collectionReference.add(documentData);

        DocumentId = documentReference.id;
        setState(() {
          QrCode0 = '${Depart}-${Arrive} en ${DateDepart} à ${HoraireChoisi}' +
              ' ${DocumentId} ' +
              ' ${Place}';
        });

        AddVoyage();
        print('oyo $QrCode0');
        ShowTicket = true;
        print(
            'Document added to collection "$collectionName" successfully with id "$DocumentId".');
      } else {
        // Document with the same field values already exists
        print(
            'Document with the specified field values already exists in "$collectionName".');
      }
    } catch (e) {
      print('Error adding or checking document in collection: $e');
    }
  }

  Future<void> createFirestoreCollection(String collectionName) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the collection
      CollectionReference collectionReference =
          firestore.collection(collectionName);

      // Check if the collection already exists
      final existingCollection = await collectionReference.get();

      if (existingCollection.docs.isEmpty) {
        // Collection doesn't exist, so create it
        await collectionReference.add({
          'exampleField': 'exampleValue',
        });
      } else {
        // Collection already exists
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Material(
        color: Color(0xFFECAB55),
        child: SafeArea(
          child: Stack(
            children: [
              Visibility(
                  visible: ShowTicket,
                  child: Container(
                    padding: EdgeInsets.all(8 * fem),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          height: 665 * fem,
                          width: 365 * fem,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                width: 340 * fem,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 45 * fem,
                                      width: 160 * fem,
                                      child: Text(
                                        'BILLET/تذكرة',
                                        style: TextStyle(
                                          fontSize: 25 * fem,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2.0 * fem,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 45 * fem,
                                      width: 160 * fem,
                                      child: Text(
                                        'SNCFT/UAGL',
                                        style: TextStyle(
                                          fontSize: 25 * fem,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2.0 * fem,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15 * fem,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 30 * fem,
                                width: 340 * fem,
                                child: Text(
                                  'BILLET PT',
                                  style: TextStyle(
                                    fontSize: 18 * fem,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0 * fem,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 15 * fem, 0, 0),
                                width: 340 * fem,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 30 * fem,
                                      width: 130 * fem,
                                      child: Text(
                                        'ALLER SIMPLE',
                                        style: TextStyle(
                                          fontSize: 17 * fem,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2.0 * fem,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 30 * fem,
                                      width: 130 * fem,
                                      child: Text(
                                        'ذهاب',
                                        style: TextStyle(
                                          fontSize: 17 * fem,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2.0 * fem,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 15 * fem, 0, 0),
                                width: 340 * fem,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 30 * fem,
                                      width: 130 * fem,
                                      child: Text(
                                        '${Depart.toUpperCase()}',
                                        style: TextStyle(
                                          fontSize: 17 * fem,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2.0 * fem,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 30 * fem,
                                      width: 130 * fem,
                                      child: Text(
                                        '${Arrive.toUpperCase()}',
                                        style: TextStyle(
                                          fontSize: 17 * fem,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2.0 * fem,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25 * fem,
                              ),
                              Container(
                                height: 85 * fem,
                                width: 340 * fem,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0 * fem,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        width: 330 * fem,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'N-Train/TT\nالقطار',
                                              style: TextStyle(
                                                fontSize: 16 * fem,
                                              ),
                                            ),
                                            Text(
                                              'Valable le\n صالحة',
                                              style: TextStyle(
                                                fontSize: 16 * fem,
                                              ),
                                            ),
                                            Text(
                                              'Place/Wagon\nالعربة/المقعد',
                                              style: TextStyle(
                                                fontSize: 16 * fem,
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(height: 8 * fem),
                                    Container(
                                        width: 330 * fem,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '5/22/27 DC',
                                              style: TextStyle(
                                                fontSize: 15 * fem,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${DateDepart} ${HoraireChoisi}',
                                              style: TextStyle(
                                                fontSize: 15 * fem,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${Place}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15 * fem,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15 * fem,
                              ),
                              Container(
                                height: 110 * fem,
                                width: 340 * fem,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0 * fem,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        width: 330 * fem,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Classe\nالدرجة',
                                              style: TextStyle(
                                                fontSize: 20 * fem,
                                              ),
                                            ),
                                            Text(
                                              'Prix\nالثمن',
                                              style: TextStyle(
                                                fontSize: 20 * fem,
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(height: 8 * fem),
                                    Container(
                                        width: 330 * fem,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${Place.substring(Place.length - 1)}',
                                              style: TextStyle(
                                                fontSize: 27 * fem,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${Prix.toUpperCase()}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 27 * fem,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 45 * fem,
                              ),
                              Container(
                                height: 180 * fem,
                                width: 180 * fem,
                                color: Colors.white,
                                child: QrImageView(
                                  data: QrCode0,
                                  version: QrVersions.auto,
                                  size: 300 * fem,
                                  gapless: false,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0 * fem,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              
              Visibility(
                visible: !ShowTicket,
                child: Container(
                  color: Colors.white,
                  child: Column(children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Column(
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
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0,
                                      MediaQuery.of(context).size.height / 128,
                                      MediaQuery.of(context).size.width / 2,
                                      0),
                                  child: Text(
                                    'Chisissez votre place',
                                    style: GoogleFonts.vollkorn(
                                      fontSize: 16 * fem,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                      color: Color.fromARGB(255, 84, 55, 17),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 19 * fem,
                            ),
                            Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(
                                      color: Color.fromARGB(255, 84, 55, 17),
                                      width: 2.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SingleChildScrollView(
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: _firestore
                                          .collection(
                                              '${Depart}-${Arrive} en ${DateDepart} à ${HoraireChoisi}')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        List<String> Passengers = [];
                                        if (!snapshot.hasData) {
                                        } else {
                                          final passengers =
                                              snapshot.data!.docs;
                                          for (var passenger in passengers) {
                                            Map<String, dynamic> passengerData =
                                                passenger.data()
                                                    as Map<String, dynamic>;
                                            if (passengerData
                                                .containsKey('Place')) {
                                              final passengerPlace =
                                                  passengerData['Place'];
                                              Passengers.add(passengerPlace);
                                            }
                                          }
                                        }
                                        return Column(
                                          children: List.generate(
                                            30, // Generate 10 rows, each with 2 containers
                                            (rowIndex) {
                                              return Column(
                                                children: [
                                                  Text(
                                                    rowIndex == 0
                                                        ? 'Wagon1 (+5dt)'
                                                        : rowIndex == 10
                                                            ? 'Wagon2'
                                                            : rowIndex == 20
                                                                ? 'Wagon3'
                                                                : '',
                                                    style: GoogleFonts.vollkorn(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Row(
                                                    children: List.generate(
                                                      4, // Two containers per row
                                                      (columnIndex) {
                                                        final index =
                                                            rowIndex * 4 +
                                                                columnIndex;
                                                        return GestureDetector(
                                                          onTap: () {
                                                            print(index);

                                                            print(
                                                                integerExistsInConvertedStrings(
                                                                    81, [
                                                              '1-W3',
                                                              '2-W3',
                                                              '3-W2'
                                                            ]));
                                                            // Toggle the color of the tapped container here
                                                            setState(() {
                                                              // bool allGrey =
                                                              //     containerColors
                                                              //         .every((color) =>
                                                              //             color ==
                                                              //             Colors
                                                              //                 .grey);

                                                              containerColors[
                                                                  index] = containerColors[
                                                                          index] ==
                                                                      Colors
                                                                          .green
                                                                  ? Colors
                                                                      .red
                                                                  : !integerExistsInConvertedStrings(
                                                                              index,
                                                                              Passengers) &&
                                                                          containerColors[index] ==
                                                                              Colors
                                                                                  .red
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .green;
                                                              textColors[
                                                                  index] = textColors[
                                                                          index] ==
                                                                      Colors
                                                                          .black
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black;
                                                              if (containerColors[
                                                                          index] ==
                                                                      Colors
                                                                          .red &&
                                                                  !integerExistsInConvertedStrings(
                                                                      index,
                                                                      Passengers)) {
                                                                Place = index >=
                                                                        40
                                                                    ? index >=
                                                                            80
                                                                        ? '${index - 80 + 1}' +
                                                                            '-${rowIndex >= 0 && rowIndex < 10 ? 'W1' : rowIndex >= 10 && rowIndex < 20 ? 'W2' : rowIndex >= 20 ? 'W3' : ''}'
                                                                        : '${index - 40 + 1}' +
                                                                            '-${rowIndex >= 0 && rowIndex < 10 ? 'W1' : rowIndex >= 10 && rowIndex < 20 ? 'W2' : rowIndex >= 20 ? 'W3' : ''}'
                                                                    : '${index + 1}' +
                                                                        '-${rowIndex >= 0 && rowIndex < 10 ? 'W1' : rowIndex >= 10 && rowIndex < 20 ? 'W2' : rowIndex >= 20 ? 'W3' : ''}';
                                                              } else {
                                                                Place = 'W0';
                                                              }
                                                              print(Place);
                                                            });
                                                          },
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    6 * fem,
                                                                    rowIndex == 10 ||
                                                                            rowIndex ==
                                                                                20 ||
                                                                            rowIndex ==
                                                                                0
                                                                        ? 29 *
                                                                            fem
                                                                        : 3 *
                                                                            fem,
                                                                    index ==
                                                                            rowIndex * 4 +
                                                                                1
                                                                        ? 19 *
                                                                            fem
                                                                        : 5 *
                                                                            fem,
                                                                    rowIndex ==
                                                                            0
                                                                        ? 2 *
                                                                            fem
                                                                        : rowIndex ==
                                                                                9
                                                                            ? 11 *
                                                                                fem
                                                                            : rowIndex == 19
                                                                                ? 11 * fem
                                                                                : 0),
                                                            child: Container(
                                                              width: 46.5 * fem,
                                                              height:
                                                                  46.5 * fem,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: integerExistsInConvertedStrings(
                                                                        index,
                                                                        Passengers)
                                                                    ? Colors
                                                                        .red
                                                                    : containerColors[
                                                                        index],
                                                                border:
                                                                    Border.all(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          61,
                                                                          84,
                                                                          55,
                                                                          17),
                                                                  width: 1.5,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  'Place ${index >= 40 ? index >= 80 ? index - 80 + 1 : index - 40 + 1 : index + 1}',
                                                                  style: GoogleFonts.vollkorn(
                                                                      color: integerExistsInConvertedStrings(
                                                                              index,
                                                                              Passengers)
                                                                          ? Colors
                                                                              .white
                                                                          : textColors[
                                                                              index],
                                                                      fontSize:
                                                                          13 *
                                                                              fem,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15 * fem,
                                ),
                                Container(
                                  height: 41 * fem,
                                  width: 301 * fem,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white10,
                                    border: Border.all(
                                      color: Color.fromARGB(61, 84, 55, 17),
                                      width: 1.5 * fem,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween, // Aligns the children to start and end of the row
                                    children: [
                                      Text(
                                        'Prix:',
                                        style: GoogleFonts.vollkorn(
                                          fontSize: 17 * fem,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        extractStringAfterDash(Place) == 'W1'
                                            ? PrixGetted('17,000 dt')
                                            : extractStringAfterDash(Place) ==
                                                        'W2' ||
                                                    extractStringAfterDash(
                                                            Place) ==
                                                        'W3'
                                                ? PrixGetted('12,000 dt')
                                                : PrixGetted('0,000 dt'),
                                        style: GoogleFonts.vollkorn(
                                          fontSize: 17 * fem,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15 * fem,
                                ),
                                Container(
                                    width: 201 * fem,
                                    height: 41 * fem,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        print('${Place}');
                                        if (Prix == '0,000 dt') {
                                          Navigator.pushReplacementNamed(
                                              context, '/SuiteReservation');
                                        } else {
                                          createFirestoreCollection(
                                              '${Depart}-${Arrive} en ${DateDepart} à ${HoraireChoisi}');
                                          addDocumentToCollectionIfNotExists(
                                              '${Depart}-${Arrive} en ${DateDepart} à ${HoraireChoisi}',
                                              Place,
                                              Prix,
                                              signedInUser.email);

                                          print(QrCode0);
                                         
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 239, 192, 132),
                                      ),
                                      child: Text('confirmer'),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 81 * fem,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.black,
                            width: 0.5 * fem,
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
                            _buildIconAndTitle(Icons.home, 'Accueil', Accueil1,
                                () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Accueil()));
                            }),
                            _buildIconAndTitle(
                                Icons.event_seat, 'Réservation', Reservation1,
                                () {
                              Navigator.pushReplacementNamed(
                                  context, '/HorairesTrain');
                            }),
                            _buildIconAndTitle(
                                Icons.confirmation_number, 'Billets', Billets1,
                                () {
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
              ),
            ],
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
