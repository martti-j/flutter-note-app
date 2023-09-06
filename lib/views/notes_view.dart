import 'package:flutter/material.dart';
import 'package:note_app/constants/routes.dart';
import 'package:note_app/services/login.dart';
import 'package:note_app/services/notes.dart';

enum MenuActions { logout }

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {

  void updateNoteList() {
    setState(() {
      notes = getNotes();
    });
  }

  Future<List> notes = getNotes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          PopupMenuButton<MenuActions>(
            onSelected: (value) async {
              switch (value) {
                case MenuActions.logout:
                  final navigator = Navigator.of(context);
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    logout();
                    navigator.pushNamedAndRemoveUntil(
                        loginRoute, (route) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuActions>(
                  value: MenuActions.logout,
                  child: Text('Log out'),
                ),
              ];
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, newNoteRoute);
            },
            child: const Text('New note'),
          ),
          Expanded(
            child: FutureBuilder(
              future: notes,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          print(snapshot.data);
                          return Container(
                            margin: const EdgeInsets.all(10.0),
                            height: MediaQuery.of(context).size.height / 3.5,
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    snapshot.data[index]['Tittle'],
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      snapshot.data[index]['Content'],
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "By ${snapshot.data[index]['Writer']}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          );
                        default:
                          return const CircularProgressIndicator();
                      }
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Log out')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
