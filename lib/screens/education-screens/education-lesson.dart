import 'package:blazemobile/functions/dimensions.dart';
import 'package:blazemobile/widgets/chatbot-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../functions/text-to-speech.dart';
import '../../models/user.dart';
import '../chatbot/chatbot-general.dart';


class EducationLesson extends StatefulWidget {
  const EducationLesson({super.key});

  @override
  State<EducationLesson> createState() => _EducationLessonState();
}

final FlutterTts flutterTts = FlutterTts();

class _EducationLessonState extends State<EducationLesson> {


  int? currentWordStart, currentWordEnd;
  int startOffset = 0, endOffset = 0;
  int paragraphIndex = 0;
  String sentence = "";
  bool started = false;


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

  @override
  void initState() {
    super.initState();
    chatbotScreenTitle = educationalContent[currentEducationModule]['full-module-title'];
    chatbotScreenSubTitle = 'Module ${currentEducationModule+1} - ${educationalContent[currentEducationModule]['module-title']}';
    sentence = educationalContent[currentEducationModule]['paragraphs'][paragraphIndex];
    flutterTts.setLanguage("en-US");
    flutterTts.setPitch(1.0);
    flutterTts.setSpeechRate(0.5); // slower speed
    _speak(sentence.substring(currentWordStart ?? 0));
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            child: Container(
              width: screenWidth(context),
              height: screenHeight(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blueAccent.shade700, Colors.indigo.shade900,], // Define your gradient colors
                  stops: [0.1, 8.0], // 70% blue, 30% purple
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,bottom: 20),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () async {
                            if(paragraphIndex == 0){
                              Navigator.pop(context);
                            }
                            else{
                              await flutterTts.stop();
                              setState(() {
                                paragraphIndex--;
                                currentWordStart = 0;
                                currentWordEnd = 0;
                                startOffset = 0;
                                endOffset = 0;
                                started = false;
                                sentence = educationalContent[currentEducationModule]['paragraphs'][paragraphIndex];
                              });
                            }
                          },
                          icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,),
                        ),
                        Image.asset("assets/images/Blaze Colored Combo Cropped.PNG",width: 40,height: 40,color: Colors.white,),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Investing 101",
                        style: GoogleFonts.montserrat(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: screenWidth(context) * 0.9,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            educationalContent[currentEducationModule]['titles'][paragraphIndex],
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // 👇 Make this section scrollable
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: sentence.substring(0, currentWordStart),
                                  ),
                                  if (currentWordStart != null)
                                    TextSpan(
                                      text: sentence.substring(currentWordStart!, currentWordEnd),
                                      style: TextStyle(
                                        color: Colors.white,
                                        backgroundColor: secondaryColor,
                                      ),
                                    ),
                                  if (currentWordEnd != null)
                                    TextSpan(
                                      text: sentence.substring(currentWordEnd!),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40),
                            /*
                            Image.asset(
                              "assets/images/share.png",
                              width: 180,
                              height: 180,
                            ),
                            */
                          ],
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            await flutterTts.stop();
                            setState(() {
                              currentWordStart = 0;
                              currentWordEnd = 0;
                              startOffset = 0;
                              endOffset = 0;
                              started = false;
                            });
                          },
                          child: Center(
                            child: Icon(
                              Icons.keyboard_double_arrow_left_rounded,
                              size: 50,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _speak(sentence.substring(currentWordStart ?? 0)),
                          child: Center(
                            child: Icon(
                              started ? Icons.pause : Icons.play_arrow,
                              size: 50,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Center(
                            child: Icon(
                              Icons.keyboard_double_arrow_right_rounded,
                              size: 50,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        chatbotWidget(context),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: screenWidth(context) * 0.9,
                          height: 50,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              await flutterTts.stop();
                              if(paragraphIndex >= UserModel.userData['modules']['modules-progress']['$currentEducationModule']['progress']){
                                UserModel.userData['modules']['modules-progress']['$currentEducationModule']['progress'] += 1;
                                await UserModel.userRef.update({'modules.modules-progress.$currentEducationModule.progress': UserModel.userData['modules']['modules-progress']['$currentEducationModule']['progress'],});
                              }
                              if(paragraphIndex == educationalContent[currentEducationModule]['paragraphs'].length - 1){
                                started = false;
                                Navigator.pushNamed(context, '/education-questions');
                              }
                              else{
                                setState(() {
                                  paragraphIndex++;
                                  currentWordStart = 0;
                                  currentWordEnd = 0;
                                  startOffset = 0;
                                  endOffset = 0;
                                  sentence = educationalContent[currentEducationModule]['paragraphs'][paragraphIndex];
                                  _speak(sentence.substring(currentWordStart ?? 0));
                                });
                              }
                            },
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
