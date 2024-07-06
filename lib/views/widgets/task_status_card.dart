import 'package:flutter/material.dart';

class TaskStatusCard extends StatelessWidget {
  final double screenWidth;
  final String titleText;
  final String subtitleText;

  const TaskStatusCard(
      {super.key,
      required this.screenWidth,
      required this.titleText,
      required this.subtitleText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.31,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleText,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                subtitleText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
