import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/package/screen_packages.dart';
import 'package:ft_red_drop/utils/app_loader.dart';
import 'package:ft_red_drop/utils/app_toast.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../../../utils/fcm_utils.dart';

class OtpVerificationController extends GetxController {
  OtpFieldController otpController = OtpFieldController();
  RxString otpString = "".obs;
  int counter = 60;
  Timer? timer;
  Map<String, dynamic> userObject = {};
  bool? isFromForgetPassword;
  String? otp;
  String? phoneNumber;

  Future<void> checkVerificationForUser({required String userId, required BuildContext context}) async {
    try {
      final QuerySnapshot querySnapshots = await FirebaseFirestore.instance.collection('users').where("user_id", isEqualTo: userId).get();
      if (querySnapshots.docs.isNotEmpty) {
        final int isVerified = querySnapshots.docs.first.get('is_verified');
        if (isVerified == 1) {
          Get.offAllNamed(AppRouter.bottomBarScreen);
          print('User $userId is verified.');
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Text(
                  "You are not verified from admin",
                  style: const TextStyle().normal16w500.textColor(
                        AppColor.blackColor,
                      ),
                  textAlign: TextAlign.center,
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.offAllNamed(AppRouter.loginScreen);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Okay",
                            style: const TextStyle().normal16w500.textColor(
                                  AppColor.blackColor,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> verifyPhone(BuildContext context) async {
    try {
      showLoader();
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: AppPref().verificationId,
        smsCode: otpString.value,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        dismissLoader();
        AppPref().userId = userCredential.user?.uid ?? "";
        if (userObject.isEmpty) {
          await checkVerificationForUser(userId: userCredential.user?.uid ?? "", context: context);
        } else {
          userObject.addEntries({"user_id": userCredential.user?.uid ?? ""}.entries);
          await registerUser(userId: userCredential.user?.uid ?? "");
        }
      }
    } on FirebaseAuthException catch (e) {
      dismissLoader();
      showErrorToast(
        e.message ?? "",
      );
    } catch (e) {
      dismissLoader();
      print(e);
    }
  }

  Future<void> registerUser({required String userId}) async {
    try {
      showLoader();

      await FirebaseFirestore.instance.collection("users").doc(userId).set(userObject);
      dismissLoader();
      String? token = await FCMUtils.instance.getToken();
      await FirebaseFirestore.instance.collection("users").doc(AppPref().userId).update({"fcm_token": token});
      Get.toNamed(AppRouter.questionnairesScreen);
    } catch (e) {
      dismissLoader();
      print(e);
    }
  }

  final String _verificationId = "";
  int? _resendToken;

  Future<void> reSendOTP({required String phone}) async {
    try {
      showLoader();
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          dismissLoader();
        },
        codeSent: (String verificationId, int? resendToken) async {
          AppPref().verificationId = verificationId;
          _resendToken = resendToken;
          showErrorToast(S.of(Get.context!).code_resend_to_your_mobile_number);
          dismissLoader();
        },
        timeout: const Duration(seconds: 25),
        forceResendingToken: _resendToken,
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = _verificationId;
          dismissLoader();
        },
      );
    } catch (e) {
      dismissLoader();
      print(e);
    }
  }
}
