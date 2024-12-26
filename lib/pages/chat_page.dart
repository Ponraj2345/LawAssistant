import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:law_assistant/pages/home_page.dart';
import 'package:law_assistant/services/constants.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}
class _ChatPageState extends State<ChatPage> {
  final FlutterTts _flutterTts = FlutterTts();
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController=ScrollController();
  List msgs = ['Hi! Feel free to ask me any query regarding any Legal Consultation'];
  final speechToText = SpeechToText();
  String lastWords = '';
  bool isSendVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 4, right: 4, bottom: 8, top: 4),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(80, 82, 201, 1),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 5),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return const HomePage();
                          }));
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/images/bot_icon.png",
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "ChatBot",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 50.0),
                          child: Text(
                            "Online",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: msgs.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: (msgs[index] == 'Hi! Feel free to ask me any query regarding any Legal Consultation')
                        ? MainAxisAlignment.start // Default message on the left
                        : (index % 2 != 0
                        ? MainAxisAlignment.end // Even-indexed messages on the right
                        : MainAxisAlignment.start), // Odd-indexed messages on the left
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.65,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (index % 2 == 0)
                                    ? const Color.fromRGBO(80, 82, 201, 0.83)
                                    : const Color.fromRGBO(80, 82, 201, 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${msgs[index]}',
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(80, 82, 201, 1),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5,top: 5),
                              child: TextField(
                                controller: messageController,
                                scrollController: scrollController,
                                maxLines: null,
                                expands: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: "Message your Query",
                                  hintStyle: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Visibility(
                              visible: isSendVisible,
                              child: GestureDetector(
                                onTap: () async{
                                  String message=messageController.text;
                                  messageController.clear();
                                  msgs.add(message);
                                  await sendToGPT(message);
                                },
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 23,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromRGBO(80, 82, 201, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () async{
                                // if(await speechToText.hasPermission && speechToText.isNotListening){
                                //   _startListening();
                                // }
                                // else if(await speechToText.isListening){
                                //   _stopListening();
                                // }
                                // else{
                                //   initializeSpeechToText();
                                // }
                                speak(messageController.text);
                              },
                              child: Icon(Icons.speaker))
                          ),
                        )
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> initializeSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> _startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  Future<void> _stopListening() async {
    await speechToText.stop();
    setState(() {
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      messageController.text= result.recognizedWords;
    });
  }

  Future<void> sendToGPT(String prompt) async{
      try{
        final model = GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: API_KEY,
        );
        final checking = await model.generateContent([Content.text("Determine if the following query is related to law, legal information, or legal processes. The query should be processed if it pertains to law, courts, legal rights, acts, contracts, or any similar legal context. If the query is about general topics, greetings, or unrelated subjects like sports, celebrities, or unrelated events, respond with 'No.' Otherwise, respond with 'Yes.' Query: '$prompt")]);
        print(checking.text);
        if(checking.text?.trim().toUpperCase() == 'NO'){
          setState(() {
            msgs.add("Sorry I can't help you with this,is there anything I can assist you with regarding Legal Queries?");
            print(checking.text);
          });
          return;
        }
        final response = await model.generateContent([Content.text("When processing this query, please respond as if you are a knowledgeable legal consultant. Your tone should be professional yet friendly, clear, and conversational. Avoid sounding robotic or overly formal. Provide concise legal advice, helpful suggestions, or actionable steps as appropriate.You should consider this for Indian laws only, Query: '$prompt")]);
        setState(() {
          msgs.add(response.text);
        });
      }
      catch(e){
        print(e.toString());
      }
  }

  Future<void> speak(String text) async {
    await _flutterTts.setLanguage("en-US"); // Set language (e.g., English - US)
    await _flutterTts.setPitch(1.0); // Set pitch (1.0 is normal)
    await _flutterTts.setSpeechRate(0.5); // Set speed of speech (0.5 is normal)
    await _flutterTts.speak(text); // Start speaking
  }

  Future<void> stop() async {
    await _flutterTts.stop(); // Stop speaking
  }
  @override
  void initState() {
    super.initState();
    messageController.addListener(() {
      setState(() {
        isSendVisible = messageController.text.isNotEmpty;
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    });
    initializeSpeechToText();
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
    speechToText.stop();
  }
}
