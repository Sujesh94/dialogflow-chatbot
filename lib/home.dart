import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:oceanix_bot/Messages.dart';
import 'package:oceanix_bot/threedots.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];
  bool _isTyping = false;
  @override
  void initState() {

    //Fetching api key from asset folder (name the key dialog_flow_auth.json otherwise need to specify the path)
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFf7f7f7),
      appBar: AppBar(
        //backgroundColor: Color(0xFF016bfd),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset("assets/images/robot.png"),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const Text("OceanixBot",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:Colors.black              ,//Color(0xFF016bfd),
                      fontSize: 18,
                    )),
                Text(
                  "Online",
                  style: TextStyle(color: Colors.green.shade500, fontSize: 13),
                ),
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Flexible(child: MessagesScreen(messages: messages),fit: FlexFit.tight,),
          if (_isTyping) const ThreeDots(),
          // const Divider(
          //   height: 1.0,
          // ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF016bfd),
                      width: 1,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  //color: Colors.white,
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration.collapsed(
                        hintText: "Type message...",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                const Spacer(),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFF016bfd),
                  child: IconButton(
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      return;
    } else {
      setState(() {
        _isTyping = true;
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        _isTyping = false;
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
