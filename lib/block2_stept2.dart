import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome
import 'package:intl/intl.dart';
import 'package:profile_task/block3step1.dart';
import 'package:profile_task/domain/app_color.dart';
import 'package:page_transition/page_transition.dart';

class Block2Step2 extends StatefulWidget {
  final int currentstep;
  final int totalsteps;
  Block2Step2({required this.currentstep, required this.totalsteps});
  @override
  State<Block2Step2> createState() => _Block2Step2State();
}

class _Block2Step2State extends State<Block2Step2> {
  DateTime? _fromDate;
  DateTime? _toDate;
  DateFormat dtFormat = DateFormat.yMMMd();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  List<String> selectedDay = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  String selectedExpenseType = "Monday";

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
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
                DropdownMenu(
                  inputDecorationTheme: InputDecorationTheme(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  width: double.infinity,
                  label: Text("Type"),
                  onSelected: (value) {
                    setState(() {
                      selectedExpenseType = value!;
                    });
                  },
                  initialSelection: selectedExpenseType,
                  dropdownMenuEntries: selectedDay
                      .map((element) =>
                          DropdownMenuEntry(value: element, label: element))
                      .toList(),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // From Date Field
                    Expanded(
                      child: TextField(
                        controller: fromDateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Select From Date",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(true),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 220, 220, 220),
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xFFDCDCDC),
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    // To Date Field
                    Expanded(
                      child: TextField(
                        controller: toDateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Select To Date",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(false),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xFFDCDCDC),
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xFFDCDCDC),
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                AppColors.buttonclrgr1,
                                AppColors.buttonclrgr2,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              if (_fromDate != null && _toDate != null) {
                                // Navigator.of(context).push(
                                //   // MaterialPageRoute(
                                //   //   builder: (context) => Block3Step3(
                                //   //     selectedDay: selectedExpenseType,
                                //   //     fromDate: _fromDate!,
                                //   //     toDate: _toDate!,
                                //   //   ),
                                Navigator.of(context).push(PageTransition(
                                    child: Block3Step3(
                                      fromDate: _fromDate!,
                                      toDate: _toDate!,
                                      currentstep: widget.currentstep + 1,
                                      totalsteps: widget.totalsteps,
                                      selectedDay: selectedExpenseType,
                                    ),
                                    type:
                                        PageTransitionType.leftToRightWithFade,
                                    duration: Duration(seconds: 1)));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please select both dates.'),
                                  ),
                                );
                              }
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
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(bool isFrom) async {
    DateTime initialDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _fromDate = picked;
          fromDateController.text = dtFormat.format(picked);
        } else {
          _toDate = picked;
          toDateController.text = dtFormat.format(picked);
        }
      });
    }
  }
}
