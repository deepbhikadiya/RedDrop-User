import 'package:ft_red_drop/package/config_packages.dart';

class ChangeLanguageController extends GetxController{
  RxBool isEnglish = false.obs;
  RxBool isHindi = false.obs;
  RxBool isGujarati = false.obs;

  changeLanguage() async {
    if (isEnglish.value) {
      Get.updateLocale(const Locale('en', ''));
      AppPref().languageCode = Get.locale?.languageCode ?? '';
    }
    else if (isHindi.value) {
      Get.updateLocale(const Locale('hi', ''));
      AppPref().languageCode = Get.locale?.languageCode ?? '';
    } else if (isGujarati.value) {
      Get.updateLocale(const Locale('gu', ''));
      AppPref().languageCode = Get.locale?.languageCode ?? '';
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    switch(AppPref().languageCode){
      case 'en':
        isEnglish.value = true;
        break;
      case 'hi':
        isHindi.value = true;
        break;
      case 'gu':
        isGujarati.value = true;
        break;
    }
  }

}