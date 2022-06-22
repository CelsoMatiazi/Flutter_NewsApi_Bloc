import 'package:bloc/bloc.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_event.dart';
import 'package:google_news_flutter/Screens/home_screen/bloc_controller/home_screen_state.dart';
import 'package:google_news_flutter/repository/google_news_data.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState>{

  final GoogleNewsRepository _repository;

  HomeScreenBloc({
      required GoogleNewsRepository repository
  }) : _repository = repository,
       super(HomeScreenStateInitial()){
          on<HomeScreenEventFindAll>(_findAllNews);
          on<HomeScreenEventShowSearchBar>(_showSearchBar);
  }

  Future<void> _findAllNews(HomeScreenEventFindAll event, Emitter<HomeScreenState> emit) async{
    try{
      emit(HomeScreenStateLoading());
      final data = await _repository.getGoogleNews();
      emit(HomeScreenStateData(data: data));
    }catch(e){
      emit(HomeScreenStateError(message: "Erro ao atualizar o feed de noticias"));
    }
  }

  void _showSearchBar(HomeScreenEventShowSearchBar event, Emitter<HomeScreenState> emit){
      if(event.height == 0.0){
        emit(HomeScreenStateShowSearchBar(height: 65.0, data: state.data ?? []));
      }else{
        emit(HomeScreenStateShowSearchBar(height: 0.0, data: state.data ?? []));
      }
  }

}