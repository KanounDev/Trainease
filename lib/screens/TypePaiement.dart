import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypePaiement extends StatefulWidget {
  const TypePaiement({super.key});

  @override
  State<TypePaiement> createState() => _TypePaiState();
}

class _TypePaiState extends State<TypePaiement> {
  int _selectedValue = 0;
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
              SizedBox(
                height: 20 * fem,
              ),
              Text(
                'Paiement de réservation',
                style: GoogleFonts.vollkorn(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                '(Veuillez compléter le formulaire)',
                style: GoogleFonts.vollkorn(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Colors.grey[400]),
              ),
              SizedBox(
                height: fem * 20,
              ),
              Container(
                padding: EdgeInsets.all(fem * 10),
                height: fem * 550,
                width: fem * 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 2.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(fem * 10),
                      height: fem * 45,
                      width: fem * 330,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.grey, width: 2.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Validation de paiement',
                          style: GoogleFonts.vollkorn(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(fem * 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Nom et prénom : ',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.black),
                              ),
                              Text(
                                'Mohamed Kanoun',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Départ : ',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.black),
                              ),
                              Text(
                                'Sfax',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Destination : ',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.black),
                              ),
                              Text(
                                'Tunis',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Date de départ : ',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.black),
                              ),
                              Text(
                                '15 Juillet 2023',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Horaire : ',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.black),
                              ),
                              Text(
                                '11:00 AM',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Wagon : ',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.black),
                              ),
                              Text(
                                'numéro 1',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Place : ',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.black),
                              ),
                              Text(
                                '2',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Montant : ',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.black),
                              ),
                              Text(
                                '17 TND ',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Type de carte : ',
                                style: GoogleFonts.vollkorn(
                                    fontSize: 15,
                                    decoration: TextDecoration.none,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(fem * 10),
                      height: fem * 105,
                      width: fem * 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 2.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(children: [
                        Container(
                          child: Center(
                              child: Text(
                            'Carte avec la poste',
                            style: GoogleFonts.vollkorn(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                color: Colors.black),
                          )),
                          padding: EdgeInsets.all(fem * 5),
                          height: fem * 30,
                          width: fem * 280,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(color: Colors.grey, width: 2.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                // Update the selected value when the radio button is tapped.
                                setState(() {
                                  _selectedValue = value!;
                                });
                              },
                            ),
                            Text(
                              'Carte e-DINAR',
                              style: GoogleFonts.vollkorn(),
                            ),
                          ],
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 15 * fem,
                    ),
                    Container(
                      padding: EdgeInsets.all(fem * 10),
                      height: fem * 105,
                      width: fem * 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 2.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            child: Center(
                                child: Text(
                              'Carte bancaire',
                              style: GoogleFonts.vollkorn(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  color: Colors.black),
                            )),
                            padding: EdgeInsets.all(fem * 5),
                            height: fem * 30,
                            width: fem * 280,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border:
                                  Border.all(color: Colors.grey, width: 2.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                value: 2,
                                groupValue: _selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue = value!;
                                  });
                                },
                              ),
                              Text(
                                'Carte bancaire national',
                                style: GoogleFonts.vollkorn(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: fem * 15,
                    ),
                    Container(
                        height: fem * 30,
                        width: fem * 80,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Payer',
                              style: GoogleFonts.vollkorn(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  color: Colors.black),
                            )))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
