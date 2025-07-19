import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trainease/screens/Accueil.dart';
import 'package:trainease/screens/BankPaiement.dart';
import 'package:trainease/screens/Billet.dart';
import 'package:trainease/screens/BilletsAchetes.dart';
import 'package:trainease/screens/Connexion.dart';
import 'package:trainease/screens/ConnexionInscription.dart';
import 'package:trainease/screens/Inscription.dart';
import 'package:trainease/screens/PostePaiement.dart';
import 'package:trainease/screens/Reservation.dart';
import 'package:trainease/screens/SuiteReservation.dart';
import 'package:trainease/screens/TypePaiement.dart';

import 'package:trainease/screens/WelcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: user != null? '/Accueil' : '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/Billet': (context) => Billet(),
        '/BankPaiement': (context) => BankPaiement(),
        '/PostePaiement': (context) => PostePaiement(),
        '/TypePaiement': (context) => TypePaiement(),
        '/ConnexionInscription': (context) => ConnexionInscription(),
        '/Inscription': (context) => Inscription(),
        '/Connexion': (context) => Connexion(),
        '/Accueil': (context) => Accueil(),
        '/HorairesTrain': (context) => Reservation(),
        '/SuiteReservation': (context) => SuiteReservation(),
        '/BilletsAchetes': (context) => BilletsAchetes(),
      },
    );
  }
}
