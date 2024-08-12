import 'package:mynotes/domain/models/note_model.dart';

abstract class NotesState {
  const NotesState();
}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<NoteModel> notes;

  const NotesLoaded(this.notes);
}

class NotesError extends NotesState {
  final String message;

  const NotesError(this.message);
}
