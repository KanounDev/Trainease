import 'package:flutter/material.dart';

class BankPaiement extends StatefulWidget {
  const BankPaiement({super.key});

  @override
  State<BankPaiement> createState() => _BankPaiementState();
}

class _BankPaiementState extends State<BankPaiement> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Material(
      color: Colors.grey,
      child: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 50*fem,),
            Container(
              width: 370*fem,
              height: 530*fem,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 8 * fem,
                    ),
                    Container(
                      child: Text(
                        'FORMULAIRE DE PAIEMENT',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7 * fem,
                    ),
                    Container(
                      child: Text(
                        'Vous êtes en connexion sécurisée avec le serveur de paiement [*] ',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    SizedBox(height: 20 * fem),
                    Container(
                      padding: EdgeInsets.fromLTRB(8 * fem, 0, 0, 0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'DONNEES DE LA TRANSACTION :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10 * fem,
                    ),
                    BuildLine1('Site Marchand', 'SNCFT', 8 * fem),
                    SizedBox(
                      height: 3 * fem,
                    ),
                    BuildLine1('Montant transaction', '17.000 TND', 8 * fem),
                    SizedBox(
                      height: 3 * fem,
                    ),
                    BuildLine1('Référence transaction', 'XXXXXXXXXX', 8 * fem),
                    SizedBox(
                      height: 3 * fem,
                    ),
                    BuildLine1('Date transaction', '14/07/2023 14:00:12', 8 * fem),
                    SizedBox(
                      height: 25 * fem,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'DONNEES REALTIVES A VOTRE CARTE BANCAIRE :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 12 * fem,
                    ),
                    BuildLine2('Nom', 260, 8 * fem),
                    SizedBox(
                      height: 10 * fem,
                    ),
                    BuildLine2('Prénom', 260, 8 * fem),
                    SizedBox(
                      height: 5 * fem,
                    ),
                    BuildLine2('N de la carte bancaire', 150, 8 * fem),
                    BuildLine2('Cryptogramme(CVC2)', 50, 8 * fem),
                    SizedBox(
                      height: 5 * fem,
                    ),
                    BuildLine2('Email', 260, 8 * fem),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 25,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0.0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 243, 243, 243)),
                          side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(color: Colors.black, width: 1.0)),
                        ),
                        child: Text(
                          'PAIEMENT',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8 * fem,
                    ),
                    Container(
                      height: 71 * fem,
                      child: Image.asset('images/logos.png'),
                    )
                  ],
                )),
          ],
        ),
      )),
    );
  }

  Widget BuildLine1(String title1, String title2, double left) {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(left, 0, 0, 0),
        child: Row(
          children: [
            Container(
              width: 200,
              child: Text(
                title1,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              child: Text(
                ': ',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              width: 150,
              child: Text(
                title2,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ));
  }

  Widget BuildLine2(String title, double width, double left) {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(left, 0, 0, 0),
        child: Row(
          children: [
            Container(
              width: 100,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              child: Text(
                ': ',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              width: width,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.black,
                width: 1.0,
              )),
              child: TextField(
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.all(12.0), // Padding inside the text field
                  border: InputBorder.none, // Remove the default border
                ),
              ),
            )
          ],
        ));
  }
}
