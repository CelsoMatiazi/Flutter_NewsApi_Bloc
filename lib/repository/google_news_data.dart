import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_news_flutter/models/google_data_model.dart';
import 'package:http/http.dart' as http;

class GoogleNews{


  Future<void>getGoogleNews() async {

    debugPrint("getGoogle");

    var url = Uri.parse('https://newsapi.org/v2/top-headlines?country=br&apiKey=5b90aec09eed4dcb9af7af9cad4da51f');
    var response = await http.get(
      url,
      headers: {
        "Content-type" : "application/json; charset=UTF-8"
      },
    );

    // debugPrint('Response status: ${response.statusCode}');
    // debugPrint('Response body: ${response.body}');

    var respData = json.decode(response.body)["articles"];

    List googleNewsData = [];

    for(int i = 0; i < respData.length; i++){

      var data = {}; // cria um Map vazio

      data['name'] = respData[i]["source"]["name"] ?? "";
      data['title'] = respData[i]["title"] ?? " ";
      data["description"] = respData[i]["description"] ?? "";
      data["url"] = respData[i]["url"] ?? "";
      data["urlToImage"] = respData[i]["urlToImage"] ?? "";
      data["publishedAt"] = respData[i]["publishedAt"] ?? "";
      data["content"] = respData[i]["content"] ?? "";

      googleNewsData.add(data);

    }

    debugPrint(googleNewsData[1]);

  }



  Future<List<GoogleDataModel>>getGoogleNews2() async {
    debugPrint("getGoogle2");

    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=br&apiKey=5b90aec09eed4dcb9af7af9cad4da51f');
    var response = await http.get(url,);
    
    debugPrint('Response status: ${response.statusCode}');
    // debugPrint('Response body: ${response.body}');

    List respData = json.decode(response.body)["articles"] ?? [];

    if(response.statusCode == 200){
      var googleNews = respData.map((e) => GoogleDataModel.fromMap(e)).toList();

      // debugPrint(googleNews[0].name);
      // debugPrint(googleNews[0].title);
      // debugPrint(googleNews[0].description);
      // debugPrint(googleNews[0].content);
      // debugPrint(googleNews[0].url);
      // debugPrint(googleNews[0].urlToImage);
      // debugPrint(googleNews[0].publishedAt);

      return googleNews;
    }else{
      return [];
    }


  }



}