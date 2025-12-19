part of 'app_tab_cubit.dart';

class AppTabState extends Equatable {
  final int index;
  final bool isDark;

  const AppTabState({this.index = 0, this.isDark = false});

  AppTabState copyWith({final int? index, final bool? isDark}) {
    return AppTabState(index: index ?? this.index);
  }

  @override
  List<Object> get props => [index];
}
