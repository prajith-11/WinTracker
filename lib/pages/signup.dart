import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage ({super.key});

  @override
  State<SignUpPage > createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage > {
  TextEditingController mail = TextEditingController();
  TextEditingController pwd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: mail,
          ),
          TextField(
            controller: pwd,
            obscureText: true,
          ),
          ElevatedButton(onPressed: ()=> validateCred(), child: Text('Sign Up'))
        ],
      ),
    );
  }
  
  Future<void> validateCred() async {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail.text,
        password: pwd.text,
      );
      if(mounted){
        Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context)=>LoginPage()));
      }
    }
    on FirebaseAuthException catch(e){
      if(e.code=='weak-password') {
        popUp("Password is easy to crack");
      } else if(e.code=='invalid-email') {
        popUp("Are you sure that's your email?");
      } else if(e.code=='email-already-in-use') {
        popUp("Looks like you already have an account");
      }
    }
    catch(e){
      popUp(e.toString());
    }
  }
  
  void popUp(String s) {
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text(s),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: Text("OK"))
      ],
    ));
  }
}