import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snapsign/components/my_button.dart';
import 'package:flutter_snapsign/components/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> passwordReset() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        );
      },
    );

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      Navigator.pop(context);
      _showSuccessDialog(); 
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); 
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: const Center(
              child: Text(
                'Error',
                style: TextStyle(color: Colors.white),
              ),
            ),
            content: Center(
              child: Text(
                e.message ?? 'An error occurred. Please try again later.',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          title: const Center(
            child: Text(
              'Success',
              style: TextStyle(color: Colors.black),
            ),
          ),
          content: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Password reset email has been sent.\nPlease check your email.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 16), 
                ),
                const SizedBox(height: 20),
                MyButton(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  text: 'OK',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/images/snapSignWhiteBackground.jpg',
                      width: 150,
                      height: 150,
                    ),
                    const Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Provide email to reset password',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 20),
                    MyButton(
                      onTap: passwordReset,
                      text: 'Reset Password',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
