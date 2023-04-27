import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skincare/pages/home_page.dart';
import 'package:flutter_skincare/pages/home_page2.dart';

class DiseaseImage extends StatefulWidget {
  const DiseaseImage({super.key});

  @override
  State<DiseaseImage> createState() => _DiseaseImageState();
}

class _DiseaseImageState extends State<DiseaseImage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,

      // child: Column(
      //   children: [
      //     Container(
      //       color: Colors.black,
      //       height: 500,
      //       width: 800,
      //       child: Row(
      //         children: [
      //           CupertinoButton(
      //               child: Icon(CupertinoIcons.add),
      //               onPressed: () {
      //                 Navigator.of(context).push(CupertinoPageRoute(
      //                     builder: (builder) => ImagePickerPage()));
      //               }),
      //           CupertinoButton(
      //               child: Icon(CupertinoIcons.mic),
      //               onPressed: () {
      //                 Navigator.of(context).push(
      //                     CupertinoPageRoute(builder: (builder) => HomePage()));
      //               }),
      //         ],
      //       ),
      //     )
      //   ],
      // ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(100))),
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width / 5,
              ),
              Container(
                margin: EdgeInsets.only(top: 50, left: 30, right: 30),
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.amber[200],
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Skin Disease",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height / 18),
                      ),
                      Text(
                        "Detector",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height / 18),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            // color: Colors.black,
            padding: EdgeInsets.only(left: 10, right: 30, bottom: 20),
            margin: EdgeInsets.only(left: 30, right: 30, top: 30),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/skin2.png",
            ),
          ),
          Container(
            margin: EdgeInsets.zero,
            height: MediaQuery.of(context).size.height / 10,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                "Early detection is the key.\nKnow your skin, predict your health.",
                style: TextStyle(fontSize: 20, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          CupertinoButton(
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (builder) => ImagePickerPage()));
              },
              child: Container(
                margin: EdgeInsets.all(30),
                height: MediaQuery.of(context).size.height / 12,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    color: Colors.amber[200],
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 20),
                      child: Icon(
                        CupertinoIcons.chevron_right,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
