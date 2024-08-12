import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/domain/models/note_model.dart';
import 'package:mynotes/domain/repositories/note_repository.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NoteRepository repository;
  String searchQuery = '';
  String sortOption = 'title';
  List<String> selectedTags = [];

  NotesCubit(this.repository) : super(NotesInitial());

  Future<void> fetchNotes() async {
    try {
      emit(NotesLoading());
      final notes = await repository.getNotes(
        searchQuery: searchQuery,
        selectedTags: selectedTags,
      );
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(const NotesError("Failed to load notes"));
    }
  }

  Future<void> addNote(NoteModel note) async {
    try {
      await repository.createNote(note);
      await fetchNotes();
    } catch (e) {
      emit(const NotesError("Failed to add note"));
    }
  }

  Future<void> updateNote(NoteModel note) async {
    try {
      await repository.updateNote(note);
      await fetchNotes();
    } catch (e) {
      emit(const NotesError("Failed to update note"));
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await repository.deleteNote(id);
      await fetchNotes();
    } catch (e) {
      emit(const NotesError("Failed to delete note"));
    }
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    fetchNotes();
  }

  void updateSelectedTags(List<String> tags) {
    selectedTags = tags;
    fetchNotes();
  }
}
