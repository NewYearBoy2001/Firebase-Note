import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_easy/auth/auth_page.dart';
import 'package:ui_easy/src/ui/home/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if (snapshot.hasData) {
          return  const HomePage();
        } else{
          return const AuthPage();
        }
      },
      ),
    );
  }
}
