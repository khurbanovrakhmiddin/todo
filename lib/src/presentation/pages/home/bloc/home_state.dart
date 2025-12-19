part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<NoteEntity> notes;
  final String? errorMessage;
  final bool isGridView;
  const HomeState({
    this.status = HomeStatus.initial,
    this.notes = const [],
    this.isGridView = false,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    bool? isGridView,
    List<NoteEntity>? notes,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      isGridView: isGridView ?? this.isGridView,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, notes, isGridView, errorMessage];
}
