import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:steps_tracker/helpers/helper_class.dart';
import 'package:steps_tracker/helpers/global.dart' as Global;
import 'package:steps_tracker/views/main_layout/main_tabview.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class LoginController extends ControllerMVC
{
    GlobalKey<ScaffoldState> scaffoldKey;
    PageController pController;
    TextEditingController pseudoNameController;
    ImagePicker imagePicker = ImagePicker();
    DocumentReference userDoc;
    File chosenImage;
    bool wait = false;
    int currentIndex = 0;
    String uid;
    User user;

    LoginController()
    {
        this.scaffoldKey = GlobalKey<ScaffoldState>();
        pController = PageController();
        pseudoNameController = TextEditingController();
    }

    Future<void> signIn() async
    {
        setState(()=>wait=true);
        await Global.auth.signInAnonymously().then((UserCredential value){
            user = value.user;
            uid = user.uid;
            setState(()=>wait=true);
            pController.animateToPage(1, curve: Curves.easeInOutCubic,duration: Duration(milliseconds: 500));
            setState(() {
                currentIndex = 1;
            });
        }).timeout(Helper.timeout,onTimeout:(){
            Helper.showError(this.scaffoldKey.currentState.context,"verify_internet_connection",Duration(seconds:10));
        }).catchError((error){
            Helper.showErrorString(this.scaffoldKey.currentState.context,error.toString(),Duration(seconds:10));
        });
        setState(()=>wait=false);
    }

    Future<void> finishSignIn() async
    {
        String imgURL = chosenImage != null ? await uploadImageToFirebaseStorage() : null;
        setState(()=>wait=true);
        await user.updateDisplayName(pseudoNameController.text);
        await user.updatePhotoURL(imgURL).timeout(Helper.timeout,onTimeout:(){
            setState(()=>wait=true);
            Helper.showError(this.scaffoldKey.currentState.context,"verify_internet_connection",Duration(seconds:10));
        }).catchError((error){
            setState(()=>wait=true);
            Helper.showErrorString(this.scaffoldKey.currentState.context,error.toString(),Duration(seconds:10));
        }).then((value) async {
            userDoc = FirebaseFirestore.instance.collection("users").doc(uid);
            Map<String,dynamic> userData = {
                'uid': uid,
                'display_name': pseudoNameController.text,
                'total_steps': 0,
                'current_health_points':0,
                'created_at': DateTime.now()
            };
            userDoc.set(userData).then((value){
                setState(()=>wait=false);
                Navigator.of(this.scaffoldKey.currentState.context).pushReplacement(MaterialPageRoute(
                    builder: (context) => MainTabView()
                ));
            }).timeout(Helper.timeout,onTimeout: (){
                setState(()=>wait=false);
                Helper.showError(this.scaffoldKey.currentState.context,"verify_internet_connection".toString(),Duration(seconds:10));
            }).catchError((error){
                setState(()=>wait=false);
                Helper.showErrorString(this.scaffoldKey.currentState.context,error.toString(),Duration(seconds:10));
            });
        });
    }

    Future chooseImage() async {
        final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
        if(pickedFile!=null)
        {
            setState(() => chosenImage = File(pickedFile.path));
        }
    }

    Future<String> uploadImageToFirebaseStorage() async {
        setState(()=>wait=true);
        String imgURL;
        String fileName = "profile_img_"+uid;
        firebase_storage.Reference firebaseStorageRef = firebase_storage.FirebaseStorage.instance
            .ref().child('uploads/$fileName');
        firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(chosenImage);
        TaskSnapshot taskSnapshot = await uploadTask;
        await taskSnapshot.ref.getDownloadURL().then((value)=>imgURL = value)
            .timeout(Helper.timeout,onTimeout: (){
                Helper.showError(this.scaffoldKey.currentState.context,"verify_internet_connection",Duration(seconds:10));
                return null;
        }).catchError((error){
            Helper.showErrorString(this.scaffoldKey.currentState.context,error.toString(),Duration(seconds:10));
        });
        setState(()=>wait=false);
        return imgURL;
    }

}