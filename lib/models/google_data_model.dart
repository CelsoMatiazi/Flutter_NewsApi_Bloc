import 'dart:convert';

class GoogleDataModel{

  String name;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;


  GoogleDataModel({
    required this.name,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  factory GoogleDataModel.fromMap(Map<String, dynamic> map) {
    return GoogleDataModel(
      name: map["source"]['name'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      url: map['url'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      publishedAt: map['publishedAt'] ?? '',
      content: map['content'] ?? '',
    );
  }


  factory GoogleDataModel.fromJson(String source) => GoogleDataModel.fromMap(jsonDecode(source));

  String toJson() => jsonEncode(toMap());

}