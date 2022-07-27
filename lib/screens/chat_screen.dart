import 'package:flash_card/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore=FirebaseFirestore.instance;
late User? loggedInUser=_auth.currentUser;
final _auth= FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  static const String id ='chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

   var controller=TextEditingController();


  late String message;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser()async {
    try {
      loggedInUser = _auth.currentUser!;
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(
                          child: CircularProgressIndicator(
                          backgroundColor: Colors.lightBlueAccent,
                          ),
                       );
                   }
                    List<MessageBubble> messageList=[];
                    final messages= snapshot.data?.docs;//so it would show in the end as the List view was revesered therefore we also need to add reversed here
                    for(var message in messages!){
                      var messageText= message.get('text');
                      print(messageText);
                      var messageSender=message.get('sender');
                      var currentUser=loggedInUser;
                      final messageListItem= MessageBubble(
                          text: messageText,
                          sender: messageSender,
                          isMe: currentUser?.email==messageSender,//check if its the current user or some other user for styling purposes

                      );
                      messageList.add(messageListItem);
                    }
                    return Expanded(
                      child: ListView(
                        reverse: true,
                        children: messageList,
                      ),
                    );
                },
            ),


            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        message=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.clear();
                      //mesaages= text(message)+sender(email)
                      _firestore.collection('messages').add({
                        'text': message,
                        'sender': loggedInUser?.email
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender, required this.isMe});

  late String text;
  late String sender;
  late bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 13
            ),
          ),
          Material(
            color: isMe? Colors.lightBlueAccent : Colors.white,
            elevation: 5,
            borderRadius: isMe?
            BorderRadiusDirectional.only(
                topStart: Radius.circular(30),
            bottomStart: Radius.circular(30),
            bottomEnd: Radius.circular(30))
            : BorderRadiusDirectional.only(
                topEnd: Radius.circular(30),
                bottomStart: Radius.circular(30),
                bottomEnd: Radius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                  text,
              style: TextStyle(
                color: isMe? Colors.white : Colors.black87,
                fontSize: 16,
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
