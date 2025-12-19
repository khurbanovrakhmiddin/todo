import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final int? id;
  final String title;
  final String subtitle;
  final List<String> photos;
  final List<String> audios;
  final DateTime createdAt;

  const NoteEntity({
    this.id,
    required this.title,
    required this.subtitle,
    required this.photos,
    required this.audios,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [title, subtitle, photos, audios, createdAt, id];
}
