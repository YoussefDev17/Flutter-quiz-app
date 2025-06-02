import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  //this Screen It Used To Show Summarize Of The Screen
  Widget _buildTextTitle() {
    return Text(
      'This Is The Title Of The Summary Screen',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  const SummaryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [_buildTextTitle()]));
  }
}
