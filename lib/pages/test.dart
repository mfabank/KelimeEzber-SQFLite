import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:kelimeezber_sqflite/db/kelimelerDAO.dart';
import 'package:kelimeezber_sqflite/model/kelimeler.dart';

import 'endScreen.dart';


class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var sorular = <Kelimeler>[];
  var yanlisCevaplar = <Kelimeler>[];
  Kelimeler dogruSoru;
  var tumSecenekler = HashSet<Kelimeler>(); //Seçenek yerlerini random değiştirir.


  int soruSayaci = 0;
  int dogruSayaci = 0;
  int yanlisSayaci = 0;



  String dogruCevap = "";
  String button1metin = "";
  String button2metin = "";
  String button3metin = "";
  String button4metin = "";

  @override
  void initState() {
    super.initState();
    sorulariAl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sorular"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Doğru Sayısı : ${dogruSayaci}"),
                Text("Yanlış Sayısı : ${yanlisSayaci}")
              ],
            ),
            soruSayaci != 0 ? Text("${soruSayaci + 1} .Soru") : Text("Son Soru"),
            Container(child: Center(child: Text("${dogruCevap}",style: TextStyle(color: Colors.white,fontSize: 50),),),),
            Container(
                width: 150,
                child: ElevatedButton(
                  child: Text(button1metin),
                  onPressed: () {
                    dogruKontrolu(button1metin);
                    soruSayacKontrolu();
                  },
                )),
            Container(
                width: 150,
                child: ElevatedButton(
                  child: Text(button2metin),
                  onPressed: () {
                    dogruKontrolu(button2metin);
                    soruSayacKontrolu();
                  },
                )),
            Container(
                width: 150,
                child: ElevatedButton(
                  child: Text(button3metin),
                  onPressed: () {
                    dogruKontrolu(button3metin);
                    soruSayacKontrolu();
                  },
                )),
            Container(
                width: 150,
                child: ElevatedButton(
                  child: Text(button4metin),
                  onPressed: () {
                    dogruKontrolu(button4metin);
                    soruSayacKontrolu();
                  },
                )),
          ],
        ),
      ),
    );
  }

  Future<void> sorulariAl() async {
    sorular = await KelimelerDAO().tumKelimeler();
    soruEkle();
  }

  Future<void> soruEkle() async {
    dogruSoru = sorular[soruSayaci];
    dogruCevap = dogruSoru.trKelime;
    yanlisCevaplar = await KelimelerDAO().yanlisCevaplar(dogruSoru.id);
    tumSecenekler.clear();
    tumSecenekler.add(dogruSoru);
    tumSecenekler.add(yanlisCevaplar[0]);
    tumSecenekler.add(yanlisCevaplar[1]);
    tumSecenekler.add(yanlisCevaplar[2]);
    button1metin = tumSecenekler.elementAt(0).ingKelime;
    button2metin = tumSecenekler.elementAt(1).ingKelime;
    button3metin = tumSecenekler.elementAt(2).ingKelime;
    button4metin = tumSecenekler.elementAt(3).ingKelime;

    setState(() {});
  }

  void soruSayacKontrolu() {
    soruSayaci++;
    if (soruSayaci != sorular.length) {
      soruEkle();
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => EndScreen(
                dogruSayisi: dogruSayaci,
                soruSayisi: dogruSayaci+yanlisSayaci,
              )));
    }
  }

  void dogruKontrolu(String buttonMetin) {
    if (dogruSoru.ingKelime == buttonMetin) {
      dogruSayaci++;
    } else {
      yanlisSayaci++;
    }
  }
}
