

import 'package:google_news_flutter/models/google_data_model.dart';

abstract class HomeScreenState{
  final List<GoogleDataModel>? data;
  final String? message;
  HomeScreenState({
    this.data,
    this.message
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
  HomeScreenStateLoading() : super(data: []);
}

class HomeScreenStateError extends HomeScreenState{
  HomeScreenStateError({required String message}) : super(message: message);
}