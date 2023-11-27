import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:badges/badges.dart' as badges;
import 'package:tu_pension/constants.dart';
import 'dart:math';
import 'package:tu_pension/hooks/hasPendingNotifications.dart';

import 'package:tu_pension/ui/screens/chat/chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  static String routeName = "/chat_list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('participants',
                arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var chats = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              var chat = chats[index];
              var chatId = chat.id;
              var productTitle = chat['productTitle'];

              int unreadMessages = chat['unreadMessages']
                      [FirebaseAuth.instance.currentUser!.uid] ??
                  0;

              return ListTile(
                leading: _buildAvatar(),
                title: Text('Usuario'),
                subtitle: _buildSubtitle(chat, unreadMessages),
                onTap: () => handleChatTap(context, chatId, productTitle),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSubtitle(DocumentSnapshot chat, int unreadMessages) {
    List<dynamic> participants = chat['participants'];
    if (participants.length == 2) {
      participants.remove(FirebaseAuth.instance.currentUser!.uid);
      String participantUid = participants[0];
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(participantUid),
          if (unreadMessages > 0)
            badges.Badge(
                badgeContent: Text(
                  unreadMessages.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: kPrimaryColor,
                  padding: EdgeInsets.all(5.0),
                )),
        ],
      );
    } else {
      return Text('Grupo');
    }
  }

  Widget _buildAvatar() {
    return const CircleAvatar(
      backgroundImage: CachedNetworkImageProvider('https://i.pravatar.cc/300'),
    );
  }

  void handleChatTap(BuildContext context, String chatId, String productTitle) {
    _resetUnreadMessages(chatId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          chatId: chatId,
          productTitle: productTitle,
        ),
      ),
    );
  }

  void _resetUnreadMessages(chatId) {
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .get()
        .then((chatDocument) {
      FirebaseFirestore.instance.collection('chats').doc(chatId).update({
        'unreadMessages.$userUid': 0,
      });
    });
  }
}
