import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mynotes/domain/models/note_model.dart';
import 'package:mynotes/domain/repositories/note_mocked_repository.dart';
import 'package:mynotes/domain/repositories/note_repository.dart';
import 'package:mynotes/presentation/cubit/notes_cubit.dart';
import 'package:mynotes/presentation/cubit/notes_state.dart';

void main() {
  late NoteRepository mockNoteRepository;
  late NotesCubit notesCubit;

  setUp(() {
    mockNoteRepository = MockNoteRepository();
    notesCubit = NotesCubit(mockNoteRepository);
  });

  blocTest<NotesCubit, NotesState>(
    'should create a new note',
    build: () => notesCubit,
    act: (cubit) async {
      final newNote = NoteModel(
        id: '',
        title: 'New Note',
        content: 'This is a new note.',
        createdAt: DateTime.now(),
      );

      await cubit.addNote(newNote);
    },
    expect: () => [
      isA<NotesLoading>(),
      isA<NotesLoaded>()
          .having((state) => state.notes.length, 'notes length', 2)
          .having((state) => state.notes.last.title, 'last note title', 'New Note'),
    ],
  );

  blocTest<NotesCubit, NotesState>(
    'should delete a note and reflect the change in notes',
    build: () => notesCubit,
    act: (cubit) async {
      final notes = await mockNoteRepository.getNotes();
      final noteToDelete = notes.first;

      // Delete the note
      await cubit.deleteNote(noteToDelete.id);

      // Verify notes after deletion
      final updatedNotes = await mockNoteRepository.getNotes();
      // Make sure the length of notes is as expected
      expect(updatedNotes.length, notes.length - 1);
    },
    expect: () => [
      isA<NotesLoading>(),
      isA<NotesLoaded>().having((state) => state.notes.length, 'notes length', 0),
    ],
  );
}
