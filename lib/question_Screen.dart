import 'package:flutter/material.dart';
import 'package:quiz_app/myCustomOutlineButton.dart';

class QuestionScreen extends StatefulWidget {
  final VoidCallback onBackToTheStartScreen;
  const QuestionScreen({super.key, required this.onBackToTheStartScreen});
  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // List of questions with answers and correct answer
  final List<Question> questions = [
    Question('What is Flutter?', ['SDK', 'Game', 'Language', 'IDE'], 'SDK'),
    Question('What is Dart?', ['Language', 'Bird', 'IDE', 'Company'], 'Language'),
    Question('Who developed Flutter?', ['Apple', 'Facebook', 'Microsoft', 'Google'], 'Google'),
    Question('What widget is used for layout in Flutter?', [
      'Text',
      'Scaffold',
      'Column',
      'MaterialApp',
    ], 'Column'),
    Question('Which command is used to create a new Flutter project?', [
      'flutter new project',
      'flutter create myapp',
      'flutter start',
      'flutter init',
    ], 'flutter new project'),
  ];

  bool IsTheSelectedAnswerChecked = false;

  Widget validateUserAnswer() {
    // Check The User Not Selected Any Answer
    if (selectedAnswer == null) {
      return const SizedBox(
        width: 25,
      ); // Same width as the Next And Check button to keep layout aligned
    }
    // Check If The User Answer Cheked To Show Them Next Button
    if (IsTheSelectedAnswerChecked) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(25, 18),
          shape: const StadiumBorder(), // Oval/pill shape
          backgroundColor: Colors.deepPurple.shade700,
        ),
        onPressed: increaseQuestionIndexAndClearSelectedAnswer,
        child: const Text("Next", style: TextStyle(color: Colors.white)),
      );
    }

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(25, 18),
        shape: const StadiumBorder(), // Oval/pill shape
        backgroundColor: Colors.deepPurple.shade700,
      ),
      onPressed: checkSelectedAnswerIsCorrect,
      child: const Text("Check", style: TextStyle(color: Colors.white)),
    );
  }

  int currentQuestionIndex = 0;

  String? selectedAnswer;

  bool? isSelectedAnswerCorrect;

  Widget buildAnswerButton(String answer, bool? answerStatus) {
    return Column(
      children: [
        AnswerButton(
          key: ValueKey(answer),
          text: answer,
          isPressed: answer == selectedAnswer,
          onTap: () => onAnswerSelected(answer),
          ButtonState: answerStatus, // can be null, true, or false
          isDisabled: IsTheSelectedAnswerChecked, // Disable if an answer is selected
        ),

        const SizedBox(height: 2),
      ],
    );
  }

  bool? getAnswerButtonState(String answer) {
    if (isSelectedAnswerCorrect == false) {
      if (answer == questions[currentQuestionIndex].correctAnswer) {
        return true; // Correct answer
      } else if (selectedAnswer == answer) {
        return false; // Incorrect answer
      } else {
        return null; // Not selected The User Not Chose Yet An Answer
      }
    } else if (selectedAnswer == answer) {
      return isSelectedAnswerCorrect;
    }
    return null; //Not Selected The User Not Chose Yet An Answer
  }

  Widget buildNavigationButtons() {
    return SizedBox(
      width: 300, // Match the width of your myCustomButton
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          currentQuestionIndex != 0
              ? OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(25, 18),
                  shape: const StadiumBorder(), // Oval/pill shape
                  backgroundColor: Colors.deepPurple.shade700,
                ),
                onPressed:
                    currentQuestionIndex == 0
                        ? null // Disable the button
                        : decreaseQuestionIndex, // Handle back button press

                child: const Text("Back", style: TextStyle(color: Colors.white)),
              )
              : const SizedBox(width: 25), // Same width as the Back button to keep layout aligned

          validateUserAnswer(), // Call the function to get the button
        ],
      ),
    );
  }

  void onAnswerSelected(String answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  void increaseQuestionIndexAndClearSelectedAnswer() {
    setState(() {
      selectedAnswer = null; // Reset selected answer
      isSelectedAnswerCorrect = null; // Reset the correctness state
      IsTheSelectedAnswerChecked = false; // Reset the flag for the next question;
      if (currentQuestionIndex >= questions.length - 1) {
        // Reset to the first question if at the end
        currentQuestionIndex = 0;

        return;
      }
      currentQuestionIndex++;
    });
  }

  void decreaseQuestionIndex() {
    setState(() {
      // if (currentQuestionIndex <= 0) {
      //   // Reset to the last question if at the beginning
      //   currentQuestionIndex = questions.length - 1;
      //   return;
      // }
      selectedAnswer = null; // Reset selected answer
      isSelectedAnswerCorrect = null; // Reset the correctness state
      IsTheSelectedAnswerChecked = false; // Reset the flag for the next question;
      currentQuestionIndex--;
    });
  }

  void checkSelectedAnswerIsCorrect() {
    setState(() {
      if (selectedAnswer == questions[currentQuestionIndex].correctAnswer) {
        // Handle correct answer
        isSelectedAnswerCorrect = true;
      } else {
        // Handle incorrect answer
        isSelectedAnswerCorrect = false;
      }
      IsTheSelectedAnswerChecked = true; // Set the flag to indicate the answer has been checked
    });
  }

  Widget showQuestionText() {
    return Text(
      questions[currentQuestionIndex].text,
      style: TextStyle(fontSize: 24, color: Colors.white),
    );
  }

  Widget buildButtonBackToStartScreen() {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(40, 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      label: const Text(
        'Back To Start Screen',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
      ),

      onPressed: widget.onBackToTheStartScreen, // Access from widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Question Text
          showQuestionText(),

          const SizedBox(height: 20),

          // Answer buttons
          ...questions[currentQuestionIndex].answers.map((answer) {
            return buildAnswerButton(answer, getAnswerButtonState(answer));
          }).toList(),

          const SizedBox(height: 20),

          buildNavigationButtons(),

          const SizedBox(height: 28),

          buildButtonBackToStartScreen(),
        ],
      ),
    );
  }
}

// Define the class first
class Question {
  final String text;
  final List<String> answers;
  final String correctAnswer; // New field

  Question(this.text, this.answers, this.correctAnswer);
}
