import 'package:ft_red_drop/package/config_packages.dart';

class AppImage {
  static const appLogo = "asset/image/app_logo.png";
  static const appLogoJpeg = "asset/image/app_logo.jpeg";

  static const _imagePath = "asset/image/";
  static const bottombar = "asset/image/bottomBar/";
  static const svg = "asset/image/svg/";

  static const homeCheck = "${bottombar}homeCheck.png";
  static const homeUncheck = "${bottombar}homeUncheck.png";
  static const feedCheck = "${bottombar}feedCheck.png";
  static const feedUncheck = "${bottombar}feedUncheck.png";
  static const rewardCheck = "${bottombar}rewardCheck.png";
  static const rewardUncheck = "${bottombar}rewardUncheck.png";
  static const profileCheck = "${bottombar}profileCheck.png";
  static const profileUncheck = "${bottombar}profileUncheck.png";

  static const onBoarding1 = '${_imagePath}onBoarding1.png';
  static const onBoarding2 = '${_imagePath}onBoarding2.png';
  static const ob1 = '${_imagePath}ob1.jpeg';
  static const ob2 = '${_imagePath}ob2.jpeg';
  static const ob3 = '${_imagePath}ob3.jpeg';
  static const profileIcon = '${_imagePath}profile_icon.png';
  static const nationalIdIcon = '${_imagePath}national_id_icon.png';
  static const phoneIcon = '${_imagePath}phone_icon.png';
  static const lockIcon = '${_imagePath}lock_icon.png';
  static const eyeIcon = '${_imagePath}eye_icon.png';
  static const showEyeIcon = '${_imagePath}show_eye_icon.png';
  static const locationIcon = '${_imagePath}location_icon.png';
  static const gpsIcon = '${_imagePath}gps_icon.png';
  static const bottomBar = '${_imagePath}bottomBar.png';
  static const profileImage = '${_imagePath}profileImage.png';
  static const bloodGroup = '${_imagePath}bloodGroup.png';
  static const shareIcon = '${_imagePath}share_icon.png';
  static const starIcon = '${_imagePath}star_icon.png';
  static const editIcon = '${_imagePath}edit_icon.png';
  static const mapImage = '${_imagePath}map_img.png';
  static const personImage = '${_imagePath}person.jpeg';
  static const a1 = '${_imagePath}1.png';
  static const a2 = '${_imagePath}2.png';
  static const a3 = '${_imagePath}3.png';
  static const calendarIcon = '${_imagePath}calendar_icon.png';
  static const dropIcon = '${_imagePath}drop_icon.png';
  static const modalSheetLine = '${_imagePath}modalSheetLine.png';
  static const femaleIcon = '${_imagePath}female_icon.png';
  static const maleIcon = '${_imagePath}male_icon.png';
  static const flagIcon = '${_imagePath}flag_icon.png';
  static const directionIcon = '${_imagePath}direction_icon.png';
  static const googleMap = '${_imagePath}google_map.png';
  static const notification = '${_imagePath}notification.png';
  static const appleMap = '${_imagePath}apple_map.jpg';
  static const permissionImage = '${_imagePath}permission_image.png';
  static const referralCode = '${_imagePath}referral_code.png';
  static const rectangle = '${_imagePath}rectangle.png';
  static const check = '${_imagePath}check.png';
  static const topRated = '${_imagePath}topRated.png';
  static const goodBehavior = '${_imagePath}goodBehavior.png';
  static const rewardLogo = '${_imagePath}rewardLogo.jpg';
  static const donator = '${_imagePath}donator.png';
  static const savior = '${_imagePath}savior.png';
  static const superhero = '${_imagePath}superhero.png';
  static const rewardBanner1 = '${_imagePath}rb1.png';
  static const rewardBanner2 = '${_imagePath}rb2.png';
  static const rewardBanner3 = '${_imagePath}rb3.png';

  static const editIconSvg = '${svg}editIcon.svg';

  static const appLogo2 = 'asset/ic_launcher.png';

  static const star = '${_imagePath}star.png';
  static const forwardArrow = '${_imagePath}forward_arrow.png';
  static const dialogImage1 = '${_imagePath}dialogImage1.png';
}

CachedNetworkImage getImageView({required String finalUrl, double height = 40, double width = 40, fit = BoxFit.cover, Color? color}) {
  return CachedNetworkImage(
    imageUrl: finalUrl,
    fit: fit,
    height: height,
    width: width,
    placeholder: (context, url) => Container(
      margin: const EdgeInsets.all(10),
      height: height,
      width: width,
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColor.primaryRed,
        ),
      ),
    ),
    errorWidget: (context, url, error) => SizedBox(
      height: height,
      width: width,
      child: const Icon(Icons.error),
    ),
  );
}

class Throttler {
  Throttler({required this.throttleGapInMillis});

  final int throttleGapInMillis;
  int? lastActionTime;

  void run(VoidCallback action) {
    if (lastActionTime == null) {
      action();
      lastActionTime = DateTime.now().millisecondsSinceEpoch;
    } else {
      if (DateTime.now().millisecondsSinceEpoch - lastActionTime! > (throttleGapInMillis)) {
        action();
        lastActionTime = DateTime.now().millisecondsSinceEpoch;
      }
    }
  }
}

String getBloodGroup(String bg) {
  bg = removeSpace(bg);
  if (bg.contains('+ve')) {
    bg = '${bg.substring(0, bg.indexOf('+ve'))}+';
  } else if (bg.contains('-ve')) {
    bg = '${bg.substring(0, bg.indexOf('-ve'))}-';
  } else {
    bg = bg;
  }
  return bg;
}

String removeSpace(String string) {
  string = string.replaceAll(' ', '');
  return string;
}
