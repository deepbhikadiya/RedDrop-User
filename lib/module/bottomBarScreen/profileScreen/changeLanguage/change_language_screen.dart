import 'package:ft_red_drop/module/bottomBarScreen/profileScreen/changeLanguage/change_language_controller.dart';

import '../../../../components/common_appbar.dart';
import '../../../../package/config_packages.dart';

class ChangeLanguageScreen extends StatelessWidget {
   ChangeLanguageScreen({super.key});

  final changeLanguageController = Get.put<ChangeLanguageController>(ChangeLanguageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        automaticallyImplyLeading: true,
        title: Text(S
            .of(context)
            .change_language, style: const TextStyle().normal16w600.textColor(
            AppColor.blackColor),),
      ),
      backgroundColor: AppColor.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 24),
        child: Column(
          children: [
            const Gap(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                GestureDetector(
                  onTap: (){
                    changeLanguageController.isEnglish.value = true;
                    changeLanguageController.isGujarati.value = false;
                    changeLanguageController.isHindi.value = false;
                    changeLanguageController.changeLanguage();
                    changeLanguageController.update();
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34),
                        color: !changeLanguageController.isEnglish.value?AppColor.whiteColor:AppColor.lightRedColor,
                        // color: AppColor.red50,
                        border: Border.all(
                            width: 2,
                            color: !changeLanguageController.isEnglish.value?AppColor.secondaryColor:AppColor.primaryRed
                        )
                    ),
                    child: Center(
                      child: Text(
                        "English",
                        style: TextStyle(
                            color: !changeLanguageController.isEnglish.value?AppColor.textColor3:AppColor.primaryRed
                        ).normal14w500,
                      ),
                    ),
                  ),
                ),
                const Gap(40),
                GestureDetector(
                  onTap: (){
                    changeLanguageController.isEnglish.value = false;
                    changeLanguageController.isGujarati.value = true;
                    changeLanguageController.isHindi.value = false;
                    changeLanguageController.changeLanguage();
                    changeLanguageController.update();
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34),
                        // color: editProfileController.selectedIndex.value == index?AppColor.red50:AppColor.white,
                        color: !changeLanguageController.isGujarati.value?AppColor.whiteColor:AppColor.lightRedColor,
                        border: Border.all(
                            width: 2,
                            color: !changeLanguageController.isGujarati.value?AppColor.secondaryColor:AppColor.primaryRed
                          // color: editProfileController.selectedIndex.value == index?AppColor.primaryRed:AppColor.gray200
                        )
                    ),
                    child: Center(
                      child: Text(
                        "ગુજરાતી",
                        style: TextStyle(
                            color: !changeLanguageController.isGujarati.value?AppColor.textColor3:AppColor.primaryRed
                        ).normal14w500,
                      ),
                    ),
                  ),
                ),

              ],
            ),
            const Gap(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    changeLanguageController.isEnglish.value = false;
                    changeLanguageController.isGujarati.value = false;
                    changeLanguageController.isHindi.value = true;
                    changeLanguageController.changeLanguage();
                    changeLanguageController.update();
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34),
                        color: !changeLanguageController.isHindi.value?AppColor.whiteColor:AppColor.lightRedColor,
                        // color: AppColor.red50,
                        border: Border.all(
                            width: 2,
                            color: !changeLanguageController.isHindi.value?AppColor.secondaryColor:AppColor.primaryRed
                        )
                    ),
                    child: Center(
                      child: Text(
                        "हिंदी",
                        style: TextStyle(
                            color: !changeLanguageController.isHindi.value?AppColor.textColor3:AppColor.primaryRed
                        ).normal14w500,
                      ),
                    ),
                  ),
                ),
                const Gap(40),
                const SizedBox(
                  height: 120,
                  width: 120,
                )
              ],
            ),
          ],
        ),
      ),

    );
  }
}
