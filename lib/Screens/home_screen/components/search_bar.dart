import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_state.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeScreenBloc, HomeScreenState, double>(
      selector: (state){
        return state.searchBarHeight ?? 0.0;
      },
      builder: (_, height) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          padding: const EdgeInsets.only(right: 15, left: 15, bottom: 0, top: 1),
          height: height,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: TextField(
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
                filled: true,
                hintText: "O que você procura?",
                contentPadding: const EdgeInsets.only(left: 15),
                fillColor: Colors.white,
                hoverColor: Colors.white,
                //suffixIcon: const Icon(Icons.search, color: Colors.black45,),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.white),
                )
            ),
          ),
        );
      },
    );
  }
}