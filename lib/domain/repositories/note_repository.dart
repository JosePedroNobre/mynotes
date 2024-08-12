import 'package:mynotes/domain/models/note_model.dart';

abstract class NoteRepository {
  Future<List<NoteModel>> getNotes({
    String searchQuery = '',
    List<String> selectedTags = const [],
  });
  Future<NoteModel> getNoteById(String id);
  Future<void> createNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(String id);
}
