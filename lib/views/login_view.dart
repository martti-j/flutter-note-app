import 'package:flutter/material.dart';
import 'package:note_app/constants/routes.dart';
import 'package:note_app/services/login.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 56.0),
            child: Text(
              'Welcome',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
          ),
          TextField(
            controller: _username,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
                const InputDecoration(hintText: 'Please your username here'),
          ),
          TextField(
            controller: _password,
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(
                hintText: 'Please enter your password here'),
          ),
          TextButton(
            onPressed: () async {
              if (await login(_username.text, _password.text)) {
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      notesRoute, (route) => false);
                }
              } else {
                if (context.mounted) {
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Notification'),
                      content: const Text('You have given the wrong username or password.'),
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
            child: const Text('Login'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    registrationRoute, (route) => false);
              },
              child: const Text('Register here')),
        ],
      ),
    );
  }
}
