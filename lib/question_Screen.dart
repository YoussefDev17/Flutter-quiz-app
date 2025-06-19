import 'package:flutter/material.dart';
import 'package:quiz_app/AnswerButton.dart';
import 'package:quiz_app/quiz_questions.dart';
// import 'package:quiz_app/UserAnswers.dart';

class QuestionScreen extends StatefulWidget {
  final VoidCallback onBackToTheStartScreen;
  final VoidCallback onGoToSummaryScreen;
  final List<String> userAnswers;
  const QuestionScreen({
    super.key,
    required this.onBackToTheStartScreen,
    required this.onGoToSummaryScreen,
    required this.userAnswers,
  });
  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool IsTheSelectedAnswerChecked = false;

  int currentQuestionIndex = 0;

  String? selectedAnswer;

  bool? isSelectedAnswerCorrect;

  // List<String> userAnswers = [];

  Widget buildNextButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(25, 18),
        shape: const StadiumBorder(), // Oval/pill shape
        backgroundColor: Colors.deepPurple.shade700,
      ),
      onPressed:
          (currentQuestionIndex >= questions.length - 1)
              ? widget.onGoToSummaryScreen
              : increaseQuestionIndexAndClearSelectedAnswer,
      child: const Text("Next", style: TextStyle(color: Colors.white)),
    );
  }

  Widget buildCheckAnswerButton() {
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

  Widget validateUserAnswer() {
    // Check The User Not Selected Any Answer
    if (selectedAnswer == null) {
      return const SizedBox(
        width: 25,
      ); // Same width as the Next And Check button to keep layout aligned
    }
    // Check If The User Answer Cheked To Show Them Next Button
    if (IsTheSelectedAnswerChecked) {
      return buildNextButton(); // Call the function to get the Next button
    }

    return buildCheckAnswerButton(); // Call the function to get the Check button
  }

  Widget buildAnswerButton(String answer, bool? answerStatus) {
    return Column(
      children: [
        AnswerButton(
          key: ValueKey(answer), // Use ValueKey to ensure each button is unique
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

  Widget buildBackButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(25, 18),
        shape: const StadiumBorder(), // Oval/pill shape
        backgroundColor: Colors.deepPurple.shade700,
      ),
      onPressed: decreaseQuestionIndex, // Handle back button press
      // currentQuestionIndex == 0
      //         ? null // Disable the button
      //         :
      child: const Text("Back", style: TextStyle(color: Colors.white)),
    );
  }

  Widget buildNavigationButtons() {
    return SizedBox(
      width: 300, // Match the width of your myCustomButton
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          currentQuestionIndex != 0
              ? buildBackButton() // Call the function to get the Back button
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
      currentQuestionIndex++;
      // Check if the current question The User Answerd Before
      if (currentQuestionIndex <= widget.userAnswers.length - 1) {
        selectedAnswer = widget.userAnswers[currentQuestionIndex]; // Reset selected answer
        isSelectedAnswerCorrect =
            selectedAnswer ==
            questions[currentQuestionIndex].correctAnswer; // Reset the correctness state
        IsTheSelectedAnswerChecked = true; // Reset the flag for the next question;
        return;
      }

      selectedAnswer = null; // Reset selected answer
      isSelectedAnswerCorrect = null; // Reset the correctness state
      IsTheSelectedAnswerChecked = false; // Reset the flag for the next question;
    });
  }

  void decreaseQuestionIndex() {
    setState(() {
      currentQuestionIndex--;
      // selectedAnswer = questions[currentQuestionIndex].userAnser; // Reset selected answer
      selectedAnswer =
          widget.userAnswers[currentQuestionIndex]; // Reset selected answer from the list
      isSelectedAnswerCorrect =
          // questions[currentQuestionIndex].userAnser ==
          widget.userAnswers[currentQuestionIndex] ==
          questions[currentQuestionIndex].correctAnswer; // Reset the correctness state
      IsTheSelectedAnswerChecked = true; // Reset the flag for the next question;
    });
  }

  void ChooseAnswer(String answer) {
    widget.userAnswers.add(answer); // Add the selected answer to the list
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

      // questions[currentQuestionIndex].userAnser = selectedAnswer; // Save user answer

      ChooseAnswer(selectedAnswer!); // Add the selected answer to the list .
      //I’m sure this selectedAnswer is not null at this moment
    });
  }

  Widget showQuestionText() {
    return Text(
      questions[currentQuestionIndex].text,
      style: TextStyle(fontSize: 24, color: Colors.white),
      textAlign: TextAlign.center,
    );
  }

  void ResetQuizAnswersAndBackToStartScreen() {
    widget.userAnswers.clear(); // Clear user answers when going back to start screen
    widget.onBackToTheStartScreen;
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

      onPressed: ResetQuizAnswersAndBackToStartScreen, // Access from widget
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
