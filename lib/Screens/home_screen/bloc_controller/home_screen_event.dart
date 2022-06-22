
abstract class HomeScreenEvent{}

class HomeScreenEventFindAll extends HomeScreenEvent{}

class HomeScreenEventFindByWord extends HomeScreenEvent{
  final String word;
  HomeScreenEventFindByWord({required this.word});
}

class HomeScreenEventShowSearchBar extends HomeScreenEvent{
  final double height;
  HomeScreenEventShowSearchBar({
    required this.height,
  });
}