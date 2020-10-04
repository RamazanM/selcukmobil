import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
const pdf = 'https://www.selcuk.edu.tr/dosyalar/2018_2019_Akademik_Takvim.pdf';

class Takvim extends StatelessWidget{
  var filepath;
  Takvim(){
    ()async{
      filepath=await _downloadFile(pdf, "akademik_takvim.pdf");
    }();
  }

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(path:filepath );
  }

  Future<String> _downloadFile(String url, String filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    if(await file.exists()) return file.path;
    http.Client _client = new http.Client();
    var req = await _client.get(Uri.parse(url));
    var bytes = req.bodyBytes;
    await file.writeAsBytes(bytes);
    return file.path;
  }
}