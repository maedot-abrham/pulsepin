import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'theme.dart';
import 'auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PulsePinApp());
}

class PulsePinApp extends StatelessWidget {
  const PulsePinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PulsePin',
      theme: PulsePinTheme.dark,
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

