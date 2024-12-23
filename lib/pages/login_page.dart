import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:law_assistant/pages/chat_page.dart';
import 'package:law_assistant/pages/home_page.dart';
import 'package:law_assistant/pages/sign_up.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController= TextEditingController();
  bool isPasswordVisible=true;
  bool isEmailError=false;
  bool isPasswordError=false;
  String errorTextForEmail="";
  String errorTextForPassword="";
  @override
  Widget build(BuildContext context) {
    var enabledBorder=OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(MediaQuery.of(context).size.width*0.1),
        ),
        borderSide: const BorderSide(
            color: Colors.white
        )
    );

    var errorBorder=OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(MediaQuery.of(context).size.width*0.1),
        ),
        borderSide: const BorderSide(
            color: Color.fromRGBO(255,0,0,1),
            width: 1.5
        )
    );
    var focusedBorder=OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(MediaQuery.of(context).size.width*0.1),
        ),
        borderSide: const BorderSide(
            color: Color.fromRGBO(0,0,255,1),
            width: 1.5
        )
    );
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: -MediaQuery.of(context).size.height*0.11,
            left: -MediaQuery.of(context).size.height*0.04,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(101, 102, 206, 0.88),
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
                  color: Color.fromRGBO(101, 102, 206, 0.88),
                  shape: BoxShape.circle
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                  Image.asset("assets/images/img_sign_up_.png"),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: emailController,
                      style: const TextStyle(
                          color: Color.fromRGBO(80, 82, 201, 0.87)
                      ),
                      decoration: InputDecoration(
                          enabledBorder:enabledBorder,
                          focusedBorder: focusedBorder,
                          labelText: "Enter your email",
                          focusedErrorBorder: errorBorder,
                          errorText: isEmailError ? errorTextForEmail : null,
                          errorBorder: isEmailError ? errorBorder : enabledBorder,
                          border: const OutlineInputBorder()
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: isPasswordVisible,
                      style: const TextStyle(
                          color: Color.fromRGBO(80, 82, 201, 0.87)
                      ),
                      decoration: InputDecoration(
                          enabledBorder:enabledBorder,
                          focusedBorder: focusedBorder,
                          labelText: "Password",
                          errorText: isPasswordError ? errorTextForPassword : null,
                          errorBorder: isPasswordError ? errorBorder : enabledBorder,
                          focusedErrorBorder: errorBorder,
                          suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  isPasswordVisible=!isPasswordVisible;
                                });
                              },
                              child: Icon(
                                  isPasswordVisible?Icons.visibility_off:Icons.visibility
                              )
                          ),
                          suffixIconColor: const Color.fromRGBO(80, 82, 201, 0.87),
                          border: const OutlineInputBorder()
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  GestureDetector(
                    onTap: (){

                    },
                    child: const Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: Color.fromRGBO(80, 82, 201, 0.87),
                        ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  GestureDetector(
                    onTap: (){
                      makeUserLogin(emailController.text,passwordController.text);
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
                          "Welcome back",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          "Don't have an account?"
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return const SignUp();
                          }));
                        },
                        child: const Text(
                          "Signup",
                          style: TextStyle(
                            color: Color.fromRGBO(80, 82, 201, 0.87),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future makeUserLogin(String email, String password) async {
    // Reset error states before making login attempt
    setState(() {
      isEmailError = false;
      isPasswordError = false;
      errorTextForEmail = '';
      errorTextForPassword = '';
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      // If login is successful, navigate to HomePage
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    } on FirebaseAuthException catch (e) {
      // Handle specific error codes
      if (e.code == 'invalid-email' || e.code == 'user-not-found') {
        setState(() {
          errorTextForEmail = "Please check your email";
          isEmailError = true;
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          errorTextForPassword = "Please check your password";
          isPasswordError = true;
        });
      }
      else if(e.code=='invalid-credential'){
        setState(() {
          errorTextForPassword = "Please check your credential";
          errorTextForEmail = "Please check your credential";
          isPasswordError = true;
          isEmailError=true;
        });
      }
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
