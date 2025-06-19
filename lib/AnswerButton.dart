import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final bool isPressed;
  final String text;
  final VoidCallback onTap;
  final bool isDisabled;
  final bool? ButtonState;

  AnswerButton({
    super.key,
    required this.text,
    required this.isPressed,
    required this.onTap,
    required this.isDisabled,
    this.ButtonState, // This Is Used To know the state of the button (correct, incorrect, or null)
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isPressed
                ? const Color.fromARGB(255, 146, 76, 168) // Purple color when pressed
                : const Color.fromARGB(255, 49, 1, 69), // Purple color when not pressed
        minimumSize: const Size(300, 30),
        shape: const StadiumBorder(), // Oval/pill shape
        side: BorderSide(
          width: ButtonState != null ? 3 : 0,
          color:
              ButtonState == null
                  ? Colors
                      .grey // The Defaul Color If The User Not Chose Yet An Answer
                  : ButtonState == true
                  ? Colors
                      .green // Green color if the answer is correct
                  : Colors.red, // Red color if the answer is incorrect
        ), // Border
      ),
      onPressed:
          isDisabled // Check if an answer has been selected
              ? null // Disable the button if an answer is already selected
              : onTap,

      child: Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
