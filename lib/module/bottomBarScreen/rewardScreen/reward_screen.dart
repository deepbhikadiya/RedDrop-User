import 'package:ft_red_drop/components/common_appbar.dart';
import 'package:ft_red_drop/components/red_drop/common_outer_container.dart';
import 'package:ft_red_drop/module/bottomBarScreen/rewardScreen/reward_controller.dart';
import 'package:ft_red_drop/package/config_packages.dart';

class RewardScreen extends StatefulWidget {
  RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  final rewardController = Get.put<RewardController>(RewardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        automaticallyImplyLeading: false,
        title: Text(S
            .of(context)
            .rewards_points, style: const TextStyle().normal16w600.textColor(
            AppColor.blackColor),),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                S
                    .of(context)
                    .badge,
                style: const TextStyle().normal18w600,
              ),
            ),
            _buildBadgesInfo(context),
            _buildBadge(context),
            const Gap(100),
          ],
        ),
      ),
    );
  }
  List<String> bannerImages = [
    AppImage.rewardBanner1,
    AppImage.rewardBanner2,
    AppImage.rewardBanner3,
  ];

  // Controller for the PageView
  final PageController _pageController = PageController();

  // Index to keep track of current page
  int _currentIndex = 1; // Start at the second page to create loop effect

  // Timer for automatic image transition
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer to automatically change the banner image every 2 seconds
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    // Dispose of the timer and page controller when the widget is disposed
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }
  _buildBanner() {
    return Container(
      height: 200,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        itemCount: bannerImages.length + 2, // Add 2 for the loop effect
        itemBuilder: (context, index) {
          if (index == 0) {
            // First page is a duplicate of the last image
            return buildBannerImage(bannerImages[bannerImages.length - 1]);
          } else if (index == bannerImages.length + 1) {
            // Last page is a duplicate of the first image
            return buildBannerImage(bannerImages[0]);
          } else {
            // Regular images
            return buildBannerImage(bannerImages[index - 1]);
          }
        },
        onPageChanged: (index) {
          // Update current index when page changes
          setState(() {
            _currentIndex = index;
          });
          // If we reach the first or last duplicated image, jump to the corresponding original image
          if (index == 0) {
            _pageController.jumpToPage(bannerImages.length);
          } else if (index == bannerImages.length + 1) {
            _pageController.jumpToPage(1);
          }
        },
      ),
    );
  }

  Widget buildBannerImage(String imageUrl) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: Image.asset(
        imageUrl,
        key: ValueKey<String>(imageUrl),
        fit: BoxFit.fitWidth,
        height: 200,
        width: double.infinity,
      ),
    );
  }

  _buildBadgesInfo(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          CommonOuterContainer(
            topLeftCorner: 40,
            bottomLeftCorner: 40,
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 28,
                  backgroundColor: AppColor.primaryRed,
                  child: Image.asset(AppImage.donator, height: 30,),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S
                            .of(context)
                            .donator,
                        style: const TextStyle().normal14w600.textColor(
                            AppColor.primaryRed),
                      ),
                      Text(
                        "${S
                            .of(context)
                            .you_have_to_save} 3 ${S
                            .of(context)
                            .life_to_get_badge}",
                        style: const TextStyle().normal12w600.textColor(
                            AppColor.textColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          CommonOuterContainer(
            topLeftCorner: 40,
            bottomLeftCorner: 40,
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 28,
                  backgroundColor: AppColor.primaryRed,
                  child: Image.asset(AppImage.savior, height: 100,),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S
                            .of(context)
                            .life_savior,
                        style: const TextStyle().normal14w600.textColor(
                            AppColor.primaryRed),
                      ),
                      Text(
                        "${S
                            .of(context)
                            .you_have_to_save} 5 ${S
                            .of(context)
                            .life_to_get_badge}",
                        style: const TextStyle().normal12w600.textColor(
                            AppColor.textColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          CommonOuterContainer(
            topLeftCorner: 40,
            bottomLeftCorner: 40,
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 28,
                  backgroundColor: AppColor.primaryRed,
                  child: Image.asset(
                    AppImage.superhero, height: 100, fit: BoxFit.fill,),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S
                            .of(context)
                            .superhero,
                        style: const TextStyle().normal14w600.textColor(
                            AppColor.primaryRed),
                      ),
                      Text(
                        "${S
                            .of(context)
                            .you_have_to_save} 10 ${S
                            .of(context)
                            .life_to_get_badge}",
                        style: const TextStyle().normal12w600.textColor(
                            AppColor.textColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildBadge(context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            rewardController.rewardCount.value == 0 ?
            FittedBox(
              child: Text(
                S
                    .of(context)
                    .donate_blood_to_save_life_and_become_superhero,
                style: const TextStyle().normal13w600.textColor(AppColor.textColor2),
              ),
            )
                : FittedBox(
              child: Text(
                "${S
                    .of(context)
                    .you_have_saved} ${rewardController.rewardCount.value.toStringAsFixed(0)} ${S
                    .of(context)
                    .valuable_life_till_now}",
                style: const TextStyle().normal13w600.textColor(AppColor.textColor2),
              ),
            ),
            const Gap(15),
            LinearProgressIndicator(
              value: rewardController.rewardCount.value / 10,
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
              color: AppColor.primaryRed,
            ),
            const Gap(15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S
                            .of(context)
                            .donator,
                        style:
                        rewardController.rewardCount.value > 2 &&
                            rewardController.rewardCount.value < 5
                            ?
                        const TextStyle().normal14w600.textColor(AppColor.blackColor)
                            :
                        const TextStyle().normal10w500.textColor(AppColor.textColor3),
                      ),
                      const Gap(10),
                      Stack(
                        children: [
                          CircleAvatar(
                            maxRadius: rewardController.rewardCount.value > 2 &&
                                rewardController.rewardCount.value < 5
                                ? 30
                                : 20,
                            backgroundColor: AppColor.primaryRed,
                            child: Image.asset(AppImage.donator,
                              height: rewardController.rewardCount.value > 3 &&
                                  rewardController.rewardCount.value < 5
                                  ? 40
                                  : 30,),
                          ),
                          Visibility(
                            visible: rewardController.rewardCount.value < 2 ||
                                rewardController.rewardCount.value > 5,
                            child: CircleAvatar(
                              maxRadius: rewardController.rewardCount.value >
                                  2 && rewardController.rewardCount.value < 5
                                  ? 30
                                  : 20,
                              backgroundColor: Colors.black12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(

                    children: [
                      Text(
                        S
                            .of(context)
                            .life_savior,
                        style:
                        rewardController.rewardCount.value > 4 &&
                            rewardController.rewardCount.value < 5
                            ?
                        const TextStyle().normal14w600.textColor(AppColor.blackColor)
                            :
                        const TextStyle().normal10w500.textColor(AppColor.textColor3),
                      ),
                      const Gap(10),
                      Stack(
                        children: [
                          CircleAvatar(
                            maxRadius: rewardController.rewardCount.value > 4 &&
                                rewardController.rewardCount.value < 10
                                ? 30
                                : 20,
                            backgroundColor: AppColor.primaryRed,
                            child: Image.asset(AppImage.savior, height: 100,),
                          ),
                          Visibility(
                            visible: rewardController.rewardCount.value < 4 ||
                                rewardController.rewardCount.value > 10,
                            child: CircleAvatar(
                              maxRadius: rewardController.rewardCount.value >
                                  4 && rewardController.rewardCount.value < 10
                                  ? 30
                                  : 20,
                              backgroundColor: Colors.black12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Text(
                        S
                            .of(context)
                            .superhero,
                        style:
                        rewardController.rewardCount.value > 9
                            ?
                        const TextStyle().normal14w600.textColor(AppColor.blackColor)
                            :
                        const TextStyle().normal10w500.textColor(AppColor.textColor3),
                      ),
                      const Gap(10),
                      Stack(
                        children: [
                          CircleAvatar(
                            maxRadius: rewardController.rewardCount.value > 9
                                ? 30
                                : 20,
                            backgroundColor: AppColor.primaryRed,
                            child: Image.asset(
                              AppImage.superhero, height: 100,),
                          ),
                          Visibility(
                            visible: rewardController.rewardCount.value < 9,
                            child: CircleAvatar(
                              maxRadius: rewardController.rewardCount.value > 9
                                  ? 30
                                  : 20,
                              backgroundColor: Colors.black12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            )
          ],
        ),
      );
    });
  }
}
