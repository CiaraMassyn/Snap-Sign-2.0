import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(BuildContext) logoutCallback;

  TopNavBar({required this.logoutCallback});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green.withOpacity(0.5), 
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.edit, size: 24), 
          Text(
            'Snap Sign',
            style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              logoutCallback(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
