import 'package:flutter/material.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget(
      {Key? key, required TextEditingController textCtrl, required this.height})
      : _textCtrl = textCtrl,
        super(key: key);

  final TextEditingController _textCtrl;
  final double height;

  @override
  Widget build(BuildContext context) {
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
            hintText: "Search",
            hintStyle: const TextStyle(fontSize: 16),
            contentPadding: const EdgeInsets.only(left: 15),
            fillColor: Colors.white,
            hoverColor: Colors.white,
            suffixIcon: height == 0.0
                ? null
                : IconButton(
                    icon: const Icon(Icons.search, color: Colors.black45),
                    onPressed: () {
                      if (_textCtrl.text.isNotEmpty) {
                        context.read<HomeScreenBloc>().add(
                            HomeScreenEventFindByWord(word: _textCtrl.text));
                        _textCtrl.clear();
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white54),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
