import 'package:flutter/material.dart';
import 'package:kelimeezber_sqflite/db/kelimelerDAO.dart';
import 'package:kelimeezber_sqflite/model/kelimeler.dart';
import 'package:kelimeezber_sqflite/pages/words.dart';

class WordsAdd extends StatefulWidget {

  @override
  _WordsAddState createState() => _WordsAddState();
}

class _WordsAddState extends State<WordsAdd> {
  var trKelimeCont = TextEditingController();
  var ingKelimeCont = TextEditingController();
  var ornekCumleCont = TextEditingController();

  Future <void> kayit(String trKelime,String ingKelime, String ornekCumle) async {
    await KelimelerDAO().kelimeEkle(trKelime, ingKelime, ornekCumle);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Words()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kelime Ekle"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0,right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: trKelimeCont,
                decoration: InputDecoration(
                  hintText: "Türkçe Kelime"
                ),
              ),
              TextField(
                controller: ingKelimeCont,
                decoration: InputDecoration(
                    hintText: "İngilizce Kelime"
                ),
              ),
              TextField(
                controller: ornekCumleCont,
                decoration: InputDecoration(
                    hintText: "Örnek Cümle"
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.save),
        label: Text("Ekle",),
        onPressed: () {
          kayit(trKelimeCont.text, ingKelimeCont.text, ornekCumleCont.text);
        },
      ),
    );
  }
}
