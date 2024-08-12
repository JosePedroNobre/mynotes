import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/presentation/cubit/notes_cubit.dart';

class NoteSearchField extends StatefulWidget {
  const NoteSearchField({super.key});

  @override
  NoteSearchFieldState createState() => NoteSearchFieldState();
}

class NoteSearchFieldState extends State<NoteSearchField> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<NotesCubit>().updateSearchQuery(''); // Show all notes when search is cleared
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Tap to search notes...',
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintStyle: const TextStyle(color: Colors.white),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear, color: Colors.white),
          onPressed: _clearSearch,
        ),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => context.read<NotesCubit>().updateSearchQuery(query),
    );
  }
}
