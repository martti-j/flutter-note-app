import 'package:flutter/material.dart';
import 'package:note_app/views/login_view.dart';
import 'package:note_app/views/notes_view.dart';
import 'package:note_app/constants/routes.dart';
import 'package:note_app/views/registration_view.dart';

void main() {
  runApp(
    MaterialApp(
      home: const AppStart(),
      routes: {
        notesRoute: (context) => const NotesView(),
        loginRoute: (context) => const LoginView(),
        registrationRoute: (context) => const RegistrationView(),
      }
    )
  );
}

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}