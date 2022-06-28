
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_state.dart';
import 'package:google_news_flutter/Screens/home_screen/components/search_field_widget.dart';
import 'countries_flags_widget.dart';


class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with SingleTickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2)
  )..repeat();

  final _textCtrl = TextEditingController();

  List country = ["br","us","ca","fr","it","ua","pt","ar","mx","co","de","au","ie","jp"];

  @override
  void dispose() {
    _textCtrl.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeScreenBloc, HomeScreenState, double>(
      selector: (state){
        return state.searchBarHeight ?? 0.0;
      },
      builder: (_, height) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [

            CountriesFlagsWidget(country: country, controller: _controller, height: height,),

            SearchFieldWidget(textCtrl: _textCtrl, height: height,),

          ],
        );
      },
    );
  }
}

