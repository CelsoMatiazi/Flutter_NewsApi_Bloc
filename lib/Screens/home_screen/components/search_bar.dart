import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_event.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_state.dart';
import 'package:lottie/lottie.dart';

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
            AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              height: height == 0.0 ? 80 : 0,
              width: double.maxFinite,
              color: Colors.black,
              child: ListView.builder(
                  itemCount: country.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index){
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        BlocSelector<HomeScreenBloc, HomeScreenState, String>(
                          selector: (state){
                            return state.country ?? "";
                          },
                          builder: (_, selectedCountry){
                            if(country[index] == selectedCountry){
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Lottie.asset("assets/animations/moving_circle.json", width: 78),
                                  AnimatedBuilder(
                                    animation: _controller,
                                    builder: (_,child) {
                                      return Transform.rotate(
                                          angle: _controller.value * 2 * pi,
                                          child: child,
                                      );
                                    },
                                    child: Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              begin:Alignment.centerLeft ,
                                              end: Alignment.bottomRight,
                                              colors: [Colors.pink, Colors.deepPurple[700]!,])
                                          ),
                                    ),
                                  ),
                                ],
                              );
                            }else{
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                height: 46,
                                width: 46,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                        begin:Alignment.centerLeft ,
                                        end: Alignment.bottomRight,
                                        colors: [Colors.deepOrange[800]!, Colors.orange[300]!,])
                                ),

                              );
                            }
                          }
                        ),

                        GestureDetector(
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              border: Border.all(color: Colors.black),
                              image: DecorationImage(
                                  image: NetworkImage("https://www.bandeirasnacionais.com/data/flags/normal/${country[index]}.png"), fit: BoxFit.cover,
                              )
                            ),

                          ),
                          onTap: (){
                            context.read<HomeScreenBloc>().add(HomeScreenEventFindAll(country: country[index]));
                          },
                        ),
                      ],
                    );
                  }
              ),
            ),


            AnimatedContainer(
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
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
            ),

          ],
        );
      },
    );
  }
}