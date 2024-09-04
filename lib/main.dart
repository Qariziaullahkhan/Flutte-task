import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/screens/home_screen.dart';
import 'package:flutter_task/screens/login_screen.dart';
import 'package:flutter_task/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: const FirebaseOptions(apiKey: "AIzaSyBJPG7Cd24kjJwFKwArPbsm3R5KMnih_WA",
      appId: "1:264453317851:android:286cc7b7b90fdd8913d8fe",
      messagingSenderId: "264453317851",
      projectId: "flutte-task",
storageBucket: "flutte-task.appspot.com"
  ),
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme:  Theme.of(context).textTheme.apply(fontFamily: GoogleFonts.poppins().fontFamily,),
        // 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

