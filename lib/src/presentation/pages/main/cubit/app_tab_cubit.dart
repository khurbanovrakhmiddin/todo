import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'app_tab_state.dart';

class AppTabCubit extends Cubit<AppTabState> {
  AppTabCubit() : super(const AppTabState());

  void changeTab(int index) {
    emit(state.copyWith(index: index));
  }

  void changeTheme(bool isDark) {
    emit(state.copyWith(isDark: isDark));
  }
}
