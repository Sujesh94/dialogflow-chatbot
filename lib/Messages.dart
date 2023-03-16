import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.builder(
        padding: const EdgeInsets.only( bottom: 10,top: 10),
        itemBuilder: (context, index) {
          return BubbleSpecialThree(
            text: widget.messages[index]['message'].text.text[0]!,
            color: widget.messages[index]['isUserMessage']? const Color(0xFF016bfd):Colors.white,
            isSender: widget.messages[index]['isUserMessage'],
            tail: true,
            textStyle: TextStyle(
                color: widget.messages[index]['isUserMessage']?Colors.white:Colors.black,
                fontSize: 16
            ),
          );


          //   Container(
          //   padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
          //   child: Align(
          //     alignment: (widget.messages[index]['isUserMessage']?Alignment.topRight:Alignment.topLeft),
          //     child: Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(20),
          //           color: (widget.messages[index]['isUserMessage']?Colors.red.shade100:Colors.blue[200]),
          //         ),
          //         padding: const EdgeInsets.all(16),
          //         child: Text(widget.messages[index]['message'].text.text[0]!, style: const TextStyle(fontSize: 15),)
          //     ),
          //   ),
          // );


          //   Container(
          //   margin: EdgeInsets.all(10),
          //   child: Row(
          //     mainAxisAlignment: widget.messages[index]['isUserMessage']
          //         ? MainAxisAlignment.end
          //         : MainAxisAlignment.start,
          //     children: [
          //       Container(
          //           padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.only(
          //                 bottomLeft: Radius.circular(
          //                   20,
          //                 ),
          //                 topRight: Radius.circular(20),
          //                 bottomRight: Radius.circular(
          //                     widget.messages[index]['isUserMessage'] ? 0 : 20),
          //                 topLeft: Radius.circular(
          //                     widget.messages[index]['isUserMessage'] ? 20 : 0),
          //               ),
          //               color: widget.messages[index]['isUserMessage']
          //                   ? Colors.grey.shade800
          //                   : Colors.grey.shade900.withOpacity(0.8)),
          //           constraints: BoxConstraints(maxWidth: w * 2 / 3),
          //           child:
          //               Text(widget.messages[index]['message'].text.text[0])),
          //     ],
          //   ),
          // );
        },
       // separatorBuilder: (_, i) => Padding(padding: EdgeInsets.only(top: 10,bottom: 10)),
        itemCount: widget.messages.length);
  }
}
