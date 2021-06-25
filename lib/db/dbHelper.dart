import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final String veriTabaniAdi = "kelimelerim.db";
  static  Future <Database> veritabaniErisim() async {
    String veritabaniYolu = join(await getDatabasesPath(), veriTabaniAdi);
    if(await databaseExists(veritabaniYolu)) {
      print("Veritabanı zaten mevcut.");
    }else {
      ByteData data = await rootBundle.load("database/$veriTabaniAdi");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await File(veritabaniYolu).writeAsBytes(bytes,flush: true);
      print("Veritabanı oluşturma işlemi başarılı.");
    }
    return openDatabase(veritabaniYolu);
  }
}