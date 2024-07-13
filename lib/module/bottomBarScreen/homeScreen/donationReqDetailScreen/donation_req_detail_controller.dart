import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ft_red_drop/global_controller.dart';
import 'package:ft_red_drop/models/my_req_model.dart';
import 'package:ft_red_drop/models/user_model.dart';
import 'package:ft_red_drop/module/bottomBarScreen/createRequestScreen/create_request_controller.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../components/red_drop/common_dialog.dart';
import '../../../../utils/app_loader.dart';

class DonationReqDetailController extends GetxController{
  late GoogleMapController mapController;
  RxBool isLoading = false.obs;
  RxDouble distance = 0.0.obs;
  final Set<Marker> allMarkers = {};
  Rx<MyRequestModel> myReqModel = Rx<MyRequestModel>(MyRequestModel());
  getRequestData(String id)async{
    isLoading.value = true;
    showLoader();
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('blood_request').doc(id).get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      myReqModel.value = MyRequestModel.fromMap(data);
      await getCurrentLocation().then((value) async {
        await calculateDistance(
          startLatitude: myReqModel.value.location?.coordinates?[0]??0.0,
          startLongitude: myReqModel.value.location?.coordinates?[1]??0.0,
          endLatitude: value.latitude,
          endLongitude: value.longitude
        );

      });

      dismissLoader();
      isLoading.value = false;

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


  Future<void> donateNowButtonClick(String requestId) async {
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

        List<UserData> allUser = [];

        for(int i = 0;i<data['potential_donors'].length;i++){

          DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
              .collection("users")
              .doc(data['potential_donors'][i]["user_id"])
              .get();
          allUser.add(UserData.fromMap(documentSnapshot.data() as Map<String, dynamic>));

        }

        int index = allUser.indexWhere((donor) => donor.userId == Get.find<GlobalController>().userData.value.userId);

        if (index != -1) {
          Position p = await getCurrentLocation();

          potentialDonors[index]['lat'] = p.latitude;
          potentialDonors[index]['long'] = p.longitude;
          potentialDonors[index]['is_available'] = true;

          await bloodRequestRef.update({'potential_donors': potentialDonors});

          Get.find<GlobalController>().sendNotification(
              fcmToken: seeker.fcmToken??"",
              notificationType: "request_accepted",
              requestId: data["request_id"],
              titleTxt: "${allUser[index].firstName.toString().trim()} accepted your request.",
              bodyTxt: "Tap to view"
          );

          dismissLoader();

          commonDialog(
              image: AppImage.onBoarding1,
              text: S
                  .of(Get.context!)
                  .thanks_for_accepting_request
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


  Future<void> iDonatedButtonClick(String requestId) async {
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

        List<UserData> allUser = [];

        for(int i = 0;i<data['potential_donors'].length;i++){

          DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
              .collection("users")
              .doc(data['potential_donors'][i]["user_id"])
              .get();
          allUser.add(UserData.fromMap(documentSnapshot.data() as Map<String, dynamic>));

        }

        int index = potentialDonors.indexWhere((donor) => donor['user_id'] == Get.find<GlobalController>().userData.value.userId);

        if (index != -1) {
          potentialDonors[index]['is_donated'] = true;

          await bloodRequestRef.update({'potential_donors': potentialDonors});

          Get.find<GlobalController>().sendNotification(
              fcmToken: seeker.fcmToken??"",
              notificationType: "blood_donated",
              requestId: data["request_id"],
              titleTxt: "${allUser[index].firstName.toString().trim()} successfully donated blood.",
              bodyTxt: "Tap to confirm"
          );

          dismissLoader();

          commonDialog(
              image: AppImage.onBoarding2,
              text: S
                  .of(Get.context!)
                  .thank_you_text
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


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}