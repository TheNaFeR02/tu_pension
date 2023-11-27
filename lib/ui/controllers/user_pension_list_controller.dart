import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:tu_pension/data/model/UserPension.dart';

class UserPensionListController extends GetxController {
  var _userPensions = <UserPension>[].obs;

  get userPensions => _userPensions;

  final databaseRef = FirebaseDatabase.instance.ref();

  late StreamSubscription<DatabaseEvent> newEntryStreamSubscription;

  late StreamSubscription<DatabaseEvent> updateEntryStreamSubscription;

  void start() {
    _userPensions.clear();

    newEntryStreamSubscription =
        databaseRef.child("userPensions").onChildAdded.listen(_onEntryAdded);

    // updateEntryStreamSubscription =
    //     databaseRef.child("userList").onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(DatabaseEvent event) {
    final json = event.snapshot.value as Map<dynamic, dynamic>;
    _userPensions.add(UserPension.fromJson(event.snapshot, json));
  }

  void stop() {
    newEntryStreamSubscription.cancel();
    updateEntryStreamSubscription.cancel();
  }

  Future<void> createPension(Uid, email, title, description, price, images) async {
    logInfo("Creating a pension in realTime with data: $title, $description, $price, $images");
    try {
      await databaseRef
          .child('userPensions')
          .push()
          .set({
            "uid": Uid,
            "email": email,
            "title": title,
            "description": description,
            "price": price,
            "images": images,});
    } catch (error) {
      logError(error);
      return Future.error(error);
    }
  }
}
