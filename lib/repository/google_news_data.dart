import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_news_flutter/models/google_data_model.dart';
import 'package:http/http.dart' as http;

class GoogleNewsRepository{

  Future<List<GoogleDataModel>>getGoogleNews({String country = "br"}) async {
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$country&apiKey=5b90aec09eed4dcb9af7af9cad4da51f');
    var response = await http.get(url,);
    List respData = json.decode(response.body)["articles"] ?? [];
    var googleNews = respData.map((e) => GoogleDataModel.fromMap(e)).toList();
    return googleNews;

  }

  Future<List<GoogleDataModel>>getGoogleNewsByWord(String word) async {
    var url = Uri.parse(
        'https://newsapi.org/v2/everything?q=$word&apiKey=5b90aec09eed4dcb9af7af9cad4da51f');
    var response = await http.get(url);
    List respData = json.decode(response.body)["articles"] ?? [];
    var googleNews = respData.map((e) => GoogleDataModel.fromMap(e)).toList();
    return googleNews;
  }


}