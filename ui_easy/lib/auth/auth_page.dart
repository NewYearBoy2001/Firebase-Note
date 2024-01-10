import 'package:flutter/material.dart';
import 'package:ui_easy/src/ui/login/login_page.dart';
import 'package:ui_easy/src/ui/register/register_page.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showLoginPage = true;

  void toggleScreens(){
    setState(() {
      showLoginPage =!showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage:toggleScreens);
    }else{
      return RegisterPage(showLoginPage:toggleScreens);
    }
    }
}
