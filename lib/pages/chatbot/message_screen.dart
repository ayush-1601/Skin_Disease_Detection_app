import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      child: ListView.separated(
          controller: _scrollController,
          physics:
              AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: widget.messages[index]['isUserMessage']
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            20,
                          ),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 0 : 20),
                          topLeft: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 20 : 0),
                        ),
                        color: widget.messages[index]['isUserMessage']
                            ? Colors.amber[300]
                            : Colors.amber,
                      ),
                      constraints: BoxConstraints(maxWidth: w * 2 / 3),
                      child:
                          Text(widget.messages[index]['message'].text.text[0])),
                ],
              ),
            );
          },
          separatorBuilder: (_, i) =>
              const Padding(padding: EdgeInsets.only(top: 10)),
          itemCount: widget.messages.length),
    );
  }
}
