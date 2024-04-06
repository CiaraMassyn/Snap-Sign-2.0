import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snapsign/screens/dashboard/home_screen.dart';
import 'package:flutter_snapsign/screens/login/login_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            return HomeScreen();
          }
          else {
            return LoginPage();
          }
        }
      ),
    );
  }
}