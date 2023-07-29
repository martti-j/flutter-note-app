import 'package:flutter/material.dart';
import 'package:note_app/constants/routes.dart';
import 'package:note_app/services/registration.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  late final TextEditingController _username;
  late final TextEditingController _password;

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _username,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Write your username here',
            ),
          ),
          TextField(
            controller: _password,
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Write your password here',
            ),
          ),
          TextButton(
            onPressed: () async {
              if (await registration(_username.text, _password.text)) {
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute, (route) => false);
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text("Notification"),
                      content: const Text("User added."),
                      actions:<Widget> [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),)
                      ],
                    )
                  );
                }
              } else {
                if (context.mounted) {
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Notification'),
                      content: const Text('Username is already in use'),
                      actions:<Widget> [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),)
                      ],
                    )
                  );
                }
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              loginRoute, (route) => false),
              child: const Text('Back'))
        ],
      ),
    );
  }
}
