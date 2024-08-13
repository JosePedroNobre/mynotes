import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/domain/models/note_model.dart';
import 'package:mynotes/presentation/cubit/notes_cubit.dart';
import 'package:mynotes/presentation/widgets/note_tag_selector.dart';

class NoteDetailsContentWidget extends StatelessWidget {
  final NoteModel note;

  const NoteDetailsContentWidget({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(text: note.title);
    final TextEditingController contentController = TextEditingController(text: note.content);
    List<String> selectedTags = List<String>.from(note.tags);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: contentController,
              maxLines: null,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    height: 1.5,
                    color: Colors.grey[800],
                  ),
              decoration: const InputDecoration(
                hintText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            NoteTagSelector(
              initialSelectedTags: selectedTags,
              onTagsChanged: (updatedTags) {
                selectedTags = updatedTags;
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                final updatedNote = note.copyWith(
                  title: titleController.text,
                  content: contentController.text,
                  tags: selectedTags,
                );
                context.read<NotesCubit>().updateNote(updatedNote);
                Navigator.pop(context);
              },
              style: Theme.of(context).elevatedButtonTheme.style,
              child: Text(
                'Save',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
