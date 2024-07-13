import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ft_red_drop/app_route.dart';
import 'package:ft_red_drop/data/pref/app_preferences.dart';
import 'package:ft_red_drop/utils/app_loader.dart';
import 'package:ft_red_drop/utils/app_toast.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../../generated/l10n.dart';

class RegisterController extends GetxController {
  // Uint8List? bits;


  RxString country = "".obs;
  RxString state = "".obs;
  RxString city = "".obs;
  XFile? profileImage;
  XFile? aadharImage;
  final picker = ImagePicker();
  TextEditingController firstNameController = TextEditingController();
  RxString firstName = "".obs;
  TextEditingController middleNameController = TextEditingController();
  RxString middleName = "".obs;
  TextEditingController lastNameController = TextEditingController();
  RxString lastName = "".obs;
  RxList genderList = ["Male", "Female"].obs;
  RxString selectedGender = "".obs;
  Rx<DateTime> selectedBirthdate = DateTime.now().obs;
  RxBool isDate = false.obs;

  TextEditingController nationalIdNoController = TextEditingController();
  RxString nationalIdNo = "".obs;
  FocusNode nationalIdFocusNode = FocusNode();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxList cityList = [
    "Surat",
    "Bhavnagar",
    "Amreli",
    "Rajkot",
    "Botad",
    "Vapi",
    "Bharuch",
  ].obs;
  RxList areaList = [
    "Katargam",
    "Sarthana",
    "Ambatalavdi",
    "Dabholi",
    "Adajan",
    "Vesu",
  ].obs;
  RxString selectedCity = "".obs;
  RxString selectedArea = "".obs;
  TextEditingController referralCodeController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  RxString phoneNumber = "".obs;
  RxString password = "".obs;
  RxString confirmPassword = "".obs;

  RxBool isAccepted = false.obs;
  RxBool showPassword = true.obs;
  RxBool showConfirmPassword = true.obs;

  RxList allBloodGroup = [
    "A +ve",
    "B +ve",
    "O +ve",
    "AB +ve",
    "A -ve",
    "B -ve",
    "O -ve",
    "AB -ve",
  ].obs;

  RxInt selectedIndex = 0.obs;

  Future<void> sendOtpToUser() async {
    try {
      String downloadProfileURL = "";
      String downloadAadharURL = "";

      showLoader();
      try {
        final storageProfileRef = FirebaseStorage.instance.ref().child(firstName.value);
        await storageProfileRef.putFile(
          File(profileImage?.path ?? ""),
          SettableMetadata(
            contentType: "image/jpeg",
          ),
        );
        downloadProfileURL = await storageProfileRef.getDownloadURL();

        final storageAadharRef = FirebaseStorage.instance.ref().child(nationalIdNoController.text);

        await storageAadharRef.putFile(
          File(aadharImage?.path ?? ""),
          SettableMetadata(
            contentType: "image/jpeg",
          ),
        );
        downloadAadharURL = await storageAadharRef.getDownloadURL();
      } catch (error) {
        dismissLoader();
      }

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91 ${phoneNumber.value}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          dismissLoader();
          if (e.code == 'invalid-phone-number') {
            showErrorToast(S.of(Get.context!).the_provided_phone_number_is_not_valid);
          } else {
            showErrorToast(e.code);
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          AppPref().verificationId = verificationId;
          dismissLoader();

          Get.offAllNamed(
            AppRouter.otpVerificationScreen,
            arguments: {
              'isFromForgetPassword': false,
              'phoneNumber': '+91 ${phoneNumber.value}',
              'isFromLogin': false,
              'user_object': {
                "image": downloadProfileURL,
                "aadhar_image": downloadAadharURL,
                "first_name": firstName.value,
                "is_available": true,
                "middle_name": middleName.value,
                "last_name": lastName.value,
                "gender": selectedGender.value,
                "date_of_birth": selectedBirthdate.value,
                "aadhar_no": nationalIdNo.value,
                "phone_number": phoneNumber.value,
                "country": country.value,
                "state": state.value,
                "city": city.value,
                "is_verified": -1,
                "referral_code": referralCodeController.text,
                "blood_group": allBloodGroup[selectedIndex.value],
                'stars': 0
              },
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
