import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steps_tracker/helpers/global.dart' as Global;

class Exchange
{
    int points;
    String partner;
    String title;
    String date;
    static DocumentReference userDoc = FirebaseFirestore.instance.collection("users").doc(Global.auth.currentUser.uid);

    Exchange({this.points,this.partner,this.date,this.title});
    factory Exchange.fromMap(Map<String,dynamic> map)
      => Exchange(points: map["points"], partner: map["partner"], date: map["date"],title: map["title"]);

    static Future<List<Exchange>> listenForExchanges() async
    {
        List<Exchange> exchanges = [];
        await userDoc.collection("redemption").get().then((value) {
            value.docs.forEach((element) {
                var data = element.data();
                exchanges.add(Exchange.fromMap(data));
            });
        });
        return exchanges;
    }

}