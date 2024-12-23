import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:law_assistant/pages/chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(80, 82, 201, 1),
        title: const Text("HomePage",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions:[
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: GestureDetector(
                 onTap: (){
                    FirebaseAuth.instance.signOut();
                 },
                 child: const Icon(Icons.logout,color: Colors.white,)
             ),
           )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return const ChatPage();
        }));
      },
      child: Image.asset("assets/images/bot_icon.png"),
      ),
    );
  }
}
