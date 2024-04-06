import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_snapsign/components/login_component.dart';
import 'package:flutter_snapsign/widgets/loader_widget.dart'; 

class MyButton extends StatelessWidget {
  final VoidCallback onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7ED957),
          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> { 
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false; 

  void signUserIn(BuildContext context) async {
    setState(() {
      _isLoading = true; 
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Error email');
      } else if (e.code == 'wrong-password') {
        print('Error password');
      }
    } finally {
      setState(() {
        _isLoading = false; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Stack( 
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    Image.asset(
                      'lib/images/snapSignWhiteBackground.jpg',
                      height: 100,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Provide login details',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LoginFormField(
                      controller: _emailController,
                      hintText: 'Email',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 8),
                    LoginFormField(
                      controller: _passwordController,
                      hintText: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFF0094FF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    MyButton(
                      onTap: () => signUserIn(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: Color(0xFF0094FF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20.0),
                            height: 1.0,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          "OR",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20.0),
                            height: 1.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: IconButton(
                              icon: Image.asset(
                                'lib/images/googleOutline.png',
                                height: 100,
                              ),
                              onPressed: () {},
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _isLoading ? LoadingWidget() : const SizedBox(), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
