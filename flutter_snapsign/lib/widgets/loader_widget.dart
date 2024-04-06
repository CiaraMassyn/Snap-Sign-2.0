import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(20.0),
          child: Theme(
            data: ThemeData(
              primaryColor: Colors.green,
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
