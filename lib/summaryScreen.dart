import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_questions.dart';
// import 'package:quiz_app/UserAnswers.dart';

class SummaryScreen extends StatelessWidget {
  //this Screen It Used To Show Summarize Of The Screen
  final VoidCallback onBackToRestartTheQuiz;
  // Calcul The number of correct answers
  // final int correctAnswers = questions.where((q) => q.userAnser == q.correctAnswer).length;
  final List<String> userAnswers;
  int CalculCorrectAnswers() {
    return List.generate(
      userAnswers.length,
      (i) => i,
    ).where((i) => userAnswers[i] == questions[i].correctAnswer).length;
  }

  Widget _buildTextTitle() {
    final correctAnswers = CalculCorrectAnswers();
    return Text(
      'you Answered ${correctAnswers} out of ${questions.length} questions correctly',
      textAlign: TextAlign.center, // 👈 Center each line
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  TextSpan _buildQuestionStyleDependingOnWhetherTheQuestionIsTrueOrFalse(
    bool isCorrect,
    String? userAnswer,
    String? correctAnswer,
  ) {
    if (isCorrect) {
      return TextSpan(
        text: '${userAnswer}\n\n',
        style: TextStyle(color: Colors.green, fontSize: 14),
      );
    } else {
      return TextSpan(
        children: [
          TextSpan(text: '${userAnswer}\n', style: TextStyle(color: Colors.red, fontSize: 14)),
          TextSpan(
            text: '${correctAnswer}\n\n',
            style: TextStyle(color: Colors.green, fontSize: 14),
          ),
        ],
      );
    }
  }

  Widget _printQuetionNumberAndStyled(int index) {
    bool IsCorrect = userAnswers[index] == questions[index].correctAnswer;
    return Container(
      width: 25,
      height: 25,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: IsCorrect ? Colors.green : Colors.red, // or Colors.red depending on the result
        shape: BoxShape.circle,
      ),
      child: Text(
        'Q${index + 1}',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Text color inside the circle
        ),
      ),
    );
  }

  Widget _printQuestionTextAndanswers(MapEntry<int, Question> entry, int index) {
    final question = entry.value;
    return Expanded(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${question.text}\n',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            (userAnswers[index] == question.correctAnswer)
                ? _buildQuestionStyleDependingOnWhetherTheQuestionIsTrueOrFalse(
                  true,
                  userAnswers[index],
                  null,
                )
                : _buildQuestionStyleDependingOnWhetherTheQuestionIsTrueOrFalse(
                  false,
                  userAnswers[index],
                  question.correctAnswer,
                ),
          ],
        ),
      ),
    );
  }

  Widget _printSummaryOfTheQuiz() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          questions.asMap().entries.map((entry) {
            final index = entry.key;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text at the top
              children: [
                // Question number
                _printQuetionNumberAndStyled(index),
                const SizedBox(width: 10), // Small space between number and text
                // RichText for question and answers
                _printQuestionTextAndanswers(entry, index),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildTheScrollableContent() {
    return SizedBox(
      height: 300, // Set a fixed height for the scrollable area,
      child: SingleChildScrollView(child: _printSummaryOfTheQuiz()),
    );
  }

  void RestartTheQuiz() {
    userAnswers.clear(); // Clear user answers when going back to start screen
    onBackToRestartTheQuiz();
  }

  Widget _buildRestartQuizButton() {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(40, 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      icon: const Icon(Icons.restart_alt, color: Colors.white),
      label: const Text(
        'Restart The Quiz',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: RestartTheQuiz,
    );
  }

  SummaryScreen({super.key, required this.onBackToRestartTheQuiz, required this.userAnswers});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextTitle(),
            const SizedBox(height: 20),
            _buildTheScrollableContent(),
            const SizedBox(height: 20),
            _buildRestartQuizButton(),
          ],
        ),
      ),
    );
  }
}
