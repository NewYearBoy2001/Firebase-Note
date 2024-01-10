import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_easy/components/textfield.dart';
import 'package:ui_easy/src/ui/bloc/authentication/authentication_bloc.dart';
import 'package:ui_easy/src/ui/bloc/authentication/authentication_state.dart';



class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final userController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  Future<void> signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        if (passwordConfirmed()) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

          await adduserDetails(
            emailController.text.trim(),
            userController.text.trim(),
            int.parse(ageController.text.trim()),
            int.parse(phoneController.text.trim()),
          );
        }
      } catch (error) {
        print("Error during sign up: $error");
      }
    }
  }

  Future adduserDetails(String email, String user, int age, int phone) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        "Email": email,
        "user": user,
        "Age": age,
        "Phone": phone,
      });
    } catch (error) {
      print("Error adding user details: $error");
    }
  }

  bool passwordConfirmed() {
    return passwordController.text.trim() == confirmPasswordController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lock,
                        size: 100,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Fill the Details',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 25),
                      MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: (value) => validateRequired(value, 'Email'),
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: userController,
                        hintText: "Username",
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: (value) => validateRequired(value, 'Username'),
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: ageController,
                        hintText: "Age",
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: (value) => validateRequired(value, 'Age'),
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: phoneController,
                        hintText: "Phone",
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: (value) => validateRequired(value, 'Phone'),
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        validator: (value) => validateRequired(value, 'Password'),
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != passwordController.text.trim()) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: GestureDetector(
                          onTap: signUp,
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "I'm a member?",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: widget.showLoginPage,
                            child: const Text(
                              'Login now',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
