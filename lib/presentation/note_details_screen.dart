import 'package:flutter/material.dart';
import 'package:mynotes/domain/models/note_model.dart';
import 'package:mynotes/presentation/widgets/note_details_content_widget.dart';
import 'package:mynotes/presentation/widgets/header/note_details_header.dart';

class NoteDetailScreen extends StatelessWidget {
  final NoteModel note;

  const NoteDetailScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        color: Colors.white,
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NoteHeader(note: note),
                  const SizedBox(height: 20),
                  NoteDetailsContentWidget(
                    note: note,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
