import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kelimeezber_sqflite/db/kelimelerDAO.dart';
import 'package:kelimeezber_sqflite/model/kelimeler.dart';
import 'package:kelimeezber_sqflite/pages/wordsAdd.dart';
import 'package:kelimeezber_sqflite/pages/wordsDetails.dart';

class Words extends StatefulWidget {
  @override
  _WordsState createState() => _WordsState();
}

class _WordsState extends State<Words> {
  Future<List<Kelimeler>> tumKelimeleriGoster() async {
    var kelimelerListesi = await KelimelerDAO().tumKelimeler();

    return kelimelerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kelimeler"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Kelimeler>>(
        future: tumKelimeleriGoster(),
        builder: (contex, snapshot) {
          if (snapshot.hasData) {
            var kelimelerListesi = snapshot.data;
            return ListView.builder(
              itemCount: kelimelerListesi.length,
              itemBuilder: (context, index) {
                var kelime = kelimelerListesi[index];
                return Card(
                  child: ListTile(
                    title: Text("Türkçe :" +
                        kelime.trKelime +
                        " İngilizce : " +
                        kelime.ingKelime),
                    subtitle: Text(kelime.ornekCumle),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WordsDetails(
                                    kelimeler: kelime,
                                  )));
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box_sharp),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WordsAdd(),
            ),
          );
        },
      ),
    );
  }
}
