import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'firebase_options.dart';

// Future = waiting for something that will be arrived in the future
// async = function that makes the program wait for something to finish
// await = tells the program to wait for something to finish before going to the next line
Future<void> main() async {
  // This line is mandatory for Firebase to work
  WidgetsFlutterBinding.ensureInitialized();

  // This starts the connection to your specific project
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  // Starting the UI
  runApp(const MyApp());
}

final TextEditingController input = TextEditingController();

//This is a userdefined function, async denotes that the database operation
// will take some time

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // 1. If Firebase is still checking the token, show a loading spinner
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // 2. If snapshot has data, a user is already logged in!
          if (snapshot.hasData) {
            return const HomePage();
          }

          // 3. Otherwise, nobody is logged in, show the login page
          return const LoginPage();
        },
      ),
    );
  }
}