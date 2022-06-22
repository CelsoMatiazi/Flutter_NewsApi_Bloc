import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_event.dart';
import 'package:google_news_flutter/repository/google_news_data.dart';
import 'Screens/home_screen/home_screen.dart';

void main() {
  runApp(RepositoryProvider(
      create: (context) => GoogleNewsRepository(),
      child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => HomeScreenBloc(repository: context.read())..add(HomeScreenEventFindAll()),
        child: const HomeScreen(),
      ),
    );
  }
}