import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

FirebaseAuth auth = FirebaseAuth.instance;
ValueNotifier<int> currentHealthPoints = new ValueNotifier(0);
DocumentReference userDoc = FirebaseFirestore.instance.collection("users").doc(auth.currentUser.uid);
/* App life cycle */
AppLifecycleState appState = AppLifecycleState.resumed;

void listenForHealthPoints()
{
    if(auth.currentUser?.uid != null && auth.currentUser?.displayName != null)
      userDoc.snapshots().listen((event){
        currentHealthPoints.value = event.get("current_health_points");
        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        currentHealthPoints.notifyListeners();
      });
}
