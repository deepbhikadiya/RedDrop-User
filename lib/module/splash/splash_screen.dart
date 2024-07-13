import 'package:ft_red_drop/module/splash/splash_controller.dart';

import '../../package/config_packages.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashController = Get.put<SplashController>(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Image.asset(
                AppImage.appLogo,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
