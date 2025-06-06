// Define the class first
class Question {
  final String text;
  final List<String> answers;
  final String correctAnswer; // New field
  String? userAnser;

  Question(this.text, this.answers, this.correctAnswer, {this.userAnser});
}

// List of questions with answers and correct answer And User Answer
final List<Question> questions = [
  Question('What is Flutter?', ['SDK', 'Game', 'Language', 'IDE'], 'SDK'),
  Question('What is Dart?', ['Language', 'Bird', 'IDE', 'Company'], 'Language'),
  Question('Who developed Flutter?', [
    'Apple',
    'Facebook',
    'Microsoft',
    'Google',
  ], 'Google'),
  Question('What widget is used for layout in Flutter?', [
    'Text',
    'Scaffold',
    'Column',
    'MaterialApp',
  ], 'Column'),
  Question(
    'Which command is used to create a new Flutter project?',
    [
      'flutter new project',
      'flutter create myapp',
      'flutter start',
      'flutter init',
    ],
    'flutter new project',
  ),
];
