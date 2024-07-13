import 'package:ft_red_drop/package/screen_packages.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:http/http.dart' as http;

class GlobalController extends GetxController {
  Rx<TextEditingController> locationController = TextEditingController().obs;

  RxInt selectedIndex = 0.obs;
  Rx<UserData> userData = Rx<UserData>(UserData());

  getUserData() async {
    if (AppPref().userId.isNotEmpty) {
      FirebaseFirestore.instance
          .collection(
            "users",
          )
          .where("user_id", isEqualTo: AppPref().userId)
          .snapshots()
          .listen(
        (event) {
          if (event.docs.isNotEmpty) {
            userData.value = UserData.fromMap(event.docs.first.data());
          }
        },
      );
    }
  }

  void sendNotification({required String fcmToken, required String bodyTxt, required String titleTxt, required String notificationType, required String requestId}) async {
    var url = 'https://fcm.googleapis.com/fcm/send';

    var body = jsonEncode({
      "to": fcmToken,
      "notification": {"body": bodyTxt, "title": titleTxt},
      "data": {"click_action": "HandleNotifyActivity", "body": bodyTxt, "title": titleTxt, "notification_type": notificationType, "request_id": requestId}
    });

    var response = await http.post(Uri.parse(url), headers: {'Content-Type': 'application/json', 'Authorization': 'key=${CommonString.serverKey}'}, body: body);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Notification sent successfully');
      }
    } else {
      if (kDebugMode) {
        print('Failed to send notification. Error: ${response.body}');
      }
    }
  }

}

Future<void> showSheet(String errorText, {Function()? onTap}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  showModalBottomSheet(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    context: Get.context!,
    isScrollControlled: true,
    builder: (context) => Container(
      decoration: BoxDecoration(color: context.theme.scaffoldBackgroundColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      padding: const EdgeInsetsDirectional.only(
        start: 24,
        end: 24,
        top: 18,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 30,
              height: 6,
              decoration: BoxDecoration(
                color: AppColor.primarySkyBlue,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          for (var data in errorText.split(',')) ...{
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 4),
                    child: CircleAvatar(backgroundColor: context.textTheme.titleLarge?.color, radius: 5),
                  ),
                  const Gap(8),
                  Expanded(
                      child: Text(
                    data.trim().capitalizeFirst!,
                    style: const TextStyle().normal14w500,
                  )),
                ],
              ),
            ),
          },
          const Gap(16),
          CommonAppButton(
            buttonType: ButtonType.enable,
            onTap: onTap ??
                () {
                  Navigator.pop(context);
                },
            text: S.of(context).okay,
          ),
          const Gap(16),
        ],
      ),
    ),
  );
}
