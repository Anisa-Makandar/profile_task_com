import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_task/block2_step1.dart';
import 'package:profile_task/domain/app_color.dart';
import 'package:profile_task/provider/imagepicker_provider.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class ImagePickerScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final int currentstep;
  final int totalsteps;
  ImagePickerScreen({required this.currentstep, required this.totalsteps});
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(BuildContext context) async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Provider.of<ImageProviderNotifier>(context, listen: false)
          .setImage(File(pickedImage.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final File? image = Provider.of<ImageProviderNotifier>(context).image;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Select Image",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => pickImage(context),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: image != null ? FileImage(image) : null,
                  child: image == null ? Icon(Icons.person, size: 60) : null,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.grey), // Default border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xFFDCDCDC),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xFFDCDCDC),
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.center,
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
                      if (nameController.text.isNotEmpty && image != null) {
                        Navigator.push(
                          context,
                          PageTransition(
                              child: SecondPage(
                                name: nameController.text,
                                img: image,
                                currentstep: currentstep + 1,
                                totalsteps: totalsteps,
                              ),
                              type: PageTransitionType.leftToRightWithFade,
                              duration: Duration(seconds: 1)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Please fill all the details")),
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
