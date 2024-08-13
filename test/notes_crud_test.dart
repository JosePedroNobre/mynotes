import 'package:flutter_test/flutter_test.dart';
import 'package:mynotes/domain/models/note_model.dart';
import 'package:mynotes/domain/repositories/note_mocked_repository.dart';
import 'package:mynotes/domain/repositories/note_repository.dart';

void main() {
  late NoteRepository mockNoteRepository;

  setUp(() {
    mockNoteRepository = MockNoteRepository();
  });

  test('should return all notes', () async {
    final notes = await mockNoteRepository.getNotes();
    expect(notes.length, 0); // repository starts with 0 note by default
  });

  test('should create a new note', () async {
    final newNote = NoteModel(
      id: '',
      title: 'New Note',
      content: 'This is a new note.',
      createdAt: DateTime.now(),
    );

    await mockNoteRepository.createNote(newNote);
    final notes = await mockNoteRepository.getNotes();
    expect(notes.length, 1); // repository starts with 0 note by default
    expect(notes.last.title, 'New Note');
  });

  test('should create and delete a note', () async {
    final newNote = NoteModel(
      id: '',
      title: 'New Note',
      content: 'This is a new note.',
      createdAt: DateTime.now(),
    );

    await mockNoteRepository.createNote(newNote);
    final note = await mockNoteRepository.getNotes().then((notes) => notes.first);
    await mockNoteRepository.deleteNote(note.id);
    final notes = await mockNoteRepository.getNotes();
    expect(notes.length, 0); // repository starts with 0 note by default, we added and removed so we will have 0 notes
  });

  test('should return all notes when no filters are applied', () async {
    final notes = await mockNoteRepository.getNotes();
    expect(notes.length, 0); // repository starts with 0 note by default
  });

  test('should filter notes by search query', () async {
    // Adding a note with the search query in its title
    final additionalNote = NoteModel(
      id: '',
      title: 'Searchable Note',
      content: 'This note contains search keyword.',
      createdAt: DateTime.now(),
    );
    await mockNoteRepository.createNote(additionalNote);

    final notes = await mockNoteRepository.getNotes(searchQuery: 'Searchable');
    expect(notes.length, 1);
    expect(notes.first.title, 'Searchable Note');
  });

  test('should filter notes by tags', () async {
    final taggedNote = NoteModel(
      id: '',
      title: 'Tagged Note',
      content: 'This note has tags.',
      createdAt: DateTime.now(),
      tags: ['important'],
    );
    await mockNoteRepository.createNote(taggedNote);

    final notes = await mockNoteRepository.getNotes(selectedTags: ['important']);
    expect(notes.length, 1);
    expect(notes.first.title, 'Tagged Note');
  });

  test('should apply search query and tag filters together', () async {
    // Adding notes to test combined filters
    final searchNote = NoteModel(
      id: '',
      title: 'Filterable Note',
      content: 'This note will be filtered by search and tag.',
      createdAt: DateTime.now(),
      tags: ['work'],
    );
    final otherNote = NoteModel(
      id: '',
      title: 'Other Note',
      content: 'This note should not appear.',
      createdAt: DateTime.now(),
      tags: ['personal'],
    );
    await mockNoteRepository.createNote(searchNote);
    await mockNoteRepository.createNote(otherNote);

    final notes = await mockNoteRepository.getNotes(
      searchQuery: 'Filterable',
      selectedTags: ['work'],
    );
    expect(notes.length, 1);
    expect(notes.first.title, 'Filterable Note');
  });

  test('should return an empty list if no notes match the filters', () async {
    final notes = await mockNoteRepository.getNotes(
      searchQuery: 'Nonexistent',
      selectedTags: ['nonexistent'],
    );
    expect(notes.length, 0);
  });
}
