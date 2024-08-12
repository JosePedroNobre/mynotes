import 'dart:async';
import 'package:mynotes/core/id_generator.dart';
import 'package:mynotes/domain/models/note_model.dart';
import 'package:mynotes/domain/repositories/note_repository.dart';

enum NoteTags { important, personal, ideas, work }

class MockNoteRepository implements NoteRepository {
  final List<NoteModel> _notes = [];
  final durationOfApiCall = 200;

  MockNoteRepository();

  @override
  Future<List<NoteModel>> getNotes({
    String searchQuery = '',
    List<String> selectedTags = const [],
  }) async {
    await Future.delayed(Duration(milliseconds: durationOfApiCall));

    var filteredNotes = List<NoteModel>.from(_notes);

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filteredNotes = filteredNotes.where((note) {
        return note.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            note.content.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Apply tag filter
    if (selectedTags.isNotEmpty) {
      filteredNotes = filteredNotes.where((note) {
        return note.tags.any((tag) => selectedTags.contains(tag));
      }).toList();
    }

    return filteredNotes;
  }

  @override
  Future<NoteModel> getNoteById(String id) async {
    await Future.delayed(Duration(milliseconds: durationOfApiCall));
    return _notes.firstWhere((note) => note.id == id);
  }

  @override
  Future<void> createNote(NoteModel note) async {
    await Future.delayed(Duration(milliseconds: durationOfApiCall));
    final newNote = note.copyWith(id: generateUniqueId(), createdAt: DateTime.now());
    _notes.add(newNote);
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    await Future.delayed(Duration(milliseconds: durationOfApiCall));
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note.copyWith(createdAt: _notes[index].createdAt);
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    await Future.delayed(Duration(milliseconds: durationOfApiCall));
    _notes.removeWhere((note) => note.id == id);
  }
}
