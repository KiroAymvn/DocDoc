import 'package:appointment/core/network/api_error.dart';
import 'package:appointment/features/home%20screen/data/model/home_page_model.dart';
import 'package:appointment/features/home%20screen/data/repo/home_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  HomeRepo _homeRepo=HomeRepo();

  Future<void>getHomePageData()async{
    try{
      emit(HomeLoading());
      print("LOADINGGG");

      final data = await _homeRepo.getDoctorsHomeScreen();
      print("DATA CAME");

      emit(HomeSuccess(homeDataList: data));
    }catch(e){
      if(e is ApiError){
        emit(HomeFailed(errorMessage: e.message.toString()));
      }
      else{
        emit(HomeFailed(errorMessage: e.toString()));
      }
    }
  }


}
