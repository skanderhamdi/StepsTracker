import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser
{
    String uid;
    String pseudoName;
    int totalStepsCount;
    Timestamp signUpDate;
    static CollectionReference usersCol = FirebaseFirestore.instance.collection("users");

    AppUser({this.uid,this.pseudoName,this.totalStepsCount,this.signUpDate});
    factory AppUser.fromMap(Map<String,dynamic> map)
        => AppUser(uid: map["uid"],pseudoName: map["display_name"],totalStepsCount: map["total_steps"],signUpDate: map["created_at"]);


    static Future<List<AppUser>> listenForLeaderBoard() async
    {
        List<AppUser> users = [];
        await usersCol.orderBy("total_steps",descending: true).get().then((value){
            value.docs.forEach((element){
                Map<String,dynamic> data = element.data();
                if(data.containsKey("uid"))
                {
                    users.add(AppUser.fromMap(data));
                }
            });
        });
        return users;
    }

}