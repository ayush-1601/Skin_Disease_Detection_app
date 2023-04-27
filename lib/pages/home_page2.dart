import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skincare/pages/chatbot/chatbot_screen.dart';
import 'package:flutter_skincare/pages/image_page.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  late File _image;
  final picker = ImagePicker();
  List _output = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _output.clear();
    Tflite.close();
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
      asynch: true,
    );
    setState(() {
      _loading = false;
      _output = output!;
    });
    output!.clear();
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/models.tflite", labels: "assets/labels.txt");
  }

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      // _loading = true;
      _image = File(image.path);
    });
    classifyImage(_image);

    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (builder) => DiseaseImage()));
  }

  //Image Picker function to get image from gallery
  // Future getImageFromGallery() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     }
  //   });
  // }

  toDiseasePage() async {
    await Navigator.of(context)
        .push(CupertinoPageRoute(builder: (builder) => const DiseaseImage()));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(start: 30, end: 30),
        backgroundColor: Color(0xfffff4cf),
        leading: Container(
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(50),
            color: Colors.amber[300],
          ),
        ),
        trailing: Container(
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(50),
            color: Colors.amber[300],
          ),
        ),
        middle: Container(
          margin: EdgeInsets.only(bottom: 8),
          width: MediaQuery.of(context).size.width * 0.6,
          child: Center(
            child: Text(
              "Upload Image",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Poppins",
                  color: Colors.black54,
                  letterSpacing: 2),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.amber[300]),
        ),
      ),
      backgroundColor: Color(0xfffff4cf),
      child: SingleChildScrollView(
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: _loading == true
                          ? Container(
                              margin: EdgeInsets.all(20),
                              height: MediaQuery.of(context).size.height / 2,
                              decoration: const BoxDecoration(
                                color: Color(0xfffff4cf),
                              ),
                              child: Container(
                                child: Image.asset(
                                    "assets/images/skin_detecting2.png"),
                              ),
                            )
                          : Container(
                              child: Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(20),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width: MediaQuery.of(context).size.width,
                                      color: Color(0xfffff4cf),
                                      child: Image.file(
                                        _image,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                    _output != null
                                        ? Text(_output[0]['label'].toString())
                                        : Container()
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        CupertinoButton(
                          onPressed: pickImage,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 200,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 17),
                            decoration: BoxDecoration(
                              color: Colors.amber[300],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              'Gallery',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        // CupertinoButton(
                        //     child: Icon(CupertinoIcons.add),
                        //     onPressed: () {
                        //       Navigator.push(
                        //           context,
                        //           CupertinoPageRoute(
                        //               builder: (builder) => ChatbotScreen()));
                        //     })
                      ],
                    ),
                  )
                ],
              ),
              CupertinoButton(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey,
                              blurRadius: 20,
                              spreadRadius: 5,
                              blurStyle: BlurStyle.normal)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Image.asset(
                      "assets/images/chatbot.png",
                      height: 60,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (builder) => ChatbotScreen()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
