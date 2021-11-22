import 'package:flutter/material.dart';
import 'package:google_news_flutter/models/google_data_model.dart';
import 'package:google_news_flutter/Screens/show_web_news.dart';


class FeedNews extends StatelessWidget {

  final GoogleDataModel data;

  const FeedNews({
    Key? key,
    required this.data
  }) : super(key: key);

  static const urlNoImage = 'https://danse.com.co/wp-content/uploads/2020/09/no-disponible.png';

  @override
  Widget build(BuildContext context) {
    DateTime dateNews = DateTime.parse(data.publishedAt);

    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ShowWebNews(url: data.url)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
           Text(data.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),),
           Text(data.name,),
           Text("${dateNews.day}/${dateNews.month}/${dateNews.year}"),
           SizedBox(
               width: double.maxFinite,
               height: 250 ,
               child: data.urlToImage.isNotEmpty ? Image.network(data.urlToImage, fit: BoxFit.cover,):
               Image.network(urlNoImage)
           ),
          Text(data.description,),
          const Divider(),
          const SizedBox(height: 15,)

        ],
      ),
    );
  }
}
