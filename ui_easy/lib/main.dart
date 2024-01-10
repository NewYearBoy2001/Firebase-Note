import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_easy/auth/main_page.dart';
import 'package:ui_easy/src/ui/bloc/authentication/authentication_bloc.dart';
import 'package:ui_easy/src/ui/bloc/home/note_bloc.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider<NotesBloc>(
          create: (context) => NotesBloc(),
        ),
        // Add more BlocProviders as needed for other screens
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage(), // Replace with your main screen widget
      ),
    );
  }
}

