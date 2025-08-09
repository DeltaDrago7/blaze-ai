import 'package:animate_do/animate_do.dart';
import 'package:blazemobile/functions/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../functions/text-to-speech.dart';
import '../../services/database.dart';
import '../education-screens/education-lesson.dart';

class ChatbotGeneral extends StatefulWidget {
  const ChatbotGeneral({super.key});

  @override
  State<ChatbotGeneral> createState() => _ChatbotGeneralState();
}

String chatbotScreenTitle = "";
String chatbotScreenSubTitle = "";

class _ChatbotGeneralState extends State<ChatbotGeneral> {


  dynamic defaultQuestions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(educationalChatbot){
      defaultQuestions = educationalContent[currentEducationModule]['paragraph-questions'];
    }
    else{
      defaultQuestions = playlistChatbotDefaultQuestions;
    }
  }


  int? currentWordStart, currentWordEnd;
  int startOffset = 0, endOffset = 0;
  int paragraphIndex = 0;
  String sentence = "";
  bool started = false;
  bool generatingResponse = false;

  void generateResponse(bool defaultQuestion, int questionIndex) async {
    String userPromptText = "";
    if(!defaultQuestion){
      FocusScope.of(context).unfocus();
      userPromptText = userPrompt.text.trim();
    }
    else{
      userPromptText = defaultQuestions[questionIndex];
    }
    currentWordStart = 0;
    currentWordEnd = 0;
    startOffset = 0;
    endOffset = 0;
    await flutterTts.stop();
    setState(() {
      started = false;
      sentence = "";
      generatedPrompt = true;
      generatingResponse = true;
      chat.add(
          {
            'user': 'user',
            'message': userPromptText,
          }
      );
      userPrompt.text = "";
      isListening = false;
    });
    String response = await getChatGPTResponse(userPromptText);
    setState(() {
      chat.add(
          {
            'user': 'chatbot',
            'message': response,
          }
      );
      sentence = response;
      generatingResponse = false;
    });
  }

  Future _speak(String text) async {
    flutterTts.setCompletionHandler(() {
      // Reset state
      setState(() {
        started = false;
        startOffset = 0;
        endOffset = 0;
        currentWordStart = 0;
        currentWordEnd = 0;
      });

      // Speak again from the beginning
      //_speak(text);
    });
    if(!started){
      flutterTts.setProgressHandler((text,start,end,word){
        setState(() {
          currentWordStart = start + startOffset;
          currentWordEnd = getWordEndIndex(sentence, currentWordStart!);
          started = true;
        });
      });
      await flutterTts.speak(text);
    }
    else{
      startOffset = currentWordStart!;
      endOffset = currentWordEnd! < sentence.length?currentWordEnd!:getWordEndIndex(sentence, currentWordStart!);
      setState(() {
        started = false;
      });
      await flutterTts.stop();
    }

  }

  stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;
  double confidence = 1.0;

  void listen() async {
    if(!isListening){
      bool available = await speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available){
        setState(() {
          isListening = true;
        });
        speech.listen(
          onResult: (val) => setState(() {
            userPrompt.text = val.recognizedWords;
            if(val.hasConfidenceRating && val.confidence > 0){
              confidence = val.confidence;
            }
          }),
        );
      }
    }
    else{
      setState(() {
        isListening = false;
      });
      speech.stop();
    }
  }

  Future<String> getChatGPTResponse(String prompt) async {
    if(!Database.fetchedEducationKey){
      print("FETCHING IN GENERAL");
      Database.educationKey = await Database().fetchEducationKey();
    }
    const apiUrl = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Database.educationKey}',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo", // or "gpt-4" if you have access
        "messages": [
          {
            "role": "system",
            "content": "You are a financial assistant, and your goal is to reply to questions in a beginner friendly way. Only answer questions related to stocks, investing, or financial markets. If the question is unrelated, respond with: 'I'm here to help with finance-related topics only.'"
          },
          {"role": "user", "content": prompt}
        ],
        "temperature": 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['choices'][0]['message']['content'].trim();
    } else {
      print('Failed to get response: ${response.body}');
      throw Exception('Failed to get response from ChatGPT');
    }
  }


  TextEditingController userPrompt = TextEditingController();
  Future<void> sendChatRequest(String prompt) async {
    final url = Uri.parse('http://172.20.10.9:8000/api/v1/chat');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'user_id': 'TEST1',
      'message': prompt,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final plainText = response.body; // ✅ works for plain text
        print('Response: $plainText');
      } else {
        print('Error: ${response.statusCode}');
        print('Body: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  List<Map<String,String>> chat = [];
  bool generatedPrompt = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        width: screenWidth(context),
        child: Stack(
          children: [
            // MAIN BODY
            SingleChildScrollView(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Container(
                width: screenWidth(context),
                constraints: BoxConstraints(
                  minHeight: screenHeight(context),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [mainColor, Colors.deepPurple,], // Define your gradient colors
                    stops: [0.4, 6.0], // 70% blue, 30% purple
                  ),
                ),
                child: Column(
                  children: [
                    topBar(),
                    titleWidget(),
                    initialWidget(),
                    fullChatWidget()
                  ],
                ),
              ),
            ),

            // BOTTOM WIDGETS
            educationalChatbot?defaultBottomQuestions():Container(),
            bottomWidget(),
          ],
        ),
      ),
    );
  }

  Widget defaultBottomQuestions(){
    return !generatedPrompt?Container():generatingResponse?Container():Positioned(
      bottom: 100,
      child: FadeInUp(
        duration: Duration(milliseconds: 1000),
        child: Container(
          width: screenWidth(context),
          height: 40,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              itemCount: defaultQuestions.length,
              itemBuilder: (context,index){
                return Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 5,right: 5),
                    margin: EdgeInsets.only(left: index==0?20:0,right: index==defaultQuestions.length-1?20:5),
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: () {
                        generateResponse(true, index);
                      },
                      child: Text(defaultQuestions[index], style: GoogleFonts.montserrat(
                        color: Colors.white,
                      ),),
                    )
                );
              }
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(){
    return Positioned(
      bottom: 0,
      child: Container(
        width: screenWidth(context),
        height: 80,
        padding: EdgeInsets.only(left: 20, top: 10),
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            )
        ),
        child: Stack(
          children: [
            Container(
              width: 270,
              child: TextFormField(
                minLines: 1, // 👈 Minimum height (1 line)
                maxLines: null, // 👈 Allows unlimited lines (will expand)
                keyboardType: TextInputType.multiline, // 👈 Enable multiline keyboard
                style: TextStyle(color: Colors.white), // 👈 This sets the text col
                controller: userPrompt,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Ask anything",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 50,
              child: IconButton(
                onPressed: () async {
                  listen();
                },
                icon: Icon(Icons.mic,color: isListening?Colors.green:Colors.white,),
              ),
            ),
            Positioned(
              right: 10,
              child: IconButton(
                onPressed: () {
                  generateResponse(false,0);
                },
                icon: Icon(Icons.arrow_forward_ios,color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget topBar(){
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Row(
        children: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          ),
          Expanded(child: Container()),
          Image.asset("assets/images/Blaze Colored Combo Cropped.PNG",color: Colors.white,width: 50,height: 50,),
          SizedBox(width: 10,),
        ],
      ),
    );
  }

  Widget titleWidget(){
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(educationalChatbot?chatbotScreenTitle:playlistChatbot?"Playlist Chatbot":"Blaze AI", style: GoogleFonts.montserrat(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),),
          SizedBox(height: 10,),
          educationalChatbot?Text(chatbotScreenSubTitle, style: GoogleFonts.montserrat(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),):Container(),
        ],
      ),
    );
  }

  Widget initialWidget(){
    return generatedPrompt?Container():Container(
      margin: EdgeInsets.only(top: 20),
      height: screenHeight(context) - 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/blazebot.png", width: 100,height: 100,),
          SizedBox(height: 20,),
          Container(
            width:300,
            padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
            child: Text("What can I help you with?", style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),textAlign: TextAlign.center,),
          ),
          Container(
            width: screenWidth(context),
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemCount: defaultQuestions.length,
                itemBuilder: (context,index){
                  return Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 5,right: 5),
                      margin: EdgeInsets.only(left: 5,right: 5,top: 10),
                      decoration: BoxDecoration(
                        color: secondaryColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () {
                          generateResponse(true, index);
                        },
                        child: Text(defaultQuestions[index], style: GoogleFonts.montserrat(
                          color: Colors.white,
                        ),),
                      )
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

  Widget fullChatWidget(){
    return Container(
      child: ListView.builder(
          itemCount: chat.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.only(left: 5,right: 10, bottom: generatingResponse && index == chat.length - 1?100:chat[index]['user'] == 'chatbot' && index == chat.length - 1?100:10),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    chat[index]['user'] == 'chatbot'?FadeInLeft(
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: screenWidth(context) - 40
                        ),
                        padding: EdgeInsets.only(left: 15,right: 0,top: 10,bottom: 10),
                        decoration: BoxDecoration(
                          color: chat[index]['user'] != 'chatbot'?Colors.white:Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: chat[index]['message']! != sentence?RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: chat[index]['message']!,
                              ),
                            ],
                          ),
                        ):RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: chat[index]['message']!.substring(0, currentWordStart),
                              ),
                              if (currentWordStart != null)
                                TextSpan(
                                  text: chat[index]['message']!.substring(currentWordStart!, currentWordEnd),
                                  style: TextStyle(
                                    color: Colors.white,
                                    backgroundColor: secondaryColor,
                                  ),
                                ),
                              if (currentWordEnd != null)
                                TextSpan(
                                  text: chat[index]['message']!.substring(currentWordEnd!),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ):Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxWidth: screenWidth(context) - 40
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                          margin: EdgeInsets.only(bottom: generatingResponse?10:0,),
                          child: Text(chat[index]['message']!, style: TextStyle(
                            color: mainColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),),
                        ),
                      ],
                    ),
                    chat[index]['user'] != 'chatbot' && index == chat.length - 1?Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20,left: 10),
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(color: Colors.white,),
                        ),
                      ],
                    ):Container(width: 0,),
                    chat[index]['user'] == 'chatbot'&& sentence ==chat[index]['message']!?TextButton(
                      onPressed: (){
                        sentence = chat[index]['message']!;
                        _speak(chat[index]['message']!.substring(currentWordStart ?? 0));
                      },
                      child: Container(
                          margin: EdgeInsets.only(bottom: generatingResponse?0:30),
                          child: Icon(started?Icons.pause:Icons.volume_up,color: Colors.white,size: 25,)),
                    ):Container(width: 0,),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

}
