import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:twixter/pages/chat_detail.dart';
import 'package:twixter/pages/home_page.dart';
import 'package:twixter/pages/menu.dart';

class ChatListPage extends StatefulWidget {
  ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  Stream chats = FirebaseFirestore.instance.collection('chats').snapshots();

  void callChatDetailScreen(
      BuildContext context,
      String uid,
      String name,
      String matchName,
      String matchPicture,
      String matchType,
      String currentUserName,
      String currentUserId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatDetail(
                  matchUid: uid,
                  matchName: name,
                  matchTypeName: matchName,
                  matchType: matchType,
                  matchPicture: matchPicture,
                  currentUserName: currentUserName,
                  currentUserId2: currentUserId,
                )));
  }

  @override
  Widget build(BuildContext context) {
    var controller;
    bool noChats = false;
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: HexColor('#313b73'),
        appBar: AppBar(
          backgroundColor: HexColor('#313b73'),
          elevation: 0.0,
          title: const Text(''),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 7.0, left: 8),
            child: GestureDetector(
              child: SvgPicture.asset(
                'assets/images/twixter_logo.svg',
                color: HexColor('#E4EAF5'),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
          ),
          actions: [
            IconButton(
              padding: const EdgeInsets.all(6),
              icon: Image.asset('assets/images/twixter_menu.png'),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MenuPage()))
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
              height: 1000,
              child: StreamBuilder(
                stream: chats,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data.docs[index]['info']['matchUid'] !=
                          FirebaseAuth.instance.currentUser!.uid) {
                        if (snapshot.data.docs[index]['info']
                                ['currentUserId'] !=
                            FirebaseAuth.instance.currentUser!.uid) {
                          noChats = true;
                          return Container();
                        } else {
                          return GestureDetector(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, top: 20),
                                  child: SizedBox(
                                    height: 75,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data.docs[index]['info']
                                                  ['matchName'],
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color:
                                                          HexColor('#E4EAF5'),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                            const SizedBox(height: 10),
                                            StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('chats')
                                                  .doc(snapshot
                                                      .data.docs[index].id)
                                                  .collection('messages')
                                                  .orderBy('createdOn',
                                                      descending: true)
                                                  .snapshots(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot2) {
                                                return Flexible(
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5),
                                                    child: Text(
                                                      snapshot2.data.docs[0]
                                                          ['msg'],
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontStyle: (snapshot2.data.docs[0]['uid'] ==
                                                                      FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                  ? FontStyle
                                                                      .italic
                                                                  : FontStyle
                                                                      .normal,
                                                              color: HexColor(
                                                                  '#E4EAF5'),
                                                              fontWeight: (snapshot2
                                                                              .data
                                                                              .docs[0][
                                                                          'uid'] ==
                                                                      FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                  ? FontWeight.w500
                                                                  : FontWeight.w700,
                                                              fontSize: 13)),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                              snapshot.data.docs[index]['info']
                                                  ['matchPicture']),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                (snapshot.data.docs.length == index + 1)
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: HexColor('#222A5B'),
                                                  width: .5)),
                                        ),
                                      ),
                              ],
                            ),
                            onTap: () {
                              var matchUid =
                                  snapshot.data.docs[index]['info']['matchUid'];
                              var matchName = snapshot.data.docs[index]['info']
                                  ['matchName'];
                              var matchTypeName = snapshot.data.docs[index]
                                  ['info']['matchTypeName'];
                              var matchType = snapshot.data.docs[index]['info']
                                  ['matchType'];
                              var matchPicture = snapshot.data.docs[index]
                                  ['info']['matchPicture'];
                              var currentUserName = snapshot.data.docs[index]
                                  ['info']['currentUserName'];
                              var currentUserId = snapshot.data.docs[index]
                                  ['info']['currentUserId'];
                              callChatDetailScreen(
                                  context,
                                  matchUid,
                                  matchName,
                                  matchTypeName,
                                  matchType,
                                  matchPicture,
                                  currentUserName,
                                  currentUserId);
                            },
                          );
                        }
                      } else {
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30),
                                  child: SizedBox(
                                    height: 75,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                snapshot.data.docs[index]
                                                    ['info']['currentUserName'],
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color:
                                                            HexColor('#E4EAF5'),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700))),
                                            const SizedBox(height: 10),
                                            StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('chats')
                                                  .doc(snapshot
                                                      .data.docs[index].id)
                                                  .collection('messages')
                                                  .orderBy('createdOn',
                                                      descending: true)
                                                  .snapshots(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot2) {
                                                if (snapshot2
                                                        .data.docs.length ==
                                                    0) {
                                                  return Container();
                                                } else {
                                                  return Text(
                                                    snapshot2.data.docs[0]
                                                        ['msg'],
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            fontStyle: (snapshot2.data.docs[0]['uid'] ==
                                                                    FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                                ? FontStyle
                                                                    .italic
                                                                : FontStyle
                                                                    .normal,
                                                            color: HexColor(
                                                                '#E4EAF5'),
                                                            fontWeight: (snapshot2
                                                                            .data
                                                                            .docs[0]
                                                                        [
                                                                        'uid'] ==
                                                                    FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .uid)
                                                                ? FontWeight.w500
                                                                : FontWeight.w700,
                                                            fontSize: 13)),
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                              snapshot.data.docs[index]['info']
                                                  ['matchPicture']),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                (snapshot.data.docs.length == index + 1)
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: HexColor('#222A5B'),
                                                  width: .5)),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          onTap: () {
                            var matchUid =
                                snapshot.data.docs[index]['info']['matchUid'];
                            var matchName =
                                snapshot.data.docs[index]['info']['matchName'];
                            var matchTypeName = snapshot.data.docs[index]
                                ['info']['matchTypeName'];
                            var matchType =
                                snapshot.data.docs[index]['info']['matchType'];
                            var matchPicture = snapshot.data.docs[index]['info']
                                ['matchPicture'];
                            var currentUserName = snapshot.data.docs[index]
                                ['info']['currentUserName'];
                            var currentUserId = snapshot.data.docs[index]
                                ['info']['currentUserId'];
                            callChatDetailScreen(
                                context,
                                matchUid,
                                matchName,
                                matchTypeName,
                                matchType,
                                matchPicture,
                                currentUserName,
                                currentUserId);
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ));
  }
}
