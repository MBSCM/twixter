// ignore_for_file: no_logic_in_create_state

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatDetail extends StatefulWidget {
  final matchUid;
  final matchName;
  final matchTypeName;
  final matchPicture;
  final matchType;
  final currentUserName;
  final currentUserId2;

  ChatDetail({
    Key? key,
    this.matchUid,
    this.matchName,
    this.matchTypeName,
    this.matchPicture,
    this.matchType,
    this.currentUserName,
    this.currentUserId2,
  }) : super(key: key);

  @override
  _ChatDetailState createState() => _ChatDetailState(matchUid, matchName,
      matchTypeName, matchPicture, matchType, currentUserName, currentUserId2);
}

class _ChatDetailState extends State<ChatDetail> {
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final matchUid;
  final matchName;
  final matchTypeName;
  final matchPicture;
  final matchType;
  final currentUserName;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  
  final currentUserId2;
  
  var chatDocId;
  var _textController = new TextEditingController();
  var message = '';
  _ChatDetailState(this.matchUid, this.matchName, this.matchTypeName,
      this.matchType, this.matchPicture, this.currentUserName, this.currentUserId2);
  @override
  void initState() {
    super.initState();
    checkUser();
  }
  

  

  Future checkUser() async {
   

    await chats
        .where('users', isEqualTo: {matchUid: null, (currentUserId != currentUserId2)?currentUserId2:currentUserId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                chatDocId = querySnapshot.docs.single.id;
              });
              print(chatDocId);
            } else {
              await chats.add({
                'users': {currentUserId: null, matchUid: null},
                'info': {
                  'currentUserId': currentUserId,
                  'currentUserName': currentUserName,
                  'matchUid': matchUid,
                  'matchName': matchName,
                  'matchType': matchType,
                  'matchTypeName': matchTypeName,
                  'matchPicture': matchPicture
                }
              }).then((value) => {chatDocId = value});
            }
          },
        )
        .catchError((error) {});
  }

  void sendMessage(String msg) {
    checkUser();
    if (msg == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'matchName': matchName,
      'msg': msg
    }).then((value) {
      _textController.text = '';
    });
  }

  bool isSender(String friend) {
    return friend == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: chats
          .doc(chatDocId)
          .collection('messages')
          .orderBy('createdOn', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }

        if (snapshot.hasData) {
          var data;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor('#313B73'),
              toolbarHeight: 0,
            ),
            extendBodyBehindAppBar: true,
            backgroundColor: HexColor('#E4EAF5'),
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                          color: HexColor('#313B73'),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Stack(
                        children: [
                          GestureDetector(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 35),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: HexColor('#575EA6'),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Align(
                                    alignment: Alignment.center,
                                    child: FaIcon(
                                      FontAwesomeIcons.backward,
                                      color: HexColor('#E4EAF5'),
                                      size: 18,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 60.0, top: 30),
                            child: Text((currentUserId == FirebaseAuth.instance.currentUser!.uid)?matchName:currentUserName,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: HexColor('#E4EAF5'),
                                        fontSize: 25))),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 60.0, top: 65),
                              child: Text(
                                  'Jullie matchen door jullie \nfavoriete artiest',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: HexColor('#E4EAF5'),
                                          fontSize: 14)))),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 30.0, top: 35),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      matchPicture,
                                      height: 70,
                                      width: 70,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    matchTypeName,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: HexColor('#E4EAF5'),
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      reverse: true,
                      children: snapshot.data!.docs.map(
                        (DocumentSnapshot document) {
                          data = document.data();

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper4(
                                nipSize: 1,
                                radius: 5,
                                type: isSender(data['uid'].toString())
                                    ? BubbleType.sendBubble
                                    : BubbleType.receiverBubble,
                              ),
                              alignment: getAlignment(data['uid'].toString()),
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              backGroundColor: isSender(data['uid'].toString())
                                  ? HexColor('#313B73')
                                  : HexColor('#575EA6'),
                              child: Container(
                                // ignore: prefer_const_constructors
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.7),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            data['msg'],
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: HexColor('#313B73'),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 10),
                            child: TextField(
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                  hintText: 'Begin met typen...',
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  border: InputBorder.none),
                              controller: _textController,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: HexColor('#575EA6'),
                                  borderRadius: BorderRadius.circular(5)),
                              child: IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.play,
                                  color: HexColor('#E4EAF5'),
                                  size: 18,
                                ),
                                onPressed: () =>
                                    sendMessage(_textController.text),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
