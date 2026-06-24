import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final signInMethod = user?.providerData.isNotEmpty == true
        ? user!.providerData.first.providerId
        : 'Unknown';

    return Scaffold(body: Center(child: Text(signInMethod)));
  }
}
