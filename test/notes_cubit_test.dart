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
          .having((state) => state.notes.length, 'notes length', 1)
          .having((state) => state.notes.last.title, 'last note title', 'New Note'),
    ],
  );
}
