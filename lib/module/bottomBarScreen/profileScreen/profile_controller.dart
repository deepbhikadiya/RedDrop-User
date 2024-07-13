import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ft_red_drop/global_controller.dart';
import 'package:ft_red_drop/package/config_packages.dart';

class ProfileController extends GetxController{

  updateAvailableStatus()async{
    await FirebaseFirestore.instance
        .collection("users")
        .doc(AppPref().userId)
        .update({
      "is_available": Get.find<GlobalController>().userData.value.isAvailable
    });
  }
}