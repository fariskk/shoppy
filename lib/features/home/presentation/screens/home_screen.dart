import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/core/common/common_widgets.dart';
import 'package:shoppy/features/home/presentation/state/cubit/home_ui_cubit.dart';
import 'package:shoppy/features/home/presentation/widgets/home_screen_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List pages = [HomePage(), CategoriePage(), CartPage(), ProfilePage()];
    return Scaffold(
      body: SafeArea(child: BlocBuilder<HomeUiCubit, HomeUiState>(
        builder: (context, state) {
          return pages[state.currentIndex];
        },
      )),
      bottomNavigationBar: BlocBuilder<HomeUiCubit, HomeUiState>(
        builder: (context, state) {
          return myBottomNavigationBar(state.currentIndex, context);
        },
      ),
    );
  }
}
