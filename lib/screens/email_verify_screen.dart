import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_task/screens/home_screen.dart';
import 'package:flutter_task/widgets/custom_appbar.dart';
import 'package:flutter_task/widgets/custom_button.dart';
import 'package:gap/gap.dart';

class EmailVerficationScreen extends StatefulWidget {
  const EmailVerficationScreen({super.key});

  @override
  State<EmailVerficationScreen> createState() => _EmailVerficationScreenState();
}

class _EmailVerficationScreenState extends State<EmailVerficationScreen> {
  bool Emailverified = false;
  Timer? timer;
  @override
  void initState() {
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    timer = Timer(const Duration(seconds: 5), () {
      timer?.cancel();
      VerificationCheck();
    });

    super.initState();
  }

  VerificationCheck() {
    FirebaseAuth.instance.currentUser!.reload();

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Appcolors.bluecolor2,
      appBar: AppBar(
              backgroundColor: Colors.red,

        title:const Text("Email Verification Screen",
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(100),
              Center(
                child: Text(
                    'Verify Email\nAn email has been sent to ${FirebaseAuth.instance.currentUser!.email}'),
              ),
              const Gap(20),
              const Center(child: Text('Please Verify It your Email')),
              const Gap(20),
              const SpinKitDualRing(color: Colors.black),
              const Gap(20),
              CustomeButton(
                colors: Colors.black,
                  manisize: Size(200, 53),
                  onpressed: () {
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  },
                  text: "Resend Email"),
            ],
          ),
        ),
      ),
    );
  }
}