import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invictus_asgn/deco_button.dart';
import 'package:invictus_asgn/gradient.dart';
import 'package:http/http.dart' as http;
import 'package:invictus_asgn/screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _submitting = false;
  bool _passVisible = false;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {},
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'By signing up you agree to our ',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xfff71a5d),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const GradientText(
                "Symmatric",
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 210, 21, 78),
                    Color.fromRGBO(254, 104, 84, 1),
                  ],
                ),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                "asset/logo.png",
                height: 150,
              ),
              const SizedBox(height: 10),
              Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 28,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              // SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    label: Text('Email'),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xfff71a5d),
                        width: 1.5,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xfff71a5d),
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  obscureText: !_passVisible,
                  controller: _passController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: (_passVisible)
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _passVisible = !_passVisible;
                        });
                      },
                    ),
                    label: const Text('Password'),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xfff71a5d),
                        width: 1.5,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xfff71a5d),
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
              (!_submitting)
                  ? DecoButton(
                      label: 'Sign Up',
                      onClick: () {
                        _createUser(_emailController.text.trim(),
                            _passController.text.trim());
                      },
                    )
                  : DecoButton(
                      onClick: () {},
                      child: const CircularProgressIndicator(),
                    ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xfff71a5d),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Spacer(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _createUser(String email, String password) async {
    setState(() {
      _submitting = true;
    });
    try {
      final response = await http.post(
        Uri.parse('https://0a6d-49-36-187-104.ngrok-free.app/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      final success = jsonDecode(response.body)['success'];
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return NextScreen(success: success);
        }));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('An error Occured!')));
    }

    setState(() {
      _submitting = false;
    });
  }
}
