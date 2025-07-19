import 'package:flutter/material.dart';

class PostePaiement extends StatefulWidget {
  const PostePaiement({super.key});

  @override
  State<PostePaiement> createState() => _PostePaiementState();
}

class _PostePaiementState extends State<PostePaiement> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Material(
      color: Colors.grey,
      child: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(children: [
          SizedBox(height: 5 * fem),
          Divider(
            height: 2,
            color: Colors.black,
          ),
          SizedBox(
            height: 3 * fem,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 40 * fem,
                  width: 130 * fem,
                  color: Colors.grey[200],
                  child: Center(
                    child: Text(
                        'Bienvenue au Serveur de Paiement de la Poste Tunisienne',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: Image.asset("images/poste.png"),
                ),
                Container(
                  height: 40 * fem,
                  width: 150 * fem,
                  color: Colors.grey[200],
                  child: Center(
                    child: Text(
                        'مرحبا بكم في منظومة الدفوعات الالكترونية للبريد التونسي',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3 * fem,
          ),
          Divider(
            height: 2,
            color: Colors.black,
          ),
          SizedBox(
            height: 5 * fem,
          ),
          Container(
            height: 30 * fem,
            width: 352 * fem,
            color: Colors.orange[400],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Résumé de la Transaction',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'التذكير بملخص عملية الدفع',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: fem * 10,
          ),
          Container(
            width: 352 * fem,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date de la Transaction',
                  style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '15/07/2023',
                  style: TextStyle(
                    color: Colors.purple[900],
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'التاريخ',
                  style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 3 * fem,
          ),
          Container(
            child: Column(children: [
              Container(
                width: 352 * fem,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Objet',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Paiement billet de train',
                      style: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'الخدمة',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 3 * fem,
              ),
              Container(
                width: 352 * fem,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nom du Client',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Mohamed Kanoun',
                      style: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'من طرف',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 3 * fem,
              ),
              Container(
                width: 352 * fem,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Montant à payer (en DT)',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '17.000',
                      style: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'المبلغ المطلوب',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 3 * fem,
              ),
              Container(
                width: 352 * fem,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Au profit de',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'SNCFT',
                      style: TextStyle(
                        color: Colors.purple[900],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'المنتفع',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 8 * fem,
          ),
          Divider(
            height: 2,
            color: Colors.black,
          ),
          SizedBox(height: 8 * fem),
          Container(
              height: 30 * fem,
              width: 352 * fem,
              color: Colors.purple[800],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pour payer saisir les données suivantes",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "للقيام بعملية الدفع الرجاء ادخال البيانات التالية",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              )),
          SizedBox(
            height: 15 * fem,
          ),
          Container(
            width: 352 * fem,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Numéro de la carte ',
                          style: TextStyle(
                            color: Colors.green[900],
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                      ],
                    ),
                    Text(
                      'رقم البطاقة',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3 * fem,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Code secret (8 chiffres) ',
                          style: TextStyle(
                            color: Colors.green[900],
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'الرقم السري',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            width: 352 * fem,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                      'Retour - Back - رجوع',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
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
                      'Payer - Pay - استخلاص',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10 * fem),
          Container(
            width: 352 * fem,
            child: Text(
              '* : Champ obligatoire',
              style: TextStyle(
                color: Colors.purple[800],
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            height: 13 * fem,
          ),
          Container(
            width: 352 * fem,
            child: Text(
              '=> La question « Amara » et sa réponse libre ne sont plus nécessaires pour valider votre paiement. Sont suffisantes, la saisie du numéro de la carte et celle du code confidentiel que vous pouvez changer à tout moment en ligne',
              style: TextStyle(color: Colors.red),
            ),
          ),
          SizedBox(height: 40 * fem),
          Container(
            width: 352 * fem,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40 * fem,
                    width: 130 * fem,
                    color: Colors.grey[200],
                    child: Center(
                      child: Text('Vous êtes dans une zone sécurisée',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11)),
                    ),
                  ),
                  Container(
                    height: 40 * fem,
                    width: 40 * fem,
                    child: Image.asset("images/cadna.png"),
                  ),
                  Container(
                    height: 40 * fem,
                    width: 130 * fem,
                    color: Colors.grey[200],
                    child: Center(
                      child: Text('هذه الصفحة مؤمنة',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11)),
                    ),
                  )
                ]),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 2,
            color: Colors.black,
          ),
          SizedBox(
            height: 15 * fem,
          ),
          Container(
              width: 352 * fem,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 20),
                  Row(
                    children: [
                      Text(
                        "E-mail : ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "monetique@poste.tn ",
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "- Tél : 1828",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ))
        ]),
      )),
    );
  }
}
