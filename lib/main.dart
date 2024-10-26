import 'package:flutter/material.dart';
import 'package:profile_task/block1_imagepicker.dart';
import 'package:profile_task/provider/imagepicker_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ImageProviderNotifier())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImagePickerScreen(
        currentstep: 0,
        totalsteps: 3,
      ),
    );
  }
}
