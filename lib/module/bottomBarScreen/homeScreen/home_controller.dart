import 'package:ft_red_drop/package/config_packages.dart';

import '../../../utils/fcm_utils.dart';

class HomeController extends GetxController{
  String getCurrentTime(context){
    RxString currentTime = "".obs;
    if(DateTime.now().hour>=20 || DateTime.now().hour <=6){
      currentTime.value = S.of(context).good_night;
    }
    else if(DateTime.now().hour>=17){
      currentTime.value = S.of(context).good_evening;
    }
    else if(DateTime.now().hour>=12){
      currentTime.value = S.of(context).good_afternoon;
    }
    else{
      currentTime.value = S.of(context).good_morning;

    }
    return currentTime.value;
  }

  RxInt currentPageIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    FCMUtils.instance.checkHasAnyInitialMessage();

  }
}