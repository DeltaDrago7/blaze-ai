import 'package:blazemobile/constants.dart';
import 'package:blazemobile/functions/dimensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import '../../models/user.dart';
import '../../widgets/chatbot-widget.dart';


class EducationQuestions extends StatefulWidget {
  const EducationQuestions({super.key});

  @override
  State<EducationQuestions> createState() => _EducationQuestionsState();
}

class _EducationQuestionsState extends State<EducationQuestions> {

  // Progress
  int questionsCorrect = 0;

  // Current question
  int questionIndex = 0;

  // Multiple choice questions
  int selectedAnswer = -1;
  bool confirmedAnswer = false;
  bool correctAnswer = false;
  List<bool> optionValues = [];

  // True of false questions
  List<int> selectedAnswers = [];
  bool selectedInitialOption = false;
  List<int> correctAnswersEntered = [];
  List<int> incorrectAnswersEntered = [];
  List<int> correctAnswersMissed = [];
  bool confirmedTrueFalseAnswer = false;
  bool correctTrueFalseAnswer = false;

  // Drag and drop questions
  String selectedKey = "";
  int selectedKeyIndex = 0;
  String selectedValue = "";
  bool fullCorrectAnswer = false;
  bool incorrectAnswer = false;
  List<String> scrambledItems = [];
  List<String> pairValues = [];
  List<Map<String,String>> validPairs = [];
  List<Map<String,String>> invalidPairs = [];

  bool keyExistsInValidPairs(dynamic key){
    int pairIndex = 0;
    while(pairIndex < validPairs.length){
      print(validPairs[pairIndex]["keys"]);
      if(validPairs[pairIndex]["keys"] == key){
        return true;
      }
      pairIndex++;
    }
    return false;
  }

  bool valueExistsInValidPairs(dynamic value){
    int pairIndex = 0;
    while(pairIndex < validPairs.length){
      print(validPairs[pairIndex]["values"]);
      if(validPairs[pairIndex]["values"] == value){
        return true;
      }
      pairIndex++;
    }
    return false;
  }



  // Fill the gap questions
  String currentSentence = "";
  List<String> splitSentence = [];
  String selectedWord = "";
  bool wordSelected = false;
  bool gapAnswerConfirmed = false;
  bool correctGapAnswer = false;

  Widget multipleChoiceQuestion(){
    return Container(
      height: screenHeight(context) - 90,
      child: Column(
        children: [
          SizedBox(height: 10,), //Question
          Text(educationalContent[currentEducationModule]['questions'][questionIndex]['question'], style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),),
          Container(
            //color: Colors.red,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: educationalContent[currentEducationModule]['questions'][questionIndex]['options'].length,
              itemBuilder: (context,index){
                return Container(
                    width: screenWidth(context),
                    height: 80,
                    margin: EdgeInsets.only(bottom: index == educationalContent[currentEducationModule]['questions'][questionIndex]['options'].length - 1?0:10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: confirmedAnswer && !correctAnswer && index == educationalContent[currentEducationModule]['questions'][questionIndex]['answer']?Colors.green:confirmedAnswer && !correctAnswer && optionValues[index]?Colors.red:confirmedAnswer && correctAnswer && optionValues[index]?Colors.green:optionValues[index]?secondaryColor:Colors.indigoAccent.shade700,
                    ),
                    child: TextButton(
                      onPressed: (){
                        if(!confirmedAnswer){
                          setState(() {
                            optionValues[index] = true;
                            selectedAnswer = index;
                            int idx = 0;
                            while(idx < optionValues.length){
                              if(idx != index){
                                optionValues[idx] = false;
                              }
                              idx++;
                            }
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white,),
                            ),
                            child: confirmedAnswer && !correctAnswer && index == educationalContent[currentEducationModule]['questions'][questionIndex]['answer']?Icon(Icons.check, color: Colors.white,size: 20,):confirmedAnswer && !correctAnswer && optionValues[index]?Icon(Icons.close,color: Colors.white,):confirmedAnswer && correctAnswer && optionValues[index]?Icon(Icons.check, color: Colors.white,size: 20,):Container(),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            width: screenWidth(context) * 0.7,
                            child: Text(educationalContent[currentEducationModule]['questions'][questionIndex]['options'][index], style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),),
                          ),
                        ],
                      ),
                    )
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              chatbotWidget(context),
            ],
          ),
          Expanded(child: Container()),
          confirmedAnswer?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Explanation", style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),),
              SizedBox(height: 5,),
              Text("${educationalContent[currentEducationModule]['questions'][questionIndex]['explanation']}", style: GoogleFonts.montserrat(
                fontSize: 14,
                color: Colors.white,
              ),),
              SizedBox(height: 10,),
            ],
          ):Container(),
          Container(
            width: screenWidth(context),
            height: buttonHeight,
            decoration: BoxDecoration(
              color: confirmedAnswer?secondaryColor:optionSelected()?Colors.white:secondaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextButton(
                onPressed: (){
                  if(selectedAnswer != -1){
                    print("NEGATIVE");
                    if(confirmedAnswer){
                      getNextQuestion();
                    }
                    else{
                      setState(() {
                        confirmedAnswer = true;
                        if(selectedAnswer == educationalContent[currentEducationModule]['questions'][questionIndex]['answer']){
                          correctAnswer = true;
                        }
                        else{
                          correctAnswer = false;
                        }
                      });
                    }
                  }
                  else{
      
                  }
                },
                child: Text(confirmedAnswer?"Continue":"Confirm", style: TextStyle(
                  color: confirmedAnswer?Colors.white:optionSelected()?Colors.black:Colors.white,
                  fontWeight: FontWeight.bold,
                ),)
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget dragAndDropQuestion(){
    return Container(
      height: screenHeight(context) * 0.85,
      child: Column(
        children: [
          SizedBox(height: 20,),
          //Prompt
          Text(educationalContent[currentEducationModule]['questions'][questionIndex]['prompt'], style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),),
          SizedBox(height: 40,),
          Row(
            children: [
              Container(
                height: screenHeight(context) * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      educationalContent[currentEducationModule]['questions'][questionIndex]['pairs-keys'].length,
                          (index) {
                        return Container(
                          width: 140,
                          margin: EdgeInsets.only(bottom: 20), // You may need to remove this if using spaceBetween
                          decoration: BoxDecoration(
                            color: validIndex(index, "keys")
                                ? Colors.green
                                : invalidIndex(index, "keys")
                                ? Colors.red
                                : selectedKey == educationalContent[currentEducationModule]['questions'][questionIndex]['pairs-keys'][index]
                                ? secondaryColor
                                : Colors.indigoAccent.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (!incorrectAnswer &&
                                  !keyExistsInValidPairs(educationalContent[currentEducationModule]['questions'][questionIndex]['pairs-keys'][index])) {
                                setState(() {
                                  if (selectedValue != "") {
                                    if (educationalContent[currentEducationModule]['questions'][questionIndex]['pairs-keys'][selectedKeyIndex] ==
                                        educationalContent[currentEducationModule]['questions'][questionIndex]['pairs-keys'][index]) {
                                      validPairs.add({
                                        "keys": educationalContent[currentEducationModule]['questions'][questionIndex]['pairs-keys'][index],
                                        "values": selectedValue,
                                      });
                                      if (validPairs.length == educationalContent[currentEducationModule]['questions'][questionIndex]['pairs-values'].length) {
                                        fullCorrectAnswer = true;
                                      }
                                    } else {
                                      invalidPairs.add({
                                        "keys": educationalContent[currentEducationModule]['questions'][questionIndex]['pairs-keys'][index],
                                        "values": selectedValue,
                                      });
                                      incorrectAnswer = true;
                                    }
                                    selectedKey = "";
                                    selectedValue = "";
                                  } else {
                                    selectedKeyIndex = index;
                                    if (selectedKey == educationalContent[currentEducationModule]['questions'][questionIndex]['pairs-keys'][index]) {
                                      selectedKey = "";
                                    } else {
                                      selectedKey = educationalContent[currentEducationModule]['questions'][questionIndex]['pairs-keys'][index];
                                    }
                                  }
                                });
                              }
                            },
                            child: Text(
                              educationalContent[currentEducationModule]['questions'][questionIndex]['pairs-keys'][index],
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ),
              Expanded(child: Container(),),
              Container(
                height: screenHeight(context) * 0.5,
                width: screenWidth(context) * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    pairValues.length,
                        (index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: validIndex(index, "values")
                              ? Colors.green
                              : invalidIndex(index, "values")
                              ? Colors.red
                              : selectedValue == scrambledItems[index]
                              ? secondaryColor
                              : Colors.indigoAccent.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (!incorrectAnswer && !valueExistsInValidPairs(scrambledItems[index])) {
                                if (selectedKey != "") {
                                  selectedValue = scrambledItems[index];
                                  print("QUESTIONS: ${pairValues}");
                                  print(selectedValue);
                                  print(pairValues[selectedKeyIndex]);
                                  if (pairValues[selectedKeyIndex] == selectedValue) {
                                    print("VALID PAIR");
                                    validPairs.add({
                                      "keys": selectedKey,
                                      "values": selectedValue,
                                    });
                                    if (validPairs.length == pairValues.length) {
                                      fullCorrectAnswer = true;
                                    }
                                  } else {
                                    invalidPairs.add({
                                      "keys": selectedKey,
                                      "values": selectedValue,
                                    });
                                    incorrectAnswer = true;
                                  }
                                  selectedKey = "";
                                  selectedValue = "";
                                } else {
                                  if (selectedValue == scrambledItems[index]) {
                                    selectedValue = "";
                                  } else {
                                    selectedValue = scrambledItems[index];
                                    int idx = 0;
                                    while(idx < pairValues.length){
                                      if(pairValues[idx] == selectedValue){
                                        selectedKeyIndex = idx;
                                        break;
                                      }
                                      idx++;
                                    }
                                  }
                                }
                              }
                            });
                          },
                          child: Container(
                            width: 150,
                            child: Text(
                              scrambledItems[index],
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              chatbotWidget(context),
            ],
          ),
          Expanded(child: Container()),
          Container(
            width: screenWidth(context),
            height: buttonHeight,
            decoration: BoxDecoration(
              color: incorrectAnswer?Colors.blueGrey:fullCorrectAnswer?Colors.white:secondaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextButton(
                onPressed: (){
                  if(incorrectAnswer){
                    setState(() {
                      correctAnswer = false;
                      incorrectAnswer = false;
                      validPairs = [];
                      invalidPairs = [];
                      selectedKey = "";
                      selectedValue = "";
                      selectedKeyIndex = -1;
                    });
                  }
                  else if(fullCorrectAnswer){
                    getNextQuestion();
                  }
                },
                child: Text(incorrectAnswer?"Try again":"Continue", style: TextStyle(
                  color: fullCorrectAnswer?Colors.black:Colors.white,
                  fontWeight: FontWeight.bold,
                ),)
            ),
          ),
          //SizedBox(height: 30,),
        ],
      ),
    );
  }

  Widget fillTheGapQuestion(){
    return Container(
      height: screenHeight(context) - AppBar().preferredSize.height - 40,
      child: Column(
        children: [
          SizedBox(height: 20,),
          //Prompt
          Text(educationalContent[currentEducationModule]['questions'][questionIndex]['prompt'], style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),),
          SizedBox(height: 30,),
          Text.rich(
            TextSpan(
              children: splitSentence.map((word) {
                bool isMatch = word == selectedWord;
                return TextSpan(
                  text: '$word ',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: isMatch && gapAnswerConfirmed && !correctGapAnswer?Colors.red:isMatch && gapAnswerConfirmed && correctGapAnswer?Colors.greenAccent:isMatch ? Colors.yellow : Colors.white,
                    fontWeight: isMatch ? FontWeight.bold : FontWeight.w500,
                  ),
                );
              }).toList(),
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 30,),
          Container(
            width: screenWidth(context),
            child: Wrap(
              children: (educationalContent[currentEducationModule]['questions'][questionIndex]["word-bank"] as List<dynamic>).map<Widget>((word){
                return Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 5,right: 5, bottom: 10),
                  decoration: BoxDecoration(
                    color: (selectedWord == word && correctGapAnswer && gapAnswerConfirmed) || (word == educationalContent[currentEducationModule]['questions'][questionIndex]['answer'] && gapAnswerConfirmed)?Colors.green:selectedWord == word && gapAnswerConfirmed && !correctGapAnswer?Colors.red:selectedWord == word?secondaryColor:Colors.indigoAccent.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                      onPressed: (){
                        if(!gapAnswerConfirmed){
                          print("NOT CONFIRMED");
                          setState(() {
                            currentSentence = fillBlank(educationalContent[currentEducationModule]['questions'][questionIndex]['sentence'], word);
                          });
                        }
                      },
                      child: Text(word, style: TextStyle(
                        color: selectedWord == word?Colors.white:(selectedWord == word && correctGapAnswer && gapAnswerConfirmed) || (word == educationalContent[currentEducationModule]['questions'][questionIndex]['answer'] && gapAnswerConfirmed) || selectedWord == word && gapAnswerConfirmed && !correctGapAnswer?Colors.white:Colors.white,
                      ),)
                  ),
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              chatbotWidget(context),
            ],
          ),
          Expanded(child: Container()),
          !gapAnswerConfirmed?Container():correctGapAnswer?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 45,),
                  SizedBox(width: 10,),
                  Text("Correct", style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(educationalContent[currentEducationModule]['questions'][questionIndex]["explanation"],style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),),
              ),
              SizedBox(height: 20,),
            ],
          ):Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.close_rounded, color: Colors.red, size: 45,),
                  SizedBox(width: 10,),
                  Text("Wrong", style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(educationalContent[currentEducationModule]['questions'][questionIndex]["explanation"],style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),),
              ),
              SizedBox(height: 20,),
            ],
          ),
          Container(
            width: screenWidth(context),
            height: buttonHeight,
            decoration: BoxDecoration(
              color: !wordSelected?secondaryColor:gapAnswerConfirmed?secondaryColor:Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextButton(
                onPressed: (){
                  setState(() {
                    if(!gapAnswerConfirmed){
                      if(selectedWord != ""){
                        if(selectedWord == educationalContent[currentEducationModule]['questions'][questionIndex]["answer"]){
                          correctGapAnswer = true;
                        }
                        else{
                          correctGapAnswer = false;
                        }
                        gapAnswerConfirmed = true;
                      }
                    }
                    else{
                      getNextQuestion();
                    }
                  });
                },
                child: Text(gapAnswerConfirmed?"Continue":"Confirm", style: TextStyle(
                  color: gapAnswerConfirmed?Colors.white:wordSelected?Colors.black:Colors.white,
                ),)
            ),
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }

  Widget trueOrFalseQuestion(){
    return Container(
      width: screenWidth(context),
      height: screenHeight(context) - AppBar().preferredSize.height - 40,
      child: Column(
        children: [
          SizedBox(height: 20,),
          //Question
          Text(educationalContent[currentEducationModule]['questions'][questionIndex]['prompt'], style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),),
          SizedBox(height: 30,),
          Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: educationalContent[currentEducationModule]['questions'][questionIndex]['options'].length,
              itemBuilder: (context,index){
                return Container(
                    width: screenWidth(context),
                    height: 80,
                    margin: EdgeInsets.only(bottom: index ==educationalContent[currentEducationModule]['questions'][questionIndex]['options'].length - 1?0:20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // secondaryColor:Colors.indigoAccent.shade700
                      // correctAnswersEntered.contains(index)?Colors.green:correctAnswersMissed.contains(index)?Colors.transparent:incorrectAnswersEntered.contains(index)?Colors.red:selectedAnswers.contains(index)?secondaryColor:Colors.transparent
                      color: correctAnswersEntered.contains(index)?Colors.green:correctAnswersMissed.contains(index)?Colors.blueGrey.withOpacity(0.5):incorrectAnswersEntered.contains(index)?Colors.red:selectedAnswers.contains(index)?secondaryColor:Colors.indigoAccent.shade700,
                    ),
                    child: TextButton(
                      onPressed: (){
                        if(!confirmedTrueFalseAnswer){
                          setState(() {
                            selectedInitialOption = true;
                            optionValues[index] = !optionValues[index];
                            if(optionValues[index]){
                              selectedAnswers.add(index);
                            }
                            else{
                              selectedAnswers.remove(index);
                            }
                          });
                          print(selectedAnswers);
                        }
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              //color: correctAnswersEntered.contains(index)?Colors.green:correctAnswersMissed.contains(index)?Colors.transparent:incorrectAnswersEntered.contains(index)?Colors.red:selectedAnswers.contains(index)?mainColor:Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white),
                              //border: Border.all(color: correctAnswersEntered.contains(index)?Colors.green:correctAnswersMissed.contains(index)?Colors.green:incorrectAnswersEntered.contains(index)?Colors.red:selectedAnswers.contains(index)?mainColor:Colors.white,),
                            ),
                            child: correctAnswersEntered.contains(index)?Icon(Icons.check, color: Colors.white,size: 20,):correctAnswersMissed.contains(index)?Icon(Icons.check, color: Colors.white,size: 20,):incorrectAnswersEntered.contains(index)?Icon(Icons.close,color: Colors.white,):Container(),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            width: screenWidth(context) * 0.7,
                            child: Text(educationalContent[currentEducationModule]['questions'][questionIndex]['options'][index], style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),),
                          ),
                        ],
                      ),
                    )
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              chatbotWidget(context),
            ],
          ),
          Expanded(child: Container()),
          Container(
            width: screenWidth(context),
            height: buttonHeight,
            decoration: BoxDecoration(
              color: confirmedTrueFalseAnswer?Colors.white:selectedInitialOption?Colors.white:secondaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextButton(
                onPressed: (){
                  if(!confirmedTrueFalseAnswer){
                    setState(() {
                      confirmedTrueFalseAnswer = true;
                      correctTrueFalseAnswer = true;
                      int optionIndex = 0;

                      // For each option, i need to check if the option has been selected
                      while(optionIndex < educationalContent[currentEducationModule]['questions'][questionIndex]["options"].length){
                        // If the option has been selected
                        if(selectedAnswers.contains(optionIndex)){
                          // Check if the option is in the answers list
                          if(educationalContent[currentEducationModule]['questions'][questionIndex]["answer"].contains(optionIndex)){
                            // If so, add it to the correctlySelectedAnswers list
                            correctAnswersEntered.add(optionIndex);
                          }
                          else{
                            // Else, add it to the incorrectlySelectedAnswers list
                            incorrectAnswersEntered.add(optionIndex);
                          }
                        }
                        // If the option has not been selected
                        else{
                          // Check if the option is in the answers list
                          if(educationalContent[currentEducationModule]['questions'][questionIndex]["answer"].contains(optionIndex)){
                            // If so, add it to the missedAnswers list
                            correctAnswersMissed.add(optionIndex);
                          }
                        }
                        optionIndex++;
                      }
                    });
                  }
                  else{
                    getNextQuestion();
                  }
                },
                child: Text(confirmedTrueFalseAnswer?"Continue":"Confirm", style: TextStyle(
                  color:confirmedTrueFalseAnswer || selectedInitialOption?Colors.black:Colors.white,
                  fontWeight: FontWeight.bold,
                ),)
            ),
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }

  void resetFillSentenceVars(){
    currentSentence = educationalContent[currentEducationModule]['questions'][questionIndex]['sentence'];
    splitSentence = currentSentence.split(' ');
    correctGapAnswer = false;
    gapAnswerConfirmed = false;
    wordSelected = false;
    selectedWord = "";
  }

  void resetTrueOrFalseVars(){
    selectedAnswers = [];
    correctAnswersEntered = [];
    correctAnswersMissed = [];
    incorrectAnswersEntered = [];
    confirmedTrueFalseAnswer = false;
    correctTrueFalseAnswer = false;
    optionValues = List.generate(educationalContent[currentEducationModule]["questions"][questionIndex]['options'].length, (index) => false);
  }

  void resetDragAndDropVars(){
    correctAnswer = false;
    incorrectAnswer = false;
    validPairs = [];
    invalidPairs = [];
    selectedKey = "";
    selectedValue = "";
    selectedKeyIndex = -1;
    pairValues = educationalContent[currentEducationModule]['questions'][questionIndex]['pairs-values'];
    scrambledItems = List<String>.from(educationalContent[currentEducationModule]['questions'][questionIndex]['pairs-values']);
    scrambledItems.shuffle(Random());
    print("pairValues: $pairValues");
    print("scrambledItems: $scrambledItems");
  }

  void resetMultipleChoiceVars(){
    selectedAnswer = -1;
    confirmedAnswer = false;
    correctAnswer = false;
    optionValues = List.generate(educationalContent[currentEducationModule]["questions"][questionIndex]['options'].length, (index) => false);
  }

  // Get next question
  void getNextQuestion() async {
    setState(() {
      questionIndex++;
    });
    // If all the questions are done, go to the module complete page
    if(questionIndex == educationalContent[currentEducationModule]["questions-length"]){
      questionIndex--;
      await UserModel.userRef.update({
        'modules.completed-modules': FieldValue.arrayUnion([currentEducationModule]),
      });
      await UserModel.userRef.update({'modules.current-module': currentEducationModule + 1,});
      UserModel.userData['modules']['current-module'] += 1;
      UserModel.userData['modules']['completed-modules'].add(currentEducationModule);
      Navigator.pushNamed(context, "/education-module-complete");
    }
    else{
      if(educationalContent[currentEducationModule]['paragraphs-length'] + questionIndex+1 > UserModel.userData['modules']['modules-progress']['$currentEducationModule']['progress']){
        print("HERERERERERERERERERE");
        UserModel.userData['modules']['modules-progress']['$currentEducationModule']['progress'] += 1;
        await UserModel.userRef.update({'modules.modules-progress.$currentEducationModule.progress': UserModel.userData['modules']['modules-progress']['$currentEducationModule']['progress'],});
      }
      setState(() {
        if(educationalContent[currentEducationModule]['questions'][questionIndex]['type'] =='fill-sentence-gaps'){
          resetFillSentenceVars();
        }
        else if(educationalContent[currentEducationModule]['questions'][questionIndex]['type'] =='true-or-false'){
          resetTrueOrFalseVars();
        }
        else if(educationalContent[currentEducationModule]['questions'][questionIndex]['type'] =='drag-and-drop'){
          resetDragAndDropVars();
        }
        else{
          resetMultipleChoiceVars();
        }
      });
    }
  }

  String fillBlank(String sentence, String word) {
    selectedWord = word;
    wordSelected = true;
    List<String> words = sentence.split(' ');
    int i = 0;
    while(i < words.length){
      if(words[i] == "________" || words[i] == "________."){
        words[i] = word;
      }
      i++;
    }
    splitSentence = words;
    return words.join(' ');
  }

  bool validIndex(int index, String type){
    if(type == "values"){
      int idx = 0;
      while(idx < validPairs.length){
        if(validPairs[idx][type] == scrambledItems[index]){
          return true;
        }
        idx++;
      }
    }
    else{
      int idx = 0;
      while(idx < validPairs.length){
        if(validPairs[idx][type] == educationalContent[currentEducationModule]["questions"][questionIndex]["pairs-$type"][index]){
          return true;
        }
        idx++;
      }
    }
    return false;
  }

  bool invalidIndex(int index, String type){
    if(type == "values"){
      int idx = 0;
      while(idx < invalidPairs.length){
        if(invalidPairs[idx][type] == scrambledItems[index]){
          return true;
        }
        idx++;
      }
    }
    else{
      int idx = 0;
      while(idx < invalidPairs.length){
        if(invalidPairs[idx][type] == educationalContent[currentEducationModule]["questions"][questionIndex]["pairs-$type"][index]){
          return true;
        }
        idx++;
      }
    }

    return false;
  }

  bool optionSelected(){
    int idx = 0;
    while(idx < optionValues.length){
      if(optionValues[idx]){
        return true;
      }
      idx++;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    if(educationalContent[currentEducationModule]["questions"][0]['type'] == 'multiple-choice' || educationalContent[currentEducationModule]['questions'][questionIndex]['type'] =='true-or-false'){
      optionValues = List.generate(educationalContent[currentEducationModule]["questions"][0]['options'].length, (index) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /*
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,),
                  ),
                  */
                  Image.asset("assets/images/Blaze Colored Combo Cropped.PNG",width: 40,height: 40,color: Colors.white,),
                ],
              ),
              SizedBox(height: 10),
              educationalContent[currentEducationModule]['questions'][questionIndex]['type'] =='true-or-false'?trueOrFalseQuestion():
              educationalContent[currentEducationModule]['questions'][questionIndex]['type'] =='fill-sentence-gaps'?fillTheGapQuestion():
              educationalContent[currentEducationModule]['questions'][questionIndex]['type'] =='drag-and-drop'? dragAndDropQuestion():multipleChoiceQuestion(),
            ],
          ),
        ),
      ),
    );
  }
}
