

abstract class HomeScreenEvent{}

class HomeScreenEventFindAll extends HomeScreenEvent{}

class HomeScreenEventShowSearchBar extends HomeScreenEvent{
  final double height;
  HomeScreenEventShowSearchBar({
    required this.height,
  });
}