import 'package:flutter/material.dart';
import 'package:mynotes/domain/models/note_model.dart';
import 'package:mynotes/presentation/note_details_screen.dart';

class NoteItem extends StatelessWidget {
  final NoteModel note;
  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        title: Text(
          note.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.tags.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Wrap(
                  spacing: 6.0,
                  children: note.tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      backgroundColor: Colors.tealAccent,
                    );
                  }).toList(),
                ),
              ),
            if (note.tags.isNotEmpty) const SizedBox(height: 8.0),
            Text(
              note.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        onTap: () => _showNoteDetailBottomSheet(context, note),
      ),
    );
  }
}

void _showNoteDetailBottomSheet(BuildContext context, NoteModel note) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: NoteDetailScreen(note: note),
      );
    },
  );
}
