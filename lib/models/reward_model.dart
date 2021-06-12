import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:steps_tracker/helpers/global.dart' as Global;
import 'package:steps_tracker/helpers/helper_class.dart';
import 'package:steps_tracker/models/date_steps_model.dart';

class Reward
{
    int id;
    String title;
    String partner;
    int requiredPoints;
    String coupon;
    static CollectionReference rewardsCol = FirebaseFirestore.instance.collection("rewards");
    static DocumentReference userDoc = FirebaseFirestore.instance.collection("users").doc(Global.auth.currentUser.uid);

    Reward({this.id,this.title,this.partner,this.requiredPoints,this.coupon});

    factory Reward.fromMap(Map<String,dynamic> map)
        => Reward(id: map["id"],title: map["title"],partner: map["partner"],requiredPoints: map["required_points"],coupon: map["coupon"]);

    static Future<List<Reward>> listenForRewards() async
    {
        List<Reward> rewards = [];
        await rewardsCol.orderBy("required_points",descending: false).get().then((value) {
            value.docs.forEach((element) {
                Map<String,dynamic> data = element.data();
                if(data.containsKey("id")) {
                    rewards.add(Reward.fromMap(data));
                }
            });
        });
        return rewards;
    }

    static Future<bool> exchangePoints(Reward reward) async
    {
        bool result = true;
        var data = {
            "date": DateFormat("dd-MM-yyyy").format(DateTime.now()),
            "points": reward.requiredPoints,
            "partner": reward.partner,
            "title": reward.title,
            "reward_id": reward.id
        };
        await userDoc.collection("redemption").doc().set(data).then((value) async {
            await DateSteps.updateTotal();
        }).timeout(Helper.timeout,onTimeout: (){
            result=false;
        }).catchError((error){
            result=false;
        });
        return result;
    }

}