import 'package:flutter/material.dart';
import 'package:kelimeezber_sqflite/db/kelimelerDAO.dart';
import 'package:kelimeezber_sqflite/model/kelimeler.dart';
import 'package:kelimeezber_sqflite/pages/words.dart';

class WordsDetails extends StatefulWidget {
  Kelimeler kelimeler;
  WordsDetails({this.kelimeler});
  @override
  _WordsDetailsState createState() => _WordsDetailsState();
}

class _WordsDetailsState extends State<WordsDetails> {

  var trKelimeCont = TextEditingController();
  var ingKelimeCont = TextEditingController();
  var ornekCumleCont = TextEditingController();

  Future <void> sil(int id) async {
    await KelimelerDAO().kelimeSil(id);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Words()));
  }

  Future <void> guncelle(int id,String trKelime,String ingKelime,String ornekCumle) async {
    await KelimelerDAO().kelimeGuncelle(id, trKelime, ingKelime, ornekCumle);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Words()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var kelimeler = widget.kelimeler;
    trKelimeCont.text = kelimeler.trKelime;
    ingKelimeCont.text = kelimeler.ingKelime;
    ornekCumleCont.text = kelimeler.ornekCumle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kelimeler.trKelime),
        centerTitle: true,
        actions: [
          TextButton(child: Text("Sil",style: TextStyle(color: Colors.red),),onPressed: (){
            sil(widget.kelimeler.id);
          },),
          TextButton(child: Text("Güncelle",style: TextStyle(color: Colors.blue),),onPressed: (){
            guncelle(widget.kelimeler.id, trKelimeCont.text,ingKelimeCont.text,ornekCumleCont.text);
          },)
        ],
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
    );
  }
}
