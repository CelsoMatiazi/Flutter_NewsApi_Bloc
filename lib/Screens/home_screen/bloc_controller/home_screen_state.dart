

import 'package:google_news_flutter/models/google_data_model.dart';

abstract class HomeScreenState{
  final List<GoogleDataModel>? data;
  final String? message;
  final double? searchBarHeight;
  HomeScreenState({
    this.data,
    this.message,
    this.searchBarHeight = 0.0,
  });
}

class HomeScreenStateInitial extends HomeScreenState{
  HomeScreenStateInitial() : super(data: []);
}

class HomeScreenStateData extends HomeScreenState{
  HomeScreenStateData({
    required List<GoogleDataModel> data
  }) : super(data: data);
}

class HomeScreenStateLoading extends HomeScreenState{
  HomeScreenStateLoading() : super();
}

class HomeScreenStateError extends HomeScreenState{
  HomeScreenStateError({required String message}) : super(message: message);
}

class HomeScreenStateShowSearchBar extends HomeScreenState{
  HomeScreenStateShowSearchBar({
    required double height,
    required List<GoogleDataModel> data
  }) : super(searchBarHeight: height, data: data);
}