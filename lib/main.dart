import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kelimeezber_sqflite/pages/test.dart';
import 'package:kelimeezber_sqflite/pages/words.dart';

void main () {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: Main(),
  ));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(child: Text("Kelimeler"),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Words(),),);},),
            ElevatedButton(child: Text("Test Yap"),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen(),),);}),
          ],
        ),
      ),
    );
  }
}

