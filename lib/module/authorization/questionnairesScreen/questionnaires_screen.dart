import 'package:ft_red_drop/app_route.dart';
import 'package:ft_red_drop/components/buttons.dart';
import 'package:ft_red_drop/components/common_appbar.dart';
import 'package:ft_red_drop/components/red_drop/common_outer_container.dart';
import 'package:ft_red_drop/components/red_drop/title_subtitle_widget.dart';
import 'package:ft_red_drop/module/authorization/questionnairesScreen/questionnaires_controller.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/utils/app_toast.dart';

class QuestionnairesScreen extends StatelessWidget {
  QuestionnairesScreen({super.key});

  final questionnairesController = Get.put<QuestionnairesController>(QuestionnairesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(automaticallyImplyLeading: false),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // const Gap(20),
              TitleSubTitleWidget(
                title: S.of(context).questionnaires,
                subTitle: S.of(context).fill_up_the_questionnaires,
                gap: 10,
              ),
              _buildQuestionList(),
              const Gap(20),
              Obx(
                () => CommonAppButton(
                  buttonType: questionnairesController.answerList.any((element) => element.isEmpty) ? ButtonType.disable : ButtonType.enable,
                  text: S.of(context).continue_,
                  onTap: () {
                    bool inValid = questionnairesController.answerList.any((element) => element == 'Yes');
                    if (inValid) {
                      showAppToast(S.of(context).you_cannot_donate_as_per_questionnaires);
                    } else {
                      showAppToast(S.of(context).register_successFully);

                      Get.offAllNamed(AppRouter.loginScreen);
                    }
                  },
                ),
              ),
              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return const Gap(20);
      },
      itemCount: questionnairesController.questionsList.length,
      itemBuilder: (context, index) {
        return CommonOuterContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  questionnairesController.questionsList[index],
                  style: const TextStyle().normal16w600.textColor(AppColor.textColor2),
                ),
                Row(
                  children: [
                    Text.rich(TextSpan(style: const TextStyle().normal16w600.textColor(AppColor.textColor2), children: [
                      WidgetSpan(
                          child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Obx(
                          () => Radio(
                            value: S.of(context).yes,
                            groupValue: questionnairesController.answerList[index],
                            onChanged: (value) {
                              questionnairesController.answerList[index] = value;
                            },
                            activeColor: AppColor.primaryRed,
                          ),
                        ),
                      )),
                      TextSpan(text: S.of(context).yes, style: const TextStyle().normal16w600.textColor(AppColor.textColor2))
                    ])),
                    const Gap(30),
                    Text.rich(TextSpan(style: const TextStyle().normal16w600.textColor(AppColor.textColor2), children: [
                      WidgetSpan(
                          child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Obx(
                          () => Radio(
                            value: S.of(context).no,
                            groupValue: questionnairesController.answerList[index],
                            onChanged: (value) {
                              questionnairesController.answerList[index] = value;
                            },
                            activeColor: AppColor.primaryRed,
                          ),
                        ),
                      )),
                      TextSpan(text: S.of(context).no, style: const TextStyle().normal16w600.textColor(AppColor.textColor2))
                    ]))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
