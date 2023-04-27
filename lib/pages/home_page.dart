import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skincare/main.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = "";
  // bool loading = false;
  // XFile? _image;
  // late List _outputs;

  // var source;

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  }

  loadCamera() async {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((imageStram) {
            cameraImage = imageStram;
            runModel();
          });
        });
      }
    });
  }

  runModel() async {
    var predictions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 8,
        threshold: 0.1,
        asynch: true);
    for (var element in predictions!) {
      setState(() {
        output = element["label"];
      });
    }
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/models.tflite", labels: "assets/labels.txt");
  }

  // classifyImage(File image) async {
  //   var output = await Tflite.runModelOnImage(
  //     path: image.path,
  //   );
  //   for (var element in output!) {
  //     setState(() {
  //       loading = false;
  //       _outputs = output;
  //     });
  //   }
  //   // setState(() {
  //   //   loading = false;
  //   //   output = output;
  //   // });
  // }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  // pickimage() async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     setState(() {
  //       loading = true;
  //       _image = image;
  //     });
  //     classifyImage(_image as File);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              color: Colors.red,
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: !cameraController!.value.isInitialized
                  ? Container()
                  : AspectRatio(
                      aspectRatio: cameraController!.value.aspectRatio,
                      child: CameraPreview(cameraController!),
                    ),
            ),
          ),

          Text(output),

          // FloatingActionButton(
          //   onPressed: () {s
          //     setState(() {
          //       source = ImageSource.camera;
          //     });
          //     pickimage();
          //   },
          //   child: Icon(Icons.camera),
          // ),
        ],
      ),
    );
  }
}
