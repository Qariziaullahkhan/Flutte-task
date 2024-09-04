import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget {
  VoidCallback? onpressed;
  var text;
  var manisize;
  var colors;
  CustomeButton(
      {super.key, required this.onpressed, required this.text, this.manisize,required this.colors});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: manisize,
          backgroundColor: colors,
          // backgroundColor: Color(0xFF1E84A4),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
      onPressed: onpressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}