import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Loader<B extends StateStreamable<S>, S> extends StatelessWidget {
  final BlocWidgetSelector<S, bool> selector;
  const Loader({Key? key, required this.selector}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, S, bool>(
        selector: selector,
        builder: (context, loading){
          return Visibility(
              visible: loading,
              child:  const SizedBox(
                // height: MediaQuery.of(context).size.height - 80,
                // width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          );
        }
    );
  }
}
