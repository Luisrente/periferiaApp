import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:periferiamovies/core/localization/generated/strings.dart';
import 'package:periferiamovies/utils/helper/data_helper.dart';


part 'main_state.dart';

class MainBlog extends Cubit<MainState> {
  MainBlog() : super(const MainLoading());

  int _currentIndex = 0;
  late List<DataHelper> dataMenus;

  void updateIndex(int index, {BuildContext? context}) {
    emit(const MainLoading());
    _currentIndex = index;
    if (context != null) {
      initMenu(context);
    }
    emit(MainSuccess(dataMenus[_currentIndex]));
  }

  void initMenu(BuildContext context) {
    dataMenus = [
      DataHelper(
        title: Strings.of(context)!.dashboard,
        isSelected: true,
      ),
      DataHelper(
        title: Strings.of(context)!.settings,
      ),
      DataHelper(
        title: Strings.of(context)!.logout,
      ),
    ];
    updateIndex(_currentIndex);
  }

  bool onBackPressed(
    BuildContext context,
    GlobalKey<ScaffoldState> scaffoldState,
  ) {
    if (dataMenus[_currentIndex].title == Strings.of(context)!.dashboard) {
      return true;
    } else {
      if (scaffoldState.currentState!.isEndDrawerOpen) {
        //hide navigation drawer
        scaffoldState.currentState!.openDrawer();
      } else {
        for (final menu in dataMenus) {
          menu.isSelected = menu.title == Strings.of(context)!.dashboard;
        }
      }

      return false;
    }
  }
}
