import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/utils/extension/extensions.dart';

String getBloodImage(String? blood) {
  if (blood == 'A +ve') {
    return 'asset/image/A+.png';
  } else if (blood == 'B +ve') {
    return 'asset/image/B+.png';
  } else if (blood == 'O +ve') {
    return 'asset/image/O+.png';
  } else if (blood == 'AB +ve') {
    return 'asset/image/AB+.png';
  } else if (blood == 'A -ve') {
    return 'asset/image/A-.png';
  } else if (blood == 'B -ve') {
    return 'asset/image/B-.png';
  } else if (blood == 'O -ve') {
    return 'asset/image/O-.png';
  } else {
    return 'asset/image/AB-.png';
  }
}

hideKeyboard() {
  Get.context?.let((it) {
    final currentFocus = FocusScope.of(it);
    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  });
}

String getBadgeImage(num count){
  if(count <= 75){
    return AppImage.donator;
  } else if(count >= 125 && count < 250){
    return AppImage.savior;
  } else if(count >= 250){
    return AppImage.superhero;
  } else {
    return AppImage.donator;
  }
}

bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}
//
// import 'package:ft_red_drop/package/config_packages.dart';
//
// bool isNullEmptyOrFalse(dynamic o) {
//   if (o is Map<String, dynamic> || o is List<dynamic>) {
//     return o == null || o.length == 0;
//   }
//   return o == null || false == o || "" == o;
// }
// hideKeyboard() {
//   final currentFocus = FocusScope.of(Get.context!);
//   if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
//     FocusManager.instance.primaryFocus!.unfocus();
//   }
// }
//
// String removeSpace(String string) {
//   string = string.replaceAll(' ', ''); // Replace space with empty string
//   return string;
// }
//
// String getBloodGroup(String bg){
//   bg = removeSpace(bg);
//   if (bg.contains('+ve')) {
//     bg = bg.substring(0, bg.indexOf('+ve')) + '+';
//   } else if (bg.contains('-ve')) {
//     bg = bg.substring(0, bg.indexOf('-ve')) + '-';
//   } else {
//     bg = bg;
//   }
//   return bg;
// }
//
// CachedNetworkImage getImageView(
//     {String? finalUrl,
//     double errorHeight = 100.0,
//     double errorWidth = 100.0,
//     double? height,
//     double? width,
//     fit= BoxFit.none,
//     Decoration? shape,
//     Color? color}) {
//   // String imageUrl = !isNullEmptyOrFalse(finalUrl) ? finalUrl! : "";
//   return CachedNetworkImage(
//       imageUrl: finalUrl!,
//       fit: fit,
//       height: height,
//       width: width,
//       placeholder: (context, url) => Container(
//             margin: const EdgeInsets.all(20),
//             // height: 50,
//             // width: 50,
//             child:  const Center(child: CircularProgressIndicator(
//               color: AppColor.grey,
//             )),
//           ),
//       errorWidget: (context, url, error) =>Container(
//         decoration: BoxDecoration(
//             color: AppColor.white,
//             borderRadius: BorderRadius.circular(24)
//         ),
//         child: ClipRRect(
//             borderRadius: BorderRadius.circular(22),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Image.asset(profileImage,),
//             )),
//       ) //new Icon(Icons.error),
//       );
// }
//
//
// class CustomDialogs {
//   static CustomDialogs? _shared;
//
//   CustomDialogs._();
//
//   static CustomDialogs get getInstance =>
//       _shared = _shared ?? CustomDialogs._();
//
//   showCircularIndicator({
//     double size = 80.0,
//   }) {
//     return SpinKitPulse(
//       itemBuilder: (BuildContext context, int index) {
//         return const DecoratedBox(
//           decoration: BoxDecoration(
//             color: AppColor.grey,
//           ),
//         );
//       },
//       // color: ColorConstants.primaryColor,
//       size: size,
//     );
//   }
//
//   void showProgressDialog() {
//     ProgressDialog2.showLoadingDialog(isBarrierDismissible: false);
//   }
//
//   void hideProgressDialog() {
//     Get.back();
//   }
// }
//
// class ProgressDialog2 {
//   static Future<void> showLoadingDialog(
//       {bool isBarrierDismissible = false}) async {
//     return showDialog<void>(
//       context: Get.context!,
//       barrierDismissible: isBarrierDismissible,
//       builder: (BuildContext context) {
//         return WillPopScope(
//             onWillPop: () async {
//               return isBarrierDismissible;
//             },
//             child: Center(child: circularLoader()));
//       },
//     );
//   }
// }
//
//
// CircularProgressIndicator circularLoader() {
//   return const CircularProgressIndicator(
//     color: AppColor.grey,
//   );
// }
