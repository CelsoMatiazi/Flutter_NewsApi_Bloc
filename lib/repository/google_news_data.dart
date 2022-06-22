import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_news_flutter/models/google_data_model.dart';
import 'package:http/http.dart' as http;

class GoogleNewsRepository{

  Future<List<GoogleDataModel>>getGoogleNews() async {
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=br&apiKey=5b90aec09eed4dcb9af7af9cad4da51f');
    var response = await http.get(url,);
    
    debugPrint('Response status: ${response.statusCode}');
    List respData = json.decode(response.body)["articles"] ?? [];
    var googleNews = respData.map((e) => GoogleDataModel.fromMap(e)).toList();
    return googleNews;

  }


}