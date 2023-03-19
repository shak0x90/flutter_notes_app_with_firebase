import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class Registerview extends StatefulWidget {
  const Registerview({super.key});

  @override
  State<Registerview> createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text("register "),
        ),
        body: Center(
          child: FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  // TODO: Handle this case.

                  return Column(
                    children: [
                      TextField(
                        controller: _email,
                        decoration: const InputDecoration(
                            hintText: "Enter your email here "),
                      ),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                            hintText: "Enter Password Here "),
                      ),
                      TextButton(
                        onPressed: () async {
                          Firebase.initializeApp(
                            options: DefaultFirebaseOptions.currentPlatform,
                          );
                          final email = _email.text;
                          final password = _password.text;

                          try {
                            final usercredial = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: password);

                            print(usercredial);
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                          }
                        },
                        child: const Text("Register"),
                      ),
                    ],
                  );

                default:
                  return const Text('Loding......');
              }
            },
          ),
        ));
  }
}
