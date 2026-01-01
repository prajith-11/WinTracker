import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:flutter_application_1/pages/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}




class LoginPageState extends State<LoginPage> {

final TextEditingController username = TextEditingController();
final TextEditingController password = TextEditingController();
Future<void> verifyLogin() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: username.text,
    password: password.text,
    );
    if(mounted){
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder:  (context) => HomePage())
      );
    }
  }
   catch (e) {
    showDialog(context: context, 
    builder: (context)=> AlertDialog(
      title: Text('Invalid Credentials'),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: Text('OK'))
      ],
    ));
    print("Login Failed");
  }
} 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: username,
            ),
            TextField(
              controller: password,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: ()=> {verifyLogin()},
              child: Text('Login')),
              ElevatedButton(onPressed: ()=> Navigator.push(context,
                MaterialPageRoute(builder: (context)=>SignUpPage())), 
                child: Text('Sign Up')),
          ],
        ),
      ),
    );
  }
}