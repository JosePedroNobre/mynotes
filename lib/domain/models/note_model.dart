import 'package:mynotes/core/encryption_generator.dart';

class NoteModel {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final List<String> tags;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.tags = const [],
  });

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    List<String>? tags,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
    );
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'tags': tags,
    };
  }

  NoteModel encryptContent(EncryptionGenerator helper) {
    return copyWith(
      content: helper.encryptText(this.content),
    );
  }

  NoteModel decryptContent(EncryptionGenerator helper) {
    return copyWith(
      content: helper.decryptText(this.content),
    );
  }
}
