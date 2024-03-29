import 'package:google_news_flutter/models/google_data_model.dart';

abstract class HomeScreenState{
  final List<GoogleDataModel>? data;
  final String? message;
  final double? searchBarHeight;
  final String? searchWord;
  final String? country;
  HomeScreenState({
    this.data,
    this.message,
    this.searchBarHeight = 0.0,
    this.searchWord,
    this.country
  });
}

class HomeScreenStateInitial extends HomeScreenState{
  HomeScreenStateInitial() : super(data: []);
}

class HomeScreenStateData extends HomeScreenState{
  HomeScreenStateData({
    required List<GoogleDataModel> data,
    required String country
  }) : super(data: data, country: country);
}

class HomeScreenStateDataByWord extends HomeScreenState{
  HomeScreenStateDataByWord({
    required String word
  }) : super(searchWord: word);
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


