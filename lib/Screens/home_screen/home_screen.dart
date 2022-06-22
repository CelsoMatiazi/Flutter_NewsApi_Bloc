import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_event.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_state.dart';
import 'package:google_news_flutter/Screens/loader/loader.dart';
import 'package:google_news_flutter/models/google_data_model.dart';
import '../feed_news.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Google News"),
      ),
      body: BlocListener<HomeScreenBloc, HomeScreenState>(
        listenWhen: (previous, current){
          if(current is HomeScreenStateError) return true;
          return false;
        },
        listener: (context, state){
          if(state is HomeScreenStateError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("${state.message}"),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<HomeScreenBloc>().add(HomeScreenEventFindAll());
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Loader<HomeScreenBloc, HomeScreenState>(
                    selector: (state){
                      if(state is HomeScreenStateLoading) return true;
                      return false;
                    },
                  ),

                 BlocSelector<HomeScreenBloc, HomeScreenState, List<GoogleDataModel>>(
                   selector: (state){
                     return state.data ?? [];
                   },
                   builder: (_, dataNews){
                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         children: dataNews.map((e) => FeedNews(data: e)).toList(),
                       ),
                     );
                   },

                 )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
