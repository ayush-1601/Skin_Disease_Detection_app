import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skincare/pages/chatbot/message_screen.dart';

class ChatbotScreen extends StatefulWidget {
  ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Container(
          margin: EdgeInsets.only(bottom: 8),
          width: MediaQuery.of(context).size.width * 0.5,
          child: Center(
            child: Text(
              "DermBot",
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
            color: Colors.amber[200],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(child: MessagesScreen(messages: messages)),
          Container(
            decoration: BoxDecoration(
                color: Colors.amber[300],
                borderRadius: BorderRadius.circular(50)),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            margin: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                    child: CupertinoTextField(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50)),
                  placeholder: "Ask DermBot here...",
                  placeholderStyle:
                      TextStyle(letterSpacing: 2, color: Colors.black38),
                  controller: _controller,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                )),
                CupertinoButton(
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                    child: const Icon(
                      Icons.send,
                      color: Colors.black,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
