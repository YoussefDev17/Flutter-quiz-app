import 'package:flutter/material.dart';
import 'package:quiz_app/StartScreen.dart';
import 'package:quiz_app/question_Screen.dart';
import 'package:quiz_app/summaryScreen.dart';

enum enAppScreen { start, quiz, summary }

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState.purple();
}

class _QuizState extends State<Quiz> {
  final Color startColor;
  final Color endColor;
  final Alignment startAlignment;
  final Alignment endAlignment;

  // Track which screen to show
  Widget? activeScreen;
  enAppScreen currentScreen = enAppScreen.start;

  List<String> userAnswers = [];

  _QuizState.purple()
    : startColor = const Color.fromARGB(255, 86, 1, 122),
      endColor = const Color.fromARGB(255, 150, 0, 195),
      startAlignment = Alignment.topCenter,
      endAlignment = Alignment.bottomCenter;

  @override
  void initState() {
    super.initState();
    currentScreen = enAppScreen.start;
  }

  void goToTheQuizScreen() {
    setState(() {
      currentScreen = enAppScreen.quiz;
    });
  }

  void restartQuiz() {
    setState(() {
      currentScreen = enAppScreen.start;
    });
  }

  void goToSummaryScreen() {
    setState(() {
      currentScreen = enAppScreen.summary;
    });
  }

  void truckWichScreenToShow() {
    switch (currentScreen) {
      case enAppScreen.start:
        activeScreen = StartScreen(onStartQuiz: goToTheQuizScreen);
        break;
      case enAppScreen.quiz:
        activeScreen = QuestionScreen(
          onBackToTheStartScreen: restartQuiz,
          onGoToSummaryScreen: goToSummaryScreen,
          userAnswers: userAnswers,
        );
        break;
      case enAppScreen.summary:
        activeScreen = SummaryScreen(onBackToRestartTheQuiz: restartQuiz, userAnswers: userAnswers);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    truckWichScreenToShow();

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [startColor, endColor],
              begin: startAlignment,
              end: endAlignment,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
