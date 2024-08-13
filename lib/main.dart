import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/domain/repositories/note_mocked_repository.dart';
import 'package:mynotes/presentation/cubit/notes_cubit.dart';
import 'package:mynotes/presentation/home_screen.dart';
import 'package:mynotes/styleguide/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotesCubit>(
          create: (context) => NotesCubit(
              MockNoteRepository()), // mocked is by default. The code for the remote connection is in the project in the network package. Couldn't do the hosting due to pricing and limits on free tier.
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: customTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
