

import 'package:google_news_flutter/models/google_data_model.dart';

abstract class HomeScreenEvent{}

class HomeScreenEventFindAll extends HomeScreenEvent{}

class HomeScreenEventShowSearchBar extends HomeScreenEvent{
  final double height;
  HomeScreenEventShowSearchBar({
    required this.height,
  });
}