import 'package:ft_red_drop/package/config_packages.dart';

class QuestionnairesController extends GetxController{

  RxList questionsList = [
    S.of(Get.context!).do_you_have_diabetes,
    S.of(Get.context!).ever_have_lung_problem,
    S.of(Get.context!).last_28_day_have_covid,
    S.of(Get.context!).have_you_ever_positive_aids,
    S.of(Get.context!).have_cancer,
    S.of(Get.context!).last_3_month_vaccine,
  ].obs;
  RxList answerList = [].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    answerList.value = List.generate(questionsList.length, (index) => "");
  }
}