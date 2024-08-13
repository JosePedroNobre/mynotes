import 'package:flutter/material.dart';
import 'package:mynotes/domain/models/note_model.dart';
import 'package:mynotes/presentation/widgets/list/note_item.dart';

class NotesList extends StatelessWidget {
  final List<NoteModel> notes;
  const NotesList({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return notes.isEmpty
        ? _buildEmptyState(context)
        : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return NoteItem(note: note);
            },
          );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        'No notes yet!\nTap the + button to add your first note.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey),
      ),
    );
  }
}
