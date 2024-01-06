import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_ui_state.dart';

class HomeUiCubit extends Cubit<HomeUiState> {
  HomeUiCubit() : super(HomeUiInitial(currentIndex: 0));

  void onNavigationButtonClicked(int newIndex) {
    emit(HomeUiInitial(currentIndex: newIndex));
  }
}
