import 'package:firebase_auth/firebase_auth.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/package/screen_packages.dart';
import 'package:ft_red_drop/utils/app_loader.dart';
import 'package:ft_red_drop/utils/app_toast.dart';

class LoginController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();

  Future<void> sendOtpToUser() async {
    try {
      showLoader();
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91 ${phoneNumberController.text}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print(e);
          dismissLoader();
          if (e.code == 'invalid-phone-number') {
            showErrorToast(S.of(Get.context!).the_provided_phone_number_is_not_valid);
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          AppPref().verificationId = verificationId;
          dismissLoader();

          Get.offAllNamed(
            AppRouter.otpVerificationScreen,
            arguments: {
              'isFromForgetPassword': false,
              'phoneNumber': '+91 ${phoneNumberController.text}',
              'isFromLogin': true,
            },
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      dismissLoader();
      print(e);
    }
  }
}
