import 'package:flutter/material.dart';

class TopNavBarPage extends StatelessWidget implements PreferredSizeWidget {
  final Function(BuildContext) logoutCallback;

  const TopNavBarPage({super.key, required this.logoutCallback});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green.withOpacity(0.5), 
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.edit, size: 24), 
          const Text(
            'Snap Sign',
            style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logoutCallback(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
