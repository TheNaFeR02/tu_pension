import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tu_pension/constants.dart';
import 'package:tu_pension/data/model/Product.dart';
import 'package:tu_pension/size_config.dart';
import 'package:tu_pension/ui/components/default_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:tu_pension/ui/screens/chat/chat_screen.dart';

// class Body extends StatelessWidget {
//   final Product product;

//   const Body({Key? key, required this.product}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         ProductImages(product: product),
//         TopRoundedContainer(
//           color: Colors.white,
//           child: Column(
//             children: [
//               ProductDescription(
//                 product: product,
//                 pressOnSeeMore: () {},
//               ),
//               TopRoundedContainer(
//                 color: Color(0xFFF6F7F9),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                         left: SizeConfig.screenWidth * 0.15,
//                         right: SizeConfig.screenWidth * 0.15,
//                         bottom: getProportionateScreenWidth(15),
//                         top: getProportionateScreenWidth(15),
//                       ),
//                       child: TextButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, '/chat');
//                         },
//                         child: Text(
//                           "Ver comentarios",
//                           style: TextStyle(
//                             fontSize: getProportionateScreenWidth(15),
//                             color: kPrimaryColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                     // ColorDots(product: product),

//                     TopRoundedContainer(
//                       color: Colors.white,
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                           left: SizeConfig.screenWidth * 0.15,
//                           right: SizeConfig.screenWidth * 0.15,
//                           bottom: getProportionateScreenWidth(40),
//                           top: getProportionateScreenWidth(15),
//                         ),
//                         child: DefaultButton(
//                           text: "Contactar al anunciante",
//                           press: () {
//                             startChat(context);
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

  // void startChat(BuildContext context) async {
  //   String userUid = FirebaseAuth.instance.currentUser!.uid;
  //   String sellerUid = product.sellerUid;
  //   print('userUid: $userUid');
  //   String chatId = 'chat_${userUid}_${sellerUid}';

  //   bool chatExists = await _checkIfChatExists(chatId);

  //   if (!chatExists) {
  //     await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
  //       'participants': [userUid, sellerUid],
  //       'productTitle': product.title,
  //       'unreadMessages': {
  //         userUid: 0,
  //         sellerUid: 0,
  //       },
  //     });
  //   }

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ChatScreen(
  //         chatId: chatId,
  //         productTitle: product.title,
  //       ),
  //     ),
  //   );
  // }

  // Future<bool> _checkIfChatExists(String chatId) async {
  //   var chatDocument =
  //       await FirebaseFirestore.instance.collection('chats').doc(chatId).get();
  //   return chatDocument.exists;
  // }
// }
