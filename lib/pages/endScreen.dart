import 'package:flutter/material.dart';
import 'package:kelimeezber_sqflite/model/kelimeler.dart';

class EndScreen extends StatefulWidget {
  int dogruSayisi;
  int soruSayisi;
  EndScreen({this.dogruSayisi,this.soruSayisi});
  @override
  _EndScreenState createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sonuç"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${widget.dogruSayisi} Doğru ${widget.soruSayisi - widget.dogruSayisi} Yanlış"),
            Text("%${((widget.dogruSayisi*100)/widget.soruSayisi).toInt()} Başarı",style: TextStyle(color: Colors.red,fontSize: 30),),
            ElevatedButton(child: Text("Tekrar Deneyin"),onPressed: () {
              Navigator.pop(context);
            },),
          ],
        ),
      ),
    );
  }
}
