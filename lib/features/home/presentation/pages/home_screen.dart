import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              ListTile(
                title: Text("Good morning 👋"),
                subtitle: Text(user?.displayName ?? "Guest"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
