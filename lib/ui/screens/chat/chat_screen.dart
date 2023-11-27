import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:tu_pension/constants.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String productTitle;

  ChatScreen({required this.chatId, required this.productTitle});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.chatId)
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message =
                        messages[index].data() as Map<String, dynamic>;
                    var messageSender = message['sender'] ?? '';
                    var messageText = message['message'] ?? '';
                    var imageUrl = message['imageUrl'] ?? '';

                    return _buildMessage(messageSender, messageText, imageUrl);
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessage(String sender, String text, String imageUrl) {
    bool isCurrentUser = sender == FirebaseAuth.instance.currentUser!.uid;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isCurrentUser ? kPrimaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   sender,
            //   style: TextStyle(
            //     color: isCurrentUser ? Colors.white : Colors.black,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            if (imageUrl.isNotEmpty) SizedBox(height: 5.0),
            if (imageUrl.isNotEmpty)
              Image.network(
                imageUrl,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            if (imageUrl.isNotEmpty) SizedBox(height: 5.0),
            Text(
              text,
              style:
                  TextStyle(color: isCurrentUser ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {
              _pickImage();
            },
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Escribe un mensaje...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  void _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      _uploadImage(imageFile);
    }
  }

  void _uploadImage(File imageFile) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    String chatId = widget.chatId;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('chat_images/$userUid/$chatId/$fileName.jpg');
    UploadTask uploadTask = storageReference.putFile(imageFile);

    await uploadTask.whenComplete(() {});

    String imageUrl = await storageReference.getDownloadURL();

    _sendMessage(imageUrl: imageUrl);
  }

  void _sendMessage({String? imageUrl}) async {
    String message = _messageController.text.trim();
    if (message.isNotEmpty || imageUrl != null) {
      String userUid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .collection('messages')
          .add({
        'sender': userUid,
        'message': message,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _messageController.clear();
      // Incrementa el contador de mensajes no leídos del destinatario
      _resetUnreadMessages();
      _incrementUnreadMessages();

      // Hacer scroll hacia el último mensaje
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _incrementUnreadMessages() {
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .get()
        .then((chatDocument) {
      var participants = chatDocument['participants'];
      participants.remove(userUid);
      String otherUserUid = participants[0];

      FirebaseFirestore.instance.collection('chats').doc(widget.chatId).update({
        'unreadMessages.$otherUserUid': FieldValue.increment(1),
      });
    });
  }

  void _resetUnreadMessages() {
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .get()
        .then((chatDocument) {
      FirebaseFirestore.instance.collection('chats').doc(widget.chatId).update({
        'unreadMessages.$userUid': 0,
      });
    });
  }
}
