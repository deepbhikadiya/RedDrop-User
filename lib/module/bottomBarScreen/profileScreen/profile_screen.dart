import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ft_red_drop/app_route.dart';
import 'package:ft_red_drop/components/common_fun.dart';
import 'package:ft_red_drop/components/red_drop/common_list_tile.dart';
import 'package:ft_red_drop/components/red_drop/common_outer_container.dart';
import 'package:ft_red_drop/components/red_drop/profile_image_widget.dart';
import 'package:ft_red_drop/global_controller.dart';
import 'package:ft_red_drop/module/bottomBarScreen/profileScreen/contact_us.dart';
import 'package:ft_red_drop/module/bottomBarScreen/profileScreen/padf_viewer.dart';
import 'package:ft_red_drop/module/bottomBarScreen/profileScreen/profile_controller.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/utils/app_loader.dart';
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final globalController = Get.find<GlobalController>();
  final profileController = Get.put<ProfileController>(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2.8,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        AppColor.lightRedColor2,
                        AppColor.primaryRed
                      ]
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Gap(30),
                  Obx(
                        () =>
                    globalController.userData.value.image != null ?
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: getImageView(
                          height: 120,
                          width: 120,
                          finalUrl: globalController.userData.value.image ??
                              ""),
                    )
                        : const ProfileImageWidget(
                      image: AppImage.personImage,
                      height: 120,
                      width: 120,
                    ),
                  ),
                  const Gap(10),
                  Obx(() {
                    return Text(
                      "${globalController.userData.value
                          .firstName} ${globalController.userData.value
                          .middleName} ${globalController.userData.value
                          .lastName}",
                      style: const TextStyle().normal18w600.textColor(
                          AppColor.whiteColor),
                    );
                  }),
                  Obx(() {
                    return Text(
                      "${globalController.userData.value.phoneNumber}",
                      style: const TextStyle().normal16w500.textColor(
                          AppColor.whiteColor),
                    );
                  }),
                  const Gap(10),
                  CommonOuterContainer(
                    color: AppColor.whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(() {
                                  return Image.asset(
                                    getBloodImage(
                                        globalController.userData.value
                                            .bloodGroup),
                                    height: 40,
                                    width: 40,
                                  );
                                }),
                                Obx(() {
                                  return Text(
                                    "${getBloodGroup(
                                        globalController.userData.value
                                            .bloodGroup ?? "")} Group",
                                  );
                                })
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(() {
                                  return CircleAvatar(
                                    maxRadius: 22,
                                    backgroundColor: AppColor.primaryRed,
                                    child: Image.asset(
                                      getBadgeImage(globalController.userData
                                          .value.stars ?? 0 / 25),
                                      height: 100,),
                                  );
                                }),
                                Obx(() {
                                  return Text(
                                      "${((globalController.userData
                                          .value.stars ?? 0) / 25).toStringAsFixed(0)} ${S
                                          .of(context)
                                          .life_saved}",
                                      style: const TextStyle().normal14w500.textColor(
                                          AppColor.blackColor)
                                  );
                                })
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(() {
                                  return Text.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(
                                                text: globalController.userData
                                                    .value.stars.toString(),
                                                style: const TextStyle().normal24w600
                                                    .textColor(
                                                    AppColor.primaryRed)
                                            ),
                                            const WidgetSpan(child: SizedBox(
                                              width: 5,
                                            )),
                                            WidgetSpan(child: SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: Image.asset(
                                                  AppImage.starIcon),
                                            ))
                                          ]
                                      )
                                  );
                                }),
                                const Gap(5),
                                Text(
                                    S
                                        .of(context)
                                        .points,
                                    style: const TextStyle().normal14w500.textColor(
                                        AppColor.blackColor)
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Gap(10),
                  CommonListTileWidget(
                    onTap: () {
                      Get.toNamed(AppRouter.editProfileScreen);
                    },
                    title: S
                        .of(context)
                        .edit_profile,
                    icon: Icons.edit,
                  ),
                  const Gap(10),
                  GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.translucent,
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          const Icon(Icons.event_available, color: AppColor
                              .primaryRed,),
                          const Gap(10),
                          Expanded(
                            child: Text(
                              "Available to donate",
                              style: const TextStyle().normal16w600.textColor(
                                AppColor.textColor,
                              ),
                            ),
                          ),
                          Obx(() {
                            return CupertinoSwitch(
                              activeColor: AppColor.primaryRed,
                              value: globalController.userData.value
                                  .isAvailable ?? false,
                              onChanged: (bool value) {
                                globalController.userData.value
                                    .isAvailable =
                                !(globalController.userData.value
                                    .isAvailable!);
                                globalController.userData.refresh();
                                profileController.updateAvailableStatus();
                              },
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                  const Gap(10),
                  CommonListTileWidget(
                    onTap: () {
                      Get.toNamed(AppRouter.historyScreen);
                    },
                    title: S
                        .of(context)
                        .donation_history,
                    icon: Icons.history,
                  ),
                  const Gap(10),
                  CommonListTileWidget(
                    onTap: () {
                      Get.toNamed(AppRouter.changeLanguageScreen);
                    },
                    title: S
                        .of(context)
                        .change_language,
                    icon: Icons.language_rounded,
                  ),
                  const Gap(10),
                  CommonListTileWidget(
                    onTap: () {
                      Get.to(()=> ContactUs());
                    },
                    title: S
                        .of(context)
                        .contact_us,
                    icon: Icons.contact_mail_sharp,
                  ),
                  const Gap(10),
                  CommonListTileWidget(
                    onTap: () {
                      Get.to(()=>
                          PdfViewer(path: 'asset/about_us.pdf',title: S.of(context).about_us));
                    },
                    title: S
                        .of(context)
                        .about_us,
                    icon: Icons.info,
                  ),
                  const Gap(10),
                  CommonListTileWidget(
                    onTap: () {
                      Get.to(()=>
                          PdfViewer(path: 'asset/terms_and_condition.pdf',title: S.of(context).terms_and_condition));
                    },
                    title: S
                        .of(context)
                        .terms_and_condition,
                    icon: Icons.verified_outlined,
                  ),
                  const Gap(10),
                  CommonListTileWidget(
                    onTap: () {
                      Get.to(()=>
                          PdfViewer(path: 'asset/privacy_policy.pdf',title: S.of(context).privacy_policy));
                    },
                    title: S
                        .of(context)
                        .privacy_policy,
                    icon: Icons.verified_user,
                  ),
                  const Gap(10),

                  CommonListTileWidget(
                    onTap: () {
                      _showDialogLogOut(context);
                    },
                    title: S
                        .of(context)
                        .log_out,
                    icon: Icons.logout_outlined,
                  ),
                  const Gap(100),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDialogLogOut(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(S
              .of(context)
              .log_out,
              style: const TextStyle().normal16w600.textColor(AppColor.blackColor)),
          actions: [
            CupertinoDialogAction(
              child: Text(S
                  .of(context)
                  .cancel, style: const TextStyle().normal14w600.textColor(
                  AppColor.textColor2),),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: Text(S
                  .of(context)
                  .log_out, style: const TextStyle().normal14w600.textColor(
                  AppColor.primaryRed)),
              onPressed: () async {
                showLoader();

                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(AppPref().userId)
                    .update({
                  'fcm_token': "",
                });
                await FirebaseAuth.instance.signOut();
                dismissLoader();
                globalController.selectedIndex.value = 0;

                Get.offAllNamed(AppRouter.loginScreen);
              },
            ),
          ],
        );
      },
    );
  }

}
