import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_event.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_state.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  final _textCtrl = TextEditingController();

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeScreenBloc, HomeScreenState, double>(
      selector: (state){
        return state.searchBarHeight ?? 0.0;
      },
      builder: (_, height) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
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
            controller: _textCtrl,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
                filled: true,
                hintText: "O que você procura?",
                contentPadding: const EdgeInsets.only(left: 15),
                fillColor: Colors.white,
                hoverColor: Colors.white,
                suffixIcon: height == 0.0
                    ? null
                    : IconButton(
                        icon: const Icon(
                            Icons.search,
                            color: Colors.black45),
                        onPressed: () {
                          if(_textCtrl.text.isNotEmpty){
                            context.read<HomeScreenBloc>().add(HomeScreenEventFindByWord(word: _textCtrl.text));
                            _textCtrl.clear();
                            FocusScope.of(context).unfocus();
                          }

                        },
                    ),
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