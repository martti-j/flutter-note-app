import 'package:flutter/material.dart';
import 'package:note_app/views/login_view.dart';
import 'package:note_app/views/notes_view.dart';
import 'package:note_app/constants/routes.dart';
import 'package:note_app/views/registration_view.dart';
import 'package:note_app/views/new_note_view.dart';
import 'package:note_app/services/login.dart';

void main() {
  runApp(
    MaterialApp(
      home: const AppStart(),
      routes: {
        notesRoute: (context) => const NotesView(),
        loginRoute: (context) => const LoginView(),
        registrationRoute: (context) => const RegistrationView(),
        newNoteRoute:(context) => const NewNoteView(),
      }
    )
  );
}

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if(snapshot.data == null) {
          return const LoginView();
        } else {
          return const NotesView();
        }
      }
    );
  }
}