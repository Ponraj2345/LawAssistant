import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:law_assistant/pages/home_page.dart';
import 'package:law_assistant/pages/login_page.dart';
class AuthChange extends StatelessWidget {
  const AuthChange({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snapshot){
       if(snapshot.hasData){
         return const HomePage();
       }
       else{
         return const LoginPage();
       }
    });
  }
}
