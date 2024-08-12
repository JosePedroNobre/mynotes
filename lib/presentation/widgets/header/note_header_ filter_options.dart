import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/presentation/cubit/notes_cubit.dart';
import 'package:mynotes/presentation/widgets/note_tag_selector.dart';

class NoteHeaderFilterOptions extends StatelessWidget {
  const NoteHeaderFilterOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Notes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          NoteTagSelector(
            initialSelectedTags: context.watch<NotesCubit>().selectedTags,
            onTagsChanged: (updatedTags) {
              context.read<NotesCubit>().updateSelectedTags(updatedTags);
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
