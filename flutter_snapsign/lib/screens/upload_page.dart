import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UploadPage extends StatelessWidget {
  
  final user = FirebaseAuth.instance.currentUser!;
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
            color: Colors.black,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              'Upload your files here',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
