import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_event.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_state.dart';
import 'package:google_news_flutter/Screens/loader/loader.dart';
import 'package:google_news_flutter/models/google_data_model.dart';
import 'components/feed_news.dart';
import 'components/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("App News"),
        actions: [
          BlocSelector<HomeScreenBloc, HomeScreenState, double>(
            selector: (state){
              return state.searchBarHeight ?? 0.0;
            },
            builder: (_, height){
              return IconButton(
                onPressed: (){
                  context.read<HomeScreenBloc>().add(HomeScreenEventShowSearchBar(height: height));
                  FocusScope.of(context).unfocus();
                },
                icon: const Icon(Icons.search),
              );
            },
          )
        ],
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
          child: Column(
            children: [

              const SearchBar(),

              Expanded(
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
            ],
          ),
        ),
      ),
    );
  }
}


