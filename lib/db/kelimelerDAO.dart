import 'package:kelimeezber_sqflite/model/kelimeler.dart';

import 'dbHelper.dart';

class KelimelerDAO {
  Future<List<Kelimeler>> tumKelimeler() async {
    var db = await DBHelper.veritabaniErisim();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("Select * From kelimelerim");
    return List.generate(maps.length, (index) {
      var satir = maps[index];
      return Kelimeler(satir["id"], satir["trKelime"], satir["ingKelime"],
          satir["ornekCumle"]);
    });
  }

  Future<void> kelimeEkle(
      String trKelime, String ingKelime, String ornekCumle) async {
    var db = await DBHelper.veritabaniErisim();
    var bilgiler = Map<String, dynamic>();
    bilgiler["trKelime"] = trKelime;
    bilgiler["ingKelime"] = ingKelime;
    bilgiler["ornekCumle"] = ornekCumle;

    await db.insert("kelimelerim", bilgiler);
  }

  Future<void> kelimeSil(int id) async {
    var db = await DBHelper.veritabaniErisim();
    await db.delete("kelimelerim", where: "id = ?", whereArgs: [id]);
  }

  Future<void> kelimeGuncelle(
      int id, String trKelime, String ingKelime, String ornekCumle) async {
    var db = await DBHelper.veritabaniErisim();
    var bilgiler = Map<String, dynamic>();
    bilgiler["trKelime"] = trKelime;
    bilgiler["ingKelime"] = ingKelime;
    bilgiler["ornekCumle"] = ornekCumle;
    await db.update("kelimelerim", bilgiler, where: "id = ?", whereArgs: [id]);
  }

  Future<List<Kelimeler>> yanlisCevaplar(int id) async {
    var db = await DBHelper.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "Select * From kelimelerim Where id != $id order by random() limit 3");

    return List.generate(maps.length, (index) {
      var bilgiler = maps[index];
      return Kelimeler(bilgiler["id"],bilgiler["trKelime"],bilgiler["ingKelime"],bilgiler["ornekCumle"]);
    });
  }
}
