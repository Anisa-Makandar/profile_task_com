import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome
import 'package:profile_task/block2_stept2.dart';
import 'package:profile_task/domain/app_color.dart';
import 'package:page_transition/page_transition.dart';

class SecondPage extends StatefulWidget {
  final String name;
  final File img;
  final int currentstep;
  final int totalsteps;

  SecondPage(
      {required this.name,
      required this.img,
      required this.totalsteps,
      required this.currentstep});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
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
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Step ${widget.currentstep} of ${widget.totalsteps}"),
              LinearProgressIndicator(
                value: widget.currentstep / widget.totalsteps,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(widget.img),
                    ),
                    SizedBox(height: 20),
                    Text(widget.name, style: TextStyle(fontSize: 24)),
                    SizedBox(height: 20),
                  ],
                ),
              ),
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
                          child: Block2Step2(
                            currentstep: widget.currentstep + 1,
                            totalsteps: widget.totalsteps,
                          ),
                          type: PageTransitionType.leftToRightWithFade,
                          duration: Duration(seconds: 1)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'primaryFont'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
