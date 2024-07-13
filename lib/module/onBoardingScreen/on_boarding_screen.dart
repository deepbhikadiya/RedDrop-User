import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ft_red_drop/app_route.dart';
import 'package:ft_red_drop/module/onBoardingScreen/on_boarding_controller.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final onBoardingController = Get.put<OnBoardingController>(
      OnBoardingController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Stack(
          children: [
            Column(
              children: [
                const Gap(16),
                Gap(MediaQuery
                    .of(context)
                    .size
                    .height / 20),
                Expanded(
                  child: PageView(
                    controller: onBoardingController.controller,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (val) {
                      onBoardingController.currentPage.value = val;
                      onBoardingController.update();

                    },
                    children: [
                      Column(
                        children: [
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 2.2,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImage.ob1)
                              )
                            ),
                          ),
                          Text(
                            "Easy Donor Search",
                            style: TextStyle().normal20w600.textColor(
                                AppColor.blackColor),
                          ),
                          Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Easy to find available donor nearby. available donor willing to help.",
                              style: TextStyle().normal18w600.textColor(
                                  AppColor.textColor2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Expanded(child: SizedBox())
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 2.2,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppImage.ob2)
                                )
                            ),
                          ),
                          Text(
                            "Find Donor Location",
                            style: TextStyle().normal20w600.textColor(
                                AppColor.blackColor),
                          ),
                          Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Discover donor locations effortlessly. Connect and navigate with ease. Let us simplify your journey.",
                              style: TextStyle().normal18w600.textColor(
                                  AppColor.textColor2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Expanded(child: SizedBox())
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 2.2,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppImage.ob3)
                                )
                            ),
                          ),
                          Text(
                            "Emergency donation",
                            style: TextStyle().normal20w600.textColor(
                                AppColor.blackColor),
                          ),
                          Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "In case of emergency, you can find donor by sending them quick notifications.",
                              style: TextStyle().normal18w600.textColor(
                                  AppColor.textColor2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Expanded(child: SizedBox())
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 40,
              right: 20,
              left: 20,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColor.whiteColor
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (onBoardingController.currentPage.value == 0) {
                          onBoardingController.currentPage.value = 1;
                          onBoardingController.controller.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 300),
                            // Adjust duration as needed
                            curve: Curves
                                .easeInOut, // Choose an animation curve
                          );
                        }
                        else if (onBoardingController.currentPage.value == 1) {
                          onBoardingController.currentPage.value = 2;
                          onBoardingController.controller.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 300),
                            // Adjust duration as needed
                            curve: Curves
                                .easeInOut, // Choose an animation curve
                          );
                        }
                        else {
                          AppPref().isFirstTime = false;
                          Get.offAllNamed(AppRouter.loginScreen);
                        }
                      },
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: AppColor.primaryRed,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.arrow_forward_outlined,
                                color: AppColor.whiteColor),
                          ),
                        ),
                      ),
                    ),
                    Gap(100,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          return Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: onBoardingController.currentPage.value ==
                                1 ||
                                onBoardingController.currentPage.value == 2,
                            child: GestureDetector(
                              onTap: (){
                                if (onBoardingController.currentPage.value == 1) {
                                  onBoardingController.currentPage.value = 0;
                                  onBoardingController.controller.animateToPage(
                                    0,
                                    duration: const Duration(milliseconds: 300),
                                    // Adjust duration as needed
                                    curve: Curves
                                        .easeInOut, // Choose an animation curve
                                  );
                                }
                                else if (onBoardingController.currentPage.value == 2) {
                                  onBoardingController.currentPage.value = 1;
                                  onBoardingController.controller.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 300),
                                    // Adjust duration as needed
                                    curve: Curves
                                        .easeInOut, // Choose an animation curve
                                  );
                                }
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Text(
                                "Prev",
                                style: TextStyle().normal14w600.textColor(
                                    AppColor.textColor2),
                              ),
                            ),
                          );
                        }),
                        SmoothPageIndicator(
                          controller: onBoardingController.controller,
                          count: 3,
                          effect: ColorTransitionEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              activeDotColor: AppColor.primaryRed,
                              dotColor: AppColor.secondaryTextColor,
                              spacing: 4
                          ),
                        ),
                        Obx(() {
                          return Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: onBoardingController.currentPage.value ==
                                0 ||
                                onBoardingController.currentPage.value == 1,
                            child: GestureDetector(
                              onTap: (){
                                  onBoardingController.currentPage.value = 2;
                                  onBoardingController.controller.animateToPage(
                                    2,
                                    duration: const Duration(milliseconds: 300),
                                    // Adjust duration as needed
                                    curve: Curves
                                        .easeInOut, // Choose an animation curve
                                  );

                              },
                              behavior: HitTestBehavior.translucent,
                              child: Text(
                                "Skip",
                                style: TextStyle().normal14w600.textColor(
                                    AppColor.textColor2),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}


