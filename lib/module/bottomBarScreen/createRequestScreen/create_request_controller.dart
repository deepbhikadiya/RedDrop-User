import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ft_red_drop/global_controller.dart';
import 'package:ft_red_drop/models/address.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/utils/app_loader.dart';
import 'package:ft_red_drop/utils/app_toast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


Future<Position> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}

Future<List<Placemark>> getPlaceMarks(double lat, double long) async {
  List<Placemark> placeMarks = await placemarkFromCoordinates(lat, long);
  return placeMarks;
}

class CreateRequestController extends GetxController {
  Rx<TextEditingController> noteController = TextEditingController().obs;
  final globalController = Get.find<GlobalController>();

  Rx<Address> address = Rx<Address>(Address());

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

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool isDate = false.obs;

  Rx<DateTime> selectedTime = DateTime.now().obs;
  RxBool isTime = false.obs;

  Future<Location?> getAddressCoordinates(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations[0];
        return location;
      } else {
        showAppToast('No location found for this address');
        return null;
      }
    } catch (e) {
      showAppToast('$e');
      return null;
    }
  }
  Future<void> createBloodRequest() async {
    try {
      showLoader();
      Location? location = await getAddressCoordinates(globalController.locationController.value.text);
      if(location != null){
        await getPlaceMarks(location.latitude,location.longitude).then((List<Placemark> placeMarks) {

          address.value = Address(
            address: globalController.locationController.value.text,
            coordinates: [
              location.latitude.toStringAsFixed(6),
              location.longitude.toStringAsFixed(6),
            ],
          );
        });
      }else{
        dismissLoader();
        return;
      }
      var data = {
        'request_id': '',
        'user_id': AppPref().userId,
        'location': address.value.toJson(),
        'date': selectedDate.value,
        'time': selectedTime.value,
        'blood_group': allBloodGroup[selectedIndex.value],
        'note': noteController.value.text,
        // "requested_user": Get.find<GlobalController>().userData.value.toMap(),
      };
      DocumentReference req = await FirebaseFirestore.instance.collection('blood_request').add(data);
      String id = req.id;

      var replaceData = {
        ...data,
        'request_id': id,
      };

      await FirebaseFirestore.instance.collection('blood_request').doc(id).set(replaceData);
      await FirebaseFirestore.instance.collection('blood_request').doc('request_id').delete();

      QuerySnapshot potentialDonorsSnapshot =
          await FirebaseFirestore.instance.collection('users').where('blood_group', isEqualTo: allBloodGroup[selectedIndex.value]).get();
      List<dynamic> potentialDonorIds = [];
      for (var doc in potentialDonorsSnapshot.docs) {
        if (doc.id != AppPref().userId) {
          if (doc['is_available'] == true) {
            potentialDonorIds.add({
              "user_id": doc.id,
              // "user": doc.data(),
              "is_available": false,
              "is_donated": false,
              "is_confirm": false,
            });
            globalController.sendNotification(
            fcmToken: doc['fcm_token'],
            bodyTxt: "Location: ${address.value.address}",
            titleTxt: "${globalController.userData.value.firstName?.trim()} have sent you a blood request.",
            notificationType: "blood_request",
              requestId: id
            );
          }
        }
      }
      await FirebaseFirestore.instance.collection('blood_request').doc(id).update({'potential_donors': potentialDonorIds});

      Get.back();
      dismissLoader();
    } catch (e) {
      dismissLoader();
      print(e);
    }
  }

}
