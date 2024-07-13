import 'package:ft_red_drop/app_route.dart';
import 'package:ft_red_drop/module/bottomBarScreen/bottom_bar_controller.dart';
import 'package:ft_red_drop/module/bottomBarScreen/rewardScreen/reward_controller.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import '../../components/red_drop/bottom_bar_icon.dart';
import '../../global_controller.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final bottomBarController = Get.put<BottomBarController>(BottomBarController());
  final scaffoldState = GlobalKey<ScaffoldState>();
  final globalController = Get.find<GlobalController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // backgroundColor: AppColor.black,
      body: Obx(
            () => IndexedStack(
              index: globalController.selectedIndex.value,
              children: bottomBarController.pages,
            ),
      ),
      bottomNavigationBar: Obx(
        ()=> Theme(
          data: ThemeData(
              useMaterial3: false
          ),
          child: StylishBottomBar(
            option: AnimatedBarOptions(
              // iconSize: 32,
              barAnimation: BarAnimation.fade,
              iconStyle: IconStyle.Default,
            ),
              currentIndex: globalController.selectedIndex.value,
              elevation: 20,
              onTap: (val){
                globalController.selectedIndex.value = val;
                if(val == 3){
                  Get.find<RewardController>().rewardCount.value = (Get.find<GlobalController>().userData.value.stars??0)/25;
                }
              },
            fabLocation: StylishBarFabLocation.center,
            hasNotch: true,
              items: [
                BottomBarItem(
                  title: Text(S.of(context).home,style: const TextStyle().normal12w600),
                  selectedColor: AppColor.primaryRed,
                  icon: const CommonAppIcon(
                    image: AppImage.homeUncheck,
                  ),
                  selectedIcon:  const CommonAppIcon(
                    image: AppImage.homeCheck,
                  ),

                ),
                BottomBarItem(
                  title: Text(S.of(context).feed,style: const TextStyle().normal12w600),
                  selectedColor: AppColor.primaryRed,
                  icon: const CommonAppIcon(
                    image: AppImage.feedUncheck,
                  ),

                  selectedIcon:const CommonAppIcon(
                    image: AppImage.feedCheck,
                  ),
                ),
                BottomBarItem(
                  title: const Text(""),
                  selectedColor: AppColor.whiteColor,
                  icon: const Text(""),

                  selectedIcon:const Text(""),
                ),
                BottomBarItem(
                  title: Text(S.of(context).rewards,style: const TextStyle().normal12w600),
                  selectedColor: AppColor.primaryRed,
                  icon: const CommonAppIcon(
                    image: AppImage.rewardUncheck,
                  ),
                  selectedIcon: const CommonAppIcon(
                    image: AppImage.rewardCheck,
                  ),
                ),
                BottomBarItem(
                  title: Text(S.of(context).profile,style: const TextStyle().normal12w600),
                  selectedColor: AppColor.primaryRed,
                  icon: const CommonAppIcon(
                    image: AppImage.profileUncheck,
                  ),
                  selectedIcon: const CommonAppIcon(
                    image: AppImage.profileCheck,
                  ),
                ),
              ],
            ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Theme(
        data: ThemeData(
          useMaterial3: false,
        ),
        child: FloatingActionButton(
          backgroundColor: AppColor.primaryRed,
          elevation: 0,
          onPressed: () {
            Get.toNamed(AppRouter.createRequestScreen);
          },
          child: const Center(
            child: CommonAppIcon(
              image: AppImage.dropIcon,
              height: 28,
              width: 28,
            ),
          ),
        ),
      ),
    );
  }


}



