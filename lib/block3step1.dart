import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome
import 'package:intl/intl.dart';
import 'package:profile_task/block1_imagepicker.dart';
import 'package:profile_task/domain/app_color.dart';
import 'package:page_transition/page_transition.dart';

class Block3Step3 extends StatefulWidget {
  final String selectedDay;
  final DateTime fromDate;
  final DateTime toDate;
  final int currentstep;
  final int totalsteps;

  Block3Step3({
    required this.selectedDay,
    required this.fromDate,
    required this.toDate,
    required this.currentstep,
    required this.totalsteps,
  });

  @override
  _Block3Step3State createState() => _Block3Step3State();
}

class _Block3Step3State extends State<Block3Step3> {
  @override
  void initState() {
    super.initState();
    // Lock the orientation to landscape when this page is displayed
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Revert back to the default orientation when leaving the page
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  // Function to calculate the occurrences of a specific weekday between two dates
  int calculateOccurrences(String day) {
    int occurrences = 0;
    DateTime current = widget.fromDate; // Access from widget
    int dayIndex = _getDayIndex(day);

    while (current.isBefore(widget.toDate) ||
        current.isAtSameMomentAs(widget.toDate)) {
      if (current.weekday == dayIndex) occurrences++;
      current = current.add(Duration(days: 1));
    }
    return occurrences;
  }

  // Helper function to get the index of the selected day (1 for Monday, 7 for Sunday)
  int _getDayIndex(String day) {
    switch (day) {
      case "Monday":
        return DateTime.monday;
      case "Tuesday":
        return DateTime.tuesday;
      case "Wednesday":
        return DateTime.wednesday;
      case "Thursday":
        return DateTime.thursday;
      case "Friday":
        return DateTime.friday;
      case "Saturday":
        return DateTime.saturday;
      case "Sunday":
        return DateTime.sunday;
      default:
        return DateTime.monday;
    }
  }

  @override
  Widget build(BuildContext context) {
    int occurrences = calculateOccurrences(widget.selectedDay);
    DateFormat dtFormat = DateFormat.yMMMd();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                      "Step ${widget.currentstep} of ${widget.totalsteps}")),
              LinearProgressIndicator(
                value: widget.currentstep / widget.totalsteps,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "From Date: ${dtFormat.format(widget.fromDate)}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "To Date: ${dtFormat.format(widget.toDate)}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "Selected Day: ${widget.selectedDay}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "Total ${widget.selectedDay}: $occurrences",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      AppColors.buttonclrgr1,
                      AppColors.buttonclrgr2,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(PageTransition(
                          child: ImagePickerScreen(
                            currentstep: widget.currentstep + 1,
                            totalsteps: widget.totalsteps,
                          ), // Replace with your target widget
                          type: PageTransitionType.leftToRightWithFade,
                          duration: Duration(seconds: 1),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Finish',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'primaryFont'),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
