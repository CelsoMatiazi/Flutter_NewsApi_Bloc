import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_event.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_state.dart';
import 'package:lottie/lottie.dart';

class CountriesFlagsWidget extends StatelessWidget {
  const CountriesFlagsWidget({
    Key? key,
    required this.country,
    required this.height,
    required AnimationController controller,
  }) : _controller = controller, super(key: key);

  final List country;
  final double height;
  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
    );
  }
}

