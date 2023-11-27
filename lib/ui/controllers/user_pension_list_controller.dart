import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:tu_pension/data/model/Pension.dart';
import 'package:tu_pension/data/model/UserPension.dart';

class UserPensionListController extends GetxController {
  var _userPensions = <Pension>[].obs;

  get userPensions => _userPensions;

  final databaseRef = FirebaseDatabase.instance.ref();

  // late StreamSubscription<DatabaseEvent> newPensionStreamSubscription;
  // late StreamSubscription<DatabaseEvent> updatePensionStreamSubscription;
  late StreamSubscription<DatabaseEvent> readPensionStreamSubscription;

  void startPensions() async {
    // Clear the list when starting to avoid duplicates
    _userPensions.clear();

    // newPensionStreamSubscription =
    //     databaseRef.child("userPensions").onChildAdded.listen(_onPensionAdded);

    // updatePensionStreamSubscription = databaseRef
    //     .child("userPensions")
    //     .onChildChanged
    //     .listen(_onPensionChanged);

    readPensionStreamSubscription =
        databaseRef.child("userPensions").onValue.listen(_onPensionRead);

    // DatabaseReference starCountRef =
    //     FirebaseDatabase.instance.ref('userPensions/');
    // starCountRef.onValue.listen((DatabaseEvent event) {
    //   final data = event.snapshot.value;
    //   updateStarCount(data);
    // });
  }

  // _onPensionRead(DatabaseEvent event) {
  //   final json = event.snapshot.value as Map<dynamic, dynamic>;
  //   print(json);
  // }

  _onPensionRead(DatabaseEvent event) {
    final data = event.snapshot.value as Map<dynamic, dynamic>;

    if (data != null) {
      // Iterate through the map entries
      data.forEach((key, value) {
        final json = value as Map<dynamic, dynamic>;

        // Create a UserPension object from each entry
        Pension userPension = Pension.fromJson(
          event.snapshot,
          json,
        );

        // Add the UserPension to the _userPensions list
        _userPensions.add(userPension);
      });

      // Optionally, you can print the updated _userPensions list
      // print(_userPensions);
    }
  }

  // _onPensionAdded(DatabaseEvent event) {
  //   final json = event.snapshot.value as Map<dynamic, dynamic>;
  //   _userPensions.add(UserPension.fromJson(event.snapshot, json));
  // }

  // _onPensionChanged(DatabaseEvent event) {
  //   var oldPension = _userPensions.singleWhere((pension) {
  //     return pension.key == event.snapshot.key;
  //   });

  //   final json = event.snapshot.value as Map<dynamic, dynamic>;
  //   _userPensions[_userPensions.indexOf(oldPension)] =
  //       UserPension.fromJson(event.snapshot, json);
  // }

  void stopPensions() {
    // newPensionStreamSubscription.cancel();
    // updatePensionStreamSubscription.cancel();
    readPensionStreamSubscription.cancel();
  }

  Future<void> createPension(
      Uid, email, title, description, price, images) async {
    logInfo(
        "Creating a pension in realTime with data: $title, $description, $price, $images");
    try {
      await databaseRef.child('userPensions').push().set({
        "uid": Uid,
        "email": email,
        "title": title,
        "description": description,
        "price": price,
        "images": images,
      });
    } catch (error) {
      logError(error);
      return Future.error(error);
    }
  }
}