import 'package:flutter/material.dart';
import 'package:flutter_task/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    spalshApi();
    super.initState();
  }
  spalshApi()async{

    await Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return const LoginScreen();
      }));
    });
    {

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        title:const  Text("Spalsh Screen",
        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body:const Center(
        child: FlutterLogo(
          size: 200,
        ),
      ),
    );
  }
}