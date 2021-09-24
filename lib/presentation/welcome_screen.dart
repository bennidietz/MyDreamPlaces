import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/network/constants.dart';
import 'package:flutter_music_player_app/presentation/widgets/show_snackbar.dart';
import 'package:flutter_music_player_app/router/router_constants.dart';
import 'package:flutter_music_player_app/services/authentification_service.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        if (currentUser != null) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          //Navigator.pushReplacementNamed(context, welcomeRoute);
        }
        currentUser = null;
      } else {
        print('User with email ${user.email} is signed in!');
        Navigator.pushNamed(context, homeRoute, arguments: user);
        currentUser = user;
      }
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Welcome Screen"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: defaultPadding * 5,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              SizedBox(
                height: defaultPadding * 2,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // LocalStorage.setItem(NAME, _deadlineController.text).then((value) => {
                    //    Navigator.pushNamed(context, homeRoute)
                    // });
                    context
                        .read<AuthentificationService>()
                        .signIn(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        )
                        .then((value) =>
                            showSnackbar(context: context, message: value));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8.0),
                    child: Text('Lass uns starten!'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
