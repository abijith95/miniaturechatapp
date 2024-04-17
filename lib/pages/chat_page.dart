import 'package:chatapp/components/chat_bubble.dart';
import 'package:chatapp/components/my_text.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receivedEmail;
  final String receivedId;
  ChatPage({super.key, required this.receivedEmail, required this.receivedId});

  //textcontroller::::::::::::::::::::::
  final TextEditingController _messageController = TextEditingController();

  //auth and auth services:::::::::::::
  final ChatServices _chatServices = ChatServices();
  final Authservice _authservice = Authservice();

  //method on send a message:::::
  void sendMessage() async {
    //if there is soemthing inside the textfield
    if (_messageController.text.isNotEmpty) {
      //send the message :::
      await _chatServices.sendMessage(receivedId, _messageController.text);

      // clear the  messageController
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(receivedEmail),
         backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      ),
      body: Column(
        children: [
          //display ,messages::::::
          Expanded(
            child: _buildmessageList(),
          ),
          //user Input::::::
          _builduserInput()
        ],
      ),
    );
  }

  //build messsage List:::::
  Widget _buildmessageList() {
    String senderId = _authservice.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatServices.getMessages(receivedId, senderId),
        builder: (context, snapshot) {
          //errors::::
          if (snapshot.hasError) {
            return const Text("Errors");
          }
          //Loading:::::
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("L O A D I N G . . . . ");
          }

          //Listview:::::
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildmessageItem(doc))
                .toList(),
          );
        });
  }

  //build message item:::::::::::::::

  Widget _buildmessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user:::::::::::::::
    bool iscurrentUser = data['senderId'] == _authservice.getCurrentUser()!.uid;

    //align message to the right if sender is the current user ,otherwise left::::::::::::::;;
    var alignment =
        iscurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              iscurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data['message'], iscurrentUser: iscurrentUser)
          ],
        ));
  }

  //buld messaga input::::::

  Widget _builduserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Row(
        children: [
          Expanded(
              child: MyTextField(
                  hinttext: "Type something ",
                  obscure: false,
                  controller: _messageController)),

          //send Button::::::
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 109, 226, 112),
                shape: BoxShape.circle),
            margin: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  sendMessage();
                },
                icon: Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}
