import 'package:blazemobile/constants.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';

class DragPayload {
  final String word;
  final int? sourceIndex; // null if from bank, otherwise the gap index
  final bool fromBank;
  const DragPayload({required this.word, this.sourceIndex, required this.fromBank});
}

class GapSentence {
  final String sentence;
  final List<String> missingWords;

  GapSentence(this.sentence, this.missingWords);
}

class FillTheGapQuestion extends StatefulWidget {
  final Map<String, dynamic> question;
  final VoidCallback nextQuestion;
  const FillTheGapQuestion({super.key, required this.question, required this.nextQuestion});

  @override
  State<FillTheGapQuestion> createState() => _FillTheGapQuestionState();
}

class _FillTheGapQuestionState extends State<FillTheGapQuestion> {
  late List<GapSentence> sentences;
  late List<String?> filledWords;
  late List<String> draggableWords;
  late List<bool> locked;
  late List<bool> wrong;

  @override
  void initState() {
    super.initState();
    final emptySentences = widget.question['sentences'];
    final answers = widget.question['answers'];

    sentences = List.generate(
      emptySentences.length,
          (index) => GapSentence(
        emptySentences[index],
        List<String>.from(answers[index]),
      ),
    );

    filledWords = List.filled(widget.question['gaps'], null);
    draggableWords = List<String>.from(widget.question['word-bank'])..shuffle();
    locked = List.filled(filledWords.length, false);
    wrong = List.filled(filledWords.length, false);
  }

  void checkAnswers() {
    setState(() {
      int wordIndex = 0;
      for (final sentence in sentences) {
        for (int i = 0; i < sentence.missingWords.length; i++) {
          final correctWord = sentence.missingWords[i];
          final userWord = filledWords[wordIndex];

          if (userWord == null) {
            wrong[wordIndex] = false; // empty, not wrong
          } else if (userWord == correctWord) {
            locked[wordIndex] = true; // ✅ correct → lock
            wrong[wordIndex] = false;
          } else {
            wrong[wordIndex] = true; // ❌ incorrect
          }

          wordIndex++;
        }
      }
    });
  }

  List<InlineSpan> buildSentence(
      GapSentence gap,
      List<String?> localFilled, // still useful for building text
      int globalStart,           // NEW: where this sentence's gaps start in the global list
      ) {
    final parts = gap.sentence.split("____");
    List<InlineSpan> spans = [];

    for (var i = 0; i < parts.length; i++) {
      spans.add(TextSpan(text: parts[i]));

      if (i < gap.missingWords.length) {
        final globalIndex = globalStart + i; // map local -> global

        spans.add(
          WidgetSpan(
            child: DragTarget<DragPayload>(
              onWillAccept: (p) => !locked[globalIndex], // don't accept if locked
              onAccept: (p) {
                setState(() {
                  if (locked[globalIndex]) return;

                  if (p.fromBank) {
                    // From bank -> to this gap
                    if (filledWords[globalIndex] != null) {
                      // replace: return previous to bank
                      draggableWords.add(filledWords[globalIndex]!);
                    }
                    filledWords[globalIndex] = p.word;
                    draggableWords.remove(p.word); // remove from bank
                  } else {
                    // From another gap -> move or swap
                    final src = p.sourceIndex!;
                    if (src == globalIndex) return; // same slot, nothing to do

                    if (filledWords[globalIndex] == null) {
                      // move
                      filledWords[globalIndex] = p.word;
                      filledWords[src] = null;

                      // reset wrong on both
                      wrong[globalIndex] = false;
                      wrong[src] = false;
                    } else {
                      // swap
                      final tmp = filledWords[globalIndex]!;
                      filledWords[globalIndex] = p.word;
                      filledWords[src] = tmp;

                      // reset wrong on both
                      wrong[globalIndex] = false;
                      wrong[src] = false;
                    }
                  }

                  // always reset target
                  wrong[globalIndex] = false;
                });

              },
              builder: (context, candidate, rejected) {
                if (locked[globalIndex]) {
                  return Container(
                      width: 120, height: 32, alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 8, right: 4, left: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: borderRadius/2,
                      ),
                      child: Text(filledWords[globalIndex]!, style: Theme.of(context).textTheme.bodyMedium)
                  );
                }

                final current = filledWords[globalIndex];

                if (current != null) {
                  // Make the filled word draggable again
                  return Draggable<DragPayload>(
                    data: DragPayload(word: current, sourceIndex: globalIndex, fromBank: false),
                    feedback: Material(
                      color: Colors.transparent,
                      child: Container(
                        height: 40, alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 8, right: 4, left: 4),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: borderRadius,
                        ),
                        child: Text(current, style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ),
                    child: Container(
                      width: 120, height: 32, alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 8, right: 4, left: 4),
                      decoration: BoxDecoration(
                        color: wrong[globalIndex] ? Colors.red : Colors.white,
                        borderRadius: borderRadius/2,
                      ),
                      child: Text(current, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: wrong[globalIndex] ? Colors.white : Colors.black
                      )),
                    ),
                  );
                }

                // Empty gap
                return Container(
                  width: 120, height: 32, alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 8, right: 4, left: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius/2,
                  ),
                  child: Text("____", style: TextStyle(fontWeight: FontWeight.bold)),
                );
              },
            ),
          ),
        );
      }
    }

    return spans;
  }


  Widget buildDraggableWord(String word) {
    final wordWidget = Text(word, style: Theme.of(context).textTheme.bodyMedium);
    return Draggable<DragPayload>(
      data: DragPayload(word: word, fromBank: true),
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: borderRadius,
          ),
          child: wordWidget,
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.4,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: borderRadius,
          ),
          child: wordWidget,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: borderRadius,
        ),
        child: wordWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: sentences.length,
                      itemBuilder: (context, index) {
                        final gap = sentences[index];

                        final startIndex = index == 0
                            ? 0
                            : sentences
                            .take(index)
                            .expand((s) => s.missingWords)
                            .length;

                        final endIndex = sentences
                            .take(index + 1)
                            .expand((s) => s.missingWords)
                            .length;

                        final spans = buildSentence(
                          gap,
                          filledWords.sublist(startIndex, endIndex),
                          startIndex, // 👈 NEW
                        );

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: smallGap),
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: spans,
                            ),
                          ),
                        );
                      }

                  ),
                ),
                SizedBox(height: xlargeGap,),
                Wrap(
                  spacing: smallGap,
                  runSpacing: smallGap,
                  children: draggableWords.map(buildDraggableWord).toList(),
                ),
              ],
            )
        ),
        SizedBox(height: xlargeGap,),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: !filledWords.every((word) => word != null) ? null
            : locked.every((isLocked) => isLocked) ? widget.nextQuestion : checkAnswers,
            style: FilledButton.styleFrom(
              backgroundColor: locked.every((isLocked) => isLocked) ? Colors.white : mainColor,
              foregroundColor: locked.every((isLocked) => isLocked) ? Colors.black : Colors.white,
            ),
            child: Text(
                locked.every((isLocked) => isLocked) ? "Continue" : "Check Answers",
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}
