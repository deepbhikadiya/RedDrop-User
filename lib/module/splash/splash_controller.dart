import 'package:firebase_auth/firebase_auth.dart';
import 'package:ft_red_drop/app_route.dart';
import 'package:ft_red_drop/data/pref/app_preferences.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/app_toast.dart';

class SplashController extends GetxController {
  goNextScreen() {
    3.delay(() {
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offAllNamed(AppRouter.bottomBarScreen);
      } else if(AppPref().isFirstTime) {
        Get.offAllNamed(AppRouter.onBoardingScreen);
      } else {
        Get.offAllNamed(AppRouter.loginScreen);
      }
    });
  }

  void requestPermissions() async {
    PermissionStatus permissionStatus = await Permission.notification.request();
    if (permissionStatus.isGranted) {
    } else {
      showAppToast("You will no longer receive notifications.");
    }
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    goNextScreen();
    requestPermissions();
  }
}
