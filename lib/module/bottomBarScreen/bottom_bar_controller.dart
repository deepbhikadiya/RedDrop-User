import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ft_red_drop/data/pref/app_preferences.dart';
import 'package:ft_red_drop/global_controller.dart';
import 'package:ft_red_drop/module/bottomBarScreen/feedScreen/feed_screen.dart';
import 'package:ft_red_drop/module/bottomBarScreen/homeScreen/home_screen.dart';
import 'package:ft_red_drop/module/bottomBarScreen/profileScreen/profile_screen.dart';
import 'package:ft_red_drop/module/bottomBarScreen/rewardScreen/reward_screen.dart';
import 'package:ft_red_drop/utils/fcm_utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController{

  RxList<Widget> pages = <Widget>[
    const HomeScreen(),
    const FeedScreen(),
    const HomeScreen(),
    RewardScreen(),
     ProfileScreen(),
  ].obs;

  Future<void> setFCMToken() async {
    String? token = await FCMUtils.instance.getToken();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(AppPref().userId)
        .update({
      "fcm_token": token
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Get.find<GlobalController>().getUserData();
    Geolocator.requestPermission();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
     await  setFCMToken();

    });
  }
}