import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_event.dart';
import 'package:lottie/lottie.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return SizedBox(
      width: 210,
      child: Drawer(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              const SizedBox(height: 80,),
              SizedBox(
                width: 150,
                height: 100,
                child: Lottie.asset("assets/animations/earth.json",),
              ),

              //const SizedBox(height: 15,),
              const Text("World News",
                style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                    letterSpacing: 2
                ),
              ),

              const SizedBox(height: 15,),

              ListView(
                shrinkWrap: true,
                children: categories.map((e){
                  return GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      context.read<HomeScreenBloc>().add(HomeScreenEventFindByWord(word: e));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(e,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w200
                          ),
                        ),
                        const Divider(color: Colors.white54,),
                      ],
                    ),
                  );
                }).toList(),
              )

            ],
          ),
        ),
      ),
    );
  }
}
