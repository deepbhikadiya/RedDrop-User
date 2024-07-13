import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ft_red_drop/global_controller.dart';
import 'package:ft_red_drop/models/my_req_model.dart';
import 'package:ft_red_drop/models/user_model.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../components/red_drop/common_dialog.dart';
import '../../../../models/address.dart';
import '../../../../utils/app_loader.dart';

class MyReqDetailController extends GetxController{
  Rx<UserData> userData = Rx<UserData>(UserData());
  RxDouble distance = 0.0.obs;

  RxBool isLoading = false.obs;
  RxString addressOfDonor = "".obs;
  RxBool isShowDonorBottomSheet = true.obs;
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  late GoogleMapController mapController;
  final Set<Marker> allMarkers = {};
  Rx<MyRequestModel> myReqModel = Rx<MyRequestModel>(MyRequestModel());
  getRequestData(String id)async{
    showLoader();
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('blood_request').doc(id).get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      myReqModel.value = MyRequestModel.fromMap(data);
      print(myReqModel);
      dismissLoader();
    } catch (e) {
      isLoading.value = false;

      print('Error fetching data: $e');
      dismissLoader();
    }
  }

  Future<void> calculateDistance(
      {startLatitude, startLongitude, endLatitude, endLongitude}) async {

    double distanceInMeters = await Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );

    distance.value = distanceInMeters / 1000;

    print('Distance between the two locations: ${distance.value} kilometers');
  }

  Future<void> confirmDonationButtonClick(String requestId) async {
    try {
      showLoader();
      DocumentReference bloodRequestRef = FirebaseFirestore.instance.collection('blood_request').doc(requestId);

      DocumentSnapshot bloodRequestSnapshot = await bloodRequestRef.get();

      Map<String, dynamic>? data = bloodRequestSnapshot.data() as Map<String, dynamic>?;

      if (bloodRequestSnapshot.exists && data != null && data.containsKey('potential_donors')) {
        List<dynamic> potentialDonors = data['potential_donors'];
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(data["user_id"])
            .get();
        UserData seeker = UserData.fromMap(documentSnapshot.data() as Map<String, dynamic>);
        int index = potentialDonors.indexWhere((donor) => donor['user_id'] == userData.value.userId);

        if (index != -1) {
          potentialDonors[index]['is_confirm'] = true;

          await bloodRequestRef.update({'potential_donors': potentialDonors});

          DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userData.value.userId);
          int stars = userData.value.stars! + 25;
          await userRef.update({'stars': stars});

          Get.find<GlobalController>().sendNotification(
              fcmToken: userData.value.fcmToken??"",
              notificationType: "donation_confirm",
              requestId: data["request_id"],
              titleTxt: "${seeker.firstName.toString().trim()} confirmed your blood donation.",
              bodyTxt: "Tap to view"
          );

          dismissLoader();
          await addHistoryData();
          await getRequestData(myReqModel.value.requestId??"");

          commonDialog(
              image: AppImage.onBoarding1,
              text: S.of(Get.context!).donation_confirmed,
              onTap: (){
                Get.back();
              },
              then: (value){
                Get.back();
                isShowDonorBottomSheet.value = true;

              }
          );
        } else {
          print('User ID not found in potential donors list.');
        }
      } else {
        print('Blood request document not found or potential_donors field not available.');
      }
    } catch (error) {
      dismissLoader();
      print('Error updating user availability: $error');
    }
  }


  getLocation(double lat, double long)async{
    try{
      showLoader();
      List<Placemark> p = await placemarkFromCoordinates(lat, long);
      addressOfDonor.value = "${p.first.street}, ${p.first.name}, ${p.first.locality}, ${p.first.administrativeArea}, ${p.first.country}";
      dismissLoader();

    }catch(e){
      dismissLoader();
    }
  }


  Future<void> addHistoryData() async {
    try {
      showLoader();
      Address address = Address(
        address: myReqModel.value.location?.address??"",
        coordinates: [
          myReqModel.value.location?.coordinates?[0].toString()??"",
          myReqModel.value.location?.coordinates?[1].toString()??"",
        ],
      );
      var data = {
        'request_id': '',
        'location': address.toJson(),
        'blood_group': myReqModel.value.bloodGroup,
        'date': DateTime.now(),
        'seeker': Get.find<GlobalController>().userData.value.toMap(),
        'donor': userData.value.toMap(),
      };
      DocumentReference req = await FirebaseFirestore.instance.collection('donation_history').add(data);
      String id = req.id;

      var replaceData = {
        ...data,
        'request_id': id,
      };

      await FirebaseFirestore.instance.collection('donation_history').doc(id).set(replaceData);

      dismissLoader();
    } catch (e) {
      dismissLoader();
      print(e);
    }
  }

}