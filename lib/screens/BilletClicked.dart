import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:trainease/screens/BilletsAchetes.dart';


class BilletClicked extends StatefulWidget {
  const BilletClicked({super.key});

  @override
  State<BilletClicked> createState() => _BilletState();
}

class _BilletState extends State<BilletClicked> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  String? signedInUsername ;
  @override
  void initState() {
    
    super.initState();
    getCurrentUser();
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
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Material(
        color: Colors.grey,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8 * fem),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 665 * fem,
                  width: 352 * fem,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        width: 340 * fem,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 45*fem,
                              width: 160*fem,
                              child: Text(
                                'BILLET/تذكرة',
                                style: TextStyle(
                                  fontSize: 25*fem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0*fem,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 45*fem,
                              width: 160*fem,
                              child: Text(
                                'SNCFT/UAGL',
                                style: TextStyle(
                                  fontSize: 25*fem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0*fem,
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
                            fontSize: 18*fem,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0*fem,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 15*fem, 0, 0),
                        width: 340 * fem,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 30*fem,
                              width: 130*fem,
                              child: Text(
                                'ALLER SIMPLE',
                                style: TextStyle(
                                  fontSize: 17*fem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0*fem,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 30*fem,
                              width: 130*fem,
                              child: Text(
                                'ذهاب',
                                style: TextStyle(
                                  fontSize: 17*fem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0*fem,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 15*fem, 0, 0),
                        width: 340 * fem,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 30*fem,
                              width: 130*fem,
                              child: Text(
                                '${Depart2.toUpperCase()}',
                                style: TextStyle(
                                  fontSize: 17*fem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0*fem,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 30*fem,
                              width: 130*fem,
                              child: Text(
                                '${Arrive2.toUpperCase()}',
                                style: TextStyle(
                                  fontSize: 17*fem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0*fem,
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
                            width: 2.0*fem,
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
                                        fontSize: 16*fem,
                                      ),
                                    ),
                                    Text(
                                      'Valable le\n صالحة',
                                      style: TextStyle(
                                        fontSize: 16*fem,
                                      ),
                                    ),
                                    Text(
                                      'Place/Wagon\nالعربة/المقعد',
                                      style: TextStyle(
                                        fontSize: 16*fem,
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
                                        fontSize: 15*fem,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${DateDepart2} ${HoraireDeDepart2}',
                                      style: TextStyle(
                                        fontSize: 15*fem,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${Place2}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15*fem,
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
                            width: 2.0*fem,
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
                                        fontSize: 20*fem,
                                      ),
                                    ),
                                    
                                    Text(
                                      'Prix\nالثمن',
                                      style: TextStyle(
                                        fontSize: 20*fem,
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
                                      '${Place2.substring(Place2.length - 1)}',
                                      style: TextStyle(
                                        fontSize: 27*fem,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    
                                    Text(
                                      '${Prix2.toUpperCase()}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 27*fem,
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
                          data: QrCode5,
                          version: QrVersions.auto,
                          size: 300*fem,
                          gapless: false,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0*fem,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
