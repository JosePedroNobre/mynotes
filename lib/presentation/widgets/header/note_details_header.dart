import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/core/pdf_generator.dart';
import 'package:mynotes/domain/models/note_model.dart';
import 'package:mynotes/presentation/cubit/notes_cubit.dart';

class NoteHeader extends StatelessWidget {
  final NoteModel note;
  const NoteHeader({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Edit Note",
          style: TextStyle(
            color: Colors.teal[800],
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => saveNoteAsPdf(context, note),
              child: Text(
                'Export',
                style: TextStyle(color: Colors.teal[800], fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                context.read<NotesCubit>().deleteNote(note.id);
                Navigator.pop(context);
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
