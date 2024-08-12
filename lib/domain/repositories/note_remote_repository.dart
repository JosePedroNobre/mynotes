import 'package:mynotes/domain/models/note_model.dart';
import 'package:mynotes/domain/repositories/note_repository.dart';
import 'package:mynotes/network/api_service.dart';

class NoteRepositoryImpl implements NoteRepository {
  final ApiService noteApi;

  NoteRepositoryImpl(this.noteApi);

  @override
  Future<NoteModel> getNoteById(String id) async {
    final response = await noteApi.get("/notes/$id");
    return NoteModel.fromJson(response);
  }

  @override
  Future<void> createNote(NoteModel note) async {
    await noteApi.post("/notes", data: note.toJson());
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    await noteApi.put("/notes/${note.id}", data: note.toJson());
  }

  @override
  Future<void> deleteNote(String id) async {
    await noteApi.delete("/notes/$id");
  }

  @override
  Future<List<NoteModel>> getNotes({String searchQuery = '', List<String> selectedTags = const []}) {
    // TODO: implement getNotes
    throw UnimplementedError();
  }
}
