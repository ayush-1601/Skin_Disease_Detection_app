import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skincare/pages/home_page.dart';
import 'package:flutter_skincare/pages/home_page2.dart';
import 'package:flutter_skincare/pages/image_page.dart';

List<CameraDescription>? cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
          primaryColor: Colors.black54,
          textTheme: CupertinoTextThemeData(
              textStyle:
                  TextStyle(fontFamily: 'Poppins', color: Colors.black))),
      title: 'Flutter Demo',
      home: DiseaseImage(),
    );
  }
}
