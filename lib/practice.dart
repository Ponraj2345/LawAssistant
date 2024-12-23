import 'dart:math';

import 'package:flutter/material.dart';
class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  int num=0;
  bool isExp=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  height: 300,
                  color: isExp?Colors.red:Colors.blue,
                  child: GestureDetector(
                    onTap: (){
                       setState(() {
                         isExp=!isExp;
                       });
                    },
                  ),
               ),

            ],
         ),
       ),
    );
  }
}
