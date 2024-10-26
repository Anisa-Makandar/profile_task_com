import 'package:flutter/material.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep; // Current step number: 1, 2, or 3

  StepProgressBar({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStepCircle(context, "1", currentStep >= 1),
        _buildProgressLine(context, currentStep >= 2),
        _buildStepCircle(context, "2", currentStep >= 2),
        _buildProgressLine(context, currentStep >= 3),
        _buildStepCircle(context, "3", currentStep >= 3),
      ],
    );
  }

  Widget _buildStepCircle(BuildContext context, String step, bool isActive) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        step,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProgressLine(BuildContext context, bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? Colors.blue : Colors.grey,
      ),
    );
  }
}
