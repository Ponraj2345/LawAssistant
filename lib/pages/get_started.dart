import 'package:flutter/material.dart';
import 'package:law_assistant/pages/sign_up.dart';
class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
       body: Stack(
         children: [
           Positioned(
             top: -MediaQuery.of(context).size.height*0.11,
             left: -MediaQuery.of(context).size.height*0.04,
             child: Container(
               width: MediaQuery.of(context).size.width * 0.5,
               height: MediaQuery.of(context).size.height * 0.3,
               decoration: const BoxDecoration(
                   color: Color.fromRGBO(80, 82, 201, 0.87),
                   shape: BoxShape.circle
               ),
             ),
           ),
           Positioned(
             left: -MediaQuery.of(context).size.height*0.08,
             top: -MediaQuery.of(context).size.height*0.011,
             child: Container(
               width: MediaQuery.of(context).size.width * 0.4,
               height: MediaQuery.of(context).size.height * 0.3,
               decoration: const BoxDecoration(
                   color: Color.fromRGBO(80, 82, 201, 0.87),
                   shape: BoxShape.circle
               ),
             ),
           ),
           Center(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                   Image.asset("assets/images/img_get_started_welcome.png"),
                   SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                   const Text(
                     "Get the Law.Know Your Rights",
                     style: TextStyle(
                       color: Colors.black,
                       fontWeight: FontWeight.bold,
                       fontSize: 18
                     ),
                   ),
                 SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                 Padding(
                   padding:EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.16),
                   child: const Text(
                     "Welcome, your go-to app for legal queries and information. Whether you're a legal professional, student, or simply seeking advice, we make the law accessible to everyone",
                     style: TextStyle(
                         color: Colors.black,
                         fontSize: 12
                     ),
                   ),
                 ),
                 SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                 Padding(
                   padding: const EdgeInsets.only(left:10.0),
                   child: GestureDetector(
                     onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return const SignUp();
                        }));
                     },
                     child: Container(
                        width: MediaQuery.of(context).size.width*0.8,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: const BoxDecoration(
                           color:Color.fromRGBO(80, 82, 201, 0.87),
                           shape: BoxShape.rectangle,
                        ),
                       child: const Center(
                         child: Text(
                           "Get Started",
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             color: Colors.white,
                             fontSize: 18
                           ),
                         ),
                       ),
                     ),
                   ),
                 )
               ],
             ),
           )
         ],
       ),
    );
  }
}
