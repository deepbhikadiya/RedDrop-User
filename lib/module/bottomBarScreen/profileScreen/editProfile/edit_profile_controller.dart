import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ft_red_drop/data/network/api_client.dart';
import 'package:ft_red_drop/global_controller.dart';
import 'package:ft_red_drop/models/user_model.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/utils/app_loader.dart';

import '../../../../utils/app_toast.dart';

class EditProfileController extends GetxController{
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
  TextEditingController searchController = TextEditingController();

  RxString phoneNumber = "".obs;




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


  Future<void> updateProfile(context) async {
    showLoader();
    String? downloadProfileURL = globalController.userData.value.image;
    String? downloadAadharURL = globalController.userData.value.aadharImage;
    if(profileImage != null){
      try {
        final storageProfileRef = FirebaseStorage.instance.ref().child(firstName.value);
        await storageProfileRef.putFile(
          File(profileImage?.path ?? ""),
          SettableMetadata(
            contentType: "image/jpeg",
          ),
        );
        downloadProfileURL = await storageProfileRef.getDownloadURL();


      } catch (error) {
        print(error);
      }
    }
    if(aadharImage != null){
      try {
        final storageAadharRef = FirebaseStorage.instance.ref().child(nationalIdNoController.text);

        await storageAadharRef.putFile(
          File(aadharImage?.path ?? ""),
          SettableMetadata(
            contentType: "image/jpeg",
          ),
        );
        downloadAadharURL = await storageAadharRef.getDownloadURL();

      } catch (error) {
        print(error);
      }
    }

    try {
      UserData userModel = UserData(
        userId: globalController.userData.value.userId,
        image: downloadProfileURL,
        firstName: firstName.value,
        middleName: middleName.value,
        lastName: lastName.value,
        gender: selectedGender.value,
        dateOfBirth: Timestamp.fromDate(selectedBirthdate.value),
        aadharNo: nationalIdNo.value,
        aadharImage: downloadAadharURL,
        phoneNumber: globalController.userData.value.phoneNumber,
          country: country.value,
          state: state.value,
          city: city.value,
        bloodGroup: allBloodGroup[selectedIndex.value],
        isVerified: globalController.userData.value.isVerified,
        isAvailable: globalController.userData.value.isAvailable,
        referralCode: globalController.userData.value.referralCode,
        stars: globalController.userData.value.stars,
        fcmToken: globalController.userData.value.fcmToken
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(AppPref().userId)
          .update(userModel.toMap());
      dismissLoader();
      globalController.getUserData();
      showAppToast(S.of(context).profile_updated_successfully);
      Get.back();
    } on FirebaseException catch (e) {
      dismissLoader();
      showErrorSheet(e.message ?? '');
    } catch (e) {
      dismissLoader();
      showErrorSheet(e.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }
  final globalController = Get.find<GlobalController>();

  getData(){
    firstNameController.text = globalController.userData.value.firstName??"";
    middleNameController.text = globalController.userData.value.middleName??"";
    lastNameController.text = globalController.userData.value.lastName??"";
    nationalIdNoController.text = globalController.userData.value.aadharNo??"";
    phoneNumberController.text = globalController.userData.value.phoneNumber??"";

    firstName.value = globalController.userData.value.firstName??"";
    middleName.value = globalController.userData.value.middleName??"";
    lastName.value = globalController.userData.value.lastName??"";
    selectedGender.value = globalController.userData.value.gender??"";
    nationalIdNo.value = globalController.userData.value.aadharNo??"";
    phoneNumber.value = globalController.userData.value.phoneNumber??"";
    city.value = globalController.userData.value.city ?? "";
    country.value = globalController.userData.value.country ?? "";
    state.value = globalController.userData.value.state ?? "";
    isDate.value = true;
    selectedBirthdate.value = globalController.userData.value.dateOfBirth!.toDate();

    for(int i= 0;i<allBloodGroup.length;i++){
      if(allBloodGroup[i] == globalController.userData.value.bloodGroup){
        selectedIndex.value = i;
      }
    }
  }
}