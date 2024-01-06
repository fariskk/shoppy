part of 'home_ui_cubit.dart';

@immutable
sealed class HomeUiState {
  int currentIndex = 0;
}

final class HomeUiInitial extends HomeUiState {
  int currentIndex;
  HomeUiInitial({required this.currentIndex});
}
