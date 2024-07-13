import 'package:ft_red_drop/package/config_packages.dart';

void showAppToast(String? msg) {
  if (msg == null || msg.isEmpty) {
    return;
  }
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    textColor: AppColor.whiteColor,
    fontSize: 14,
    gravity: ToastGravity.BOTTOM,
  );
}

void showErrorToast(String? msg) {
  if (msg == null || msg.isEmpty) {
    return;
  }
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: AppColor.primaryRed,
    textColor: AppColor.whiteColor,
    fontSize: 14,
    gravity: ToastGravity.BOTTOM,
  );
}
