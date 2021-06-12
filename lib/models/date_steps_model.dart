import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:steps_tracker/helpers/global.dart' as Global;

class DateSteps {
    String date;
    int stepsCount;
    int healthPoints;
    static DocumentReference userDoc = FirebaseFirestore.instance.collection("users").doc(Global.auth.currentUser.uid);

    DateSteps({this.date, this.stepsCount, this.healthPoints});

    factory DateSteps.fromMap(Map<String, dynamic> map) => DateSteps(date: map["date"],
            stepsCount: map["steps"],
            healthPoints: map["health_points"]);

    static void listenForHealthPoints() {
        userDoc.get().then((value) {
            Map<String,dynamic> data = value.data();
            Global.currentHealthPoints.value = data["current_health_points"];
            // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
            Global.currentHealthPoints.notifyListeners();
        });
    }

    static Future<void> updateTotal() async
    {
        int totalSteps = 0;
        int totalPoints = 0;
        int redeemed = 0;
        await userDoc.collection("steps").get().then((value) {
            value.docs.forEach((element) {
                var data = element.data();
                totalSteps += data["steps"];
                totalPoints += data["health_points"];
            });
        });
        await userDoc.collection("redemption").get().then((value) {
            value.docs.forEach((element) {
                var data = element.data();
                redeemed += data["points"];
            });
        });
        userDoc.update({'current_health_points': totalPoints-redeemed, 'total_steps': totalSteps});
    }

    static Future<List<DateSteps>> listenForHistory() async
    {
        DateFormat formatter = DateFormat("dd/MM/yyyy");
        String formattedDate = formatter.format(DateTime.now());
        List<DateSteps> history = [];
        await userDoc.collection("steps").orderBy("steps",descending: true).get().then((value) {
            value.docs.forEach((element) {
                var data = element.data();
                if(data.containsKey("steps") && data["date"] != formattedDate) {
                    history.add(DateSteps.fromMap(data));
                }
            });
        });
        return history;
    }

}