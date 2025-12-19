import '../../domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  const NoteModel({
    super.id,
    required super.title,
    required super.subtitle,
    required super.photos,
    required super.audios,
    required super.createdAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'] ?? '',
      photos: List<String>.from(map['photos'] ?? []),
      audios: List<String>.from(map['audio'] ?? []),
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  factory NoteModel.fromEntity(NoteEntity entity) {
    return NoteModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      photos: entity.photos,
      audios: entity.audios,
      createdAt: entity.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
