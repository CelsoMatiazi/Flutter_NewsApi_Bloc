import 'package:flutter/material.dart';
import 'package:google_news_flutter/Screens/feed_news.dart';
import 'package:google_news_flutter/models/google_data_model.dart';
import 'package:google_news_flutter/repository/google_news_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _isLoading = false;
  List<GoogleDataModel> data = [];
  GoogleNews request = GoogleNews();

  void _getGoogleData() {
    setState(() {
      _isLoading = true;
    });

    request.getGoogleNews2().then((value){
      data = value;

      setState(() {
        _isLoading = false;
      });
    });
  }


  @override
  void initState() {
    _getGoogleData();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Google News"),
      ),
      body: Center(

        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              _isLoading ? const Center(
                child: CircularProgressIndicator(color: Colors.red,),
              ):
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: data.map((e) => FeedNews(data: e)).toList(),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
