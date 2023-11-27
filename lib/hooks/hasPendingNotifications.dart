import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> hasPendingNotifications() async {
  try {
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    // Obtén los chats en los que el usuario está participando
    QuerySnapshot chatSnapshot = await FirebaseFirestore.instance
        .collection('chats')
        .where('participants', arrayContains: userUid)
        .get();

    // Itera sobre los chats y verifica si hay notificaciones pendientes
    for (QueryDocumentSnapshot chatDocument in chatSnapshot.docs) {
      Map<String, dynamic> chatData =
          chatDocument.data() as Map<String, dynamic>;

      // Verifica si hay notificaciones pendientes en este chat
      if (chatData.containsKey('unreadMessages')) {
        Map<String, dynamic> unreadMessages = chatData['unreadMessages'];

        // Verifica si el usuario tiene notificaciones pendientes en este chat
        if (unreadMessages.containsKey(userUid) &&
            unreadMessages[userUid] > 0) {
          return true; // Hay notificaciones pendientes
        }
      }
    }

    return false; // No hay notificaciones pendientes
  } catch (error) {
    print('Error al verificar notificaciones: $error');
    return false; // Manejar el error según tus necesidades
  }
}
