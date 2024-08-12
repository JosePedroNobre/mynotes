import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/domain/models/note_model.dart';
import 'package:mynotes/presentation/widgets/add_note_widget.dart';
import 'package:mynotes/presentation/cubit/notes_cubit.dart';
import 'package:mynotes/presentation/cubit/notes_state.dart';
import 'package:mynotes/presentation/widgets/header/note_header_%20filter_options.dart';
import 'package:mynotes/presentation/widgets/header/note_search_field.dart';
import 'package:mynotes/presentation/widgets/list/notes_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().fetchNotes();
  }

  void _showAddNoteBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (_) => const AddNoteWidget(),
    ).then((result) {
      if (result is NoteModel) {
        context.read<NotesCubit>().addNote(result);
      }
    });
  }

  void _showFilterOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (_) => const NoteHeaderFilterOptions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.search, color: Colors.white),
        title: const NoteSearchField(),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showFilterOptionsBottomSheet,
          ),
        ],
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotesLoaded) {
            return NotesList(notes: state.notes);
          } else if (state is NotesError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No notes available.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoteBottomSheet,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
