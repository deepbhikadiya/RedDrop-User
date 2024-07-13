import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ft_red_drop/components/buttons.dart';
import 'package:ft_red_drop/components/red_drop/common_back_button.dart';
import 'package:ft_red_drop/components/red_drop/profile_image_widget.dart';
import 'package:ft_red_drop/global_controller.dart';
import 'package:ft_red_drop/module/bottomBarScreen/homeScreen/donationReqDetailScreen/donation_req_detail_controller.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' hide MapType;
import 'package:map_launcher/map_launcher.dart';

import '../../../../components/common_fun.dart';
import '../../../../models/user_model.dart';
import '../../createRequestScreen/create_request_controller.dart';


class DonationReqDetailScreen extends StatefulWidget {
  final String id;

  const DonationReqDetailScreen({super.key, required this.id});

  @override
  State<DonationReqDetailScreen> createState() =>
      _DonationReqDetailScreenState();
}

class _DonationReqDetailScreenState extends State<DonationReqDetailScreen> {
  final donationReqController = Get.put<DonationReqDetailController>(
      DonationReqDetailController());
  Set<Polyline> _polylines = Set<Polyline>();

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  void onMapCreated(GoogleMapController controller) {
    1.delay(
        (){
          setState(() async {
            _controller.complete(controller);
            donationReqController.mapController = controller;
            donationReqController.allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarker,
              markerId: const MarkerId("1"),
              position: LatLng(
                donationReqController.myReqModel.value.location!.coordinates![0],
                donationReqController.myReqModel.value.location!.coordinates![1],
              ),
              onTap: (){
                directionSheet(lat: donationReqController.myReqModel.value.location!.coordinates![0],long: donationReqController.myReqModel.value.location!.coordinates![1]);
              }
            ));
            Position p = await getCurrentLocation();

            final currentLocation = LatLng(
              p.latitude,
              p.longitude,
            );

            final destination = donationReqController.allMarkers.toList()[0].position;

            _polylines.add(Polyline(
              polylineId: PolylineId("poly"),
              color: AppColor.primaryRed,

              width: 5,
              points: [currentLocation, destination],
            ));

            final cameraPosition = CameraPosition(
              target: LatLng(
                (currentLocation.latitude + destination.latitude) / 2,
                (currentLocation.longitude + destination.longitude) / 2,
              ),
              zoom: 14.0,
            );

            // Animate camera to show both current location and destination
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

            // Add the polyline to the map

            setState(() {});
          });
        }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await donationReqController.getRequestData(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGoogleMap(context),
          const CommonBackButton(),
          Obx(() => donationReqController.isLoading.value?
          Container():
          _buildBottomSheet(context))
        ],
      ),
    );
  }

  _buildGoogleMap(context) {
    return GoogleMap(
      onMapCreated: onMapCreated,
      myLocationButtonEnabled: false,
      initialCameraPosition: const CameraPosition(
          target: LatLng(21.2266, 72.8312), zoom: 17),
      zoomControlsEnabled: false,
      compassEnabled: true,
      myLocationEnabled: true,
      mapToolbarEnabled: false,
      buildingsEnabled: true,
      minMaxZoomPreference:
      const MinMaxZoomPreference(1, 50),
      markers: donationReqController.allMarkers,
      polylines: _polylines,
    );
  }

  _buildBottomSheet(context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection("users")
            .doc(donationReqController.myReqModel.value.userId)
            .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        UserData seeker = UserData.fromMap(snapshot.data!.data() as Map<String, dynamic>);

        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: const BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      spreadRadius: .1
                  )
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: getImageView(
                            finalUrl: seeker.image ?? "",
                            height: 75,
                            width: 75
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${seeker.firstName} ${seeker.lastName}",
                              style: const TextStyle().normal14w600.textColor(
                                  AppColor.blackColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Obx(() {
                              return Text(
                                donationReqController.myReqModel.value.location?.address??"",
                                style: const TextStyle().normal13w600.textColor(
                                    AppColor.textColor3),
                              );
                            }),
                            Obx(() {
                              return Text.rich(
                                  TextSpan(
                                      children: [
                                        WidgetSpan(
                                          alignment: PlaceholderAlignment.middle,
                                          child: SizedBox(
                                            height: 20,
                                            child: Image.asset(AppImage.locationIcon,color: AppColor.primaryRed,),
                                          ),
                                        ),
                                        TextSpan(text: "${donationReqController.distance.toStringAsFixed(2)}KM away",
                                            style: const TextStyle().normal13w600.textColor(
                                                AppColor.primaryRed)),
                                      ]
                                  )

                              );
                            }),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        flex: 1,
                        child: Obx(() {
                          return Image.asset(
                            getBloodImage(
                                donationReqController.myReqModel.value.bloodGroup),
                            height: 40, width: 40,);
                        }),
                      )
                    ],
                  ),
                  const Gap(15),
                  Text(
                    S
                        .of(context)
                        .donation_detail,
                    style: const TextStyle().normal14w600.textColor(
                        AppColor.blackColor),
                  ),
                  Obx(() {
                    return Text(
                      "Time: ${DateFormat('hh:mm a').format(
                          donationReqController.myReqModel.value.time?.toDate() ??
                              DateTime.now())}, ${DateFormat('dd MMMM yyyy').format(
                          donationReqController.myReqModel.value.date?.toDate() ??
                              DateTime.now())}",
                      style: const TextStyle().normal12w600.textColor(
                          AppColor.textColor3),
                    );
                  }),
                  Obx(() {
                    return Text(
                      donationReqController.myReqModel.value.note ?? "",
                      style: const TextStyle().normal12w600.textColor(
                          AppColor.textColor3),
                    );
                  }),
                  const Gap(15),
                  Obx(
                    ()=>
                    donationReqController.myReqModel.value.potentialDonors?.indexWhere((donor) => (donor.userId == Get.find<GlobalController>().userData.value.userId) && (donor.isConfirm??false) ) != -1?
                    CommonAppButton(
                      buttonType: ButtonType.disable,
                      text: S
                          .of(context)
                          .donation_confirmed,
                      onTap: () {
                      },
                    ):
                    donationReqController.myReqModel.value.potentialDonors?.indexWhere((donor) => (donor.userId == Get.find<GlobalController>().userData.value.userId) && (donor.isAvailable??false) && (donor.isDonated??false) ) != -1?
                    CommonAppButton(
                      buttonType: ButtonType.disable,
                      text: S
                          .of(context)
                          .in_pending,
                      onTap: () {
                      },
                    ):
                    donationReqController.myReqModel.value.potentialDonors?.indexWhere((donor) => (donor.userId == Get.find<GlobalController>().userData.value.userId) && (donor.isAvailable??false) ) != -1?
                    CommonAppButton(
                      buttonType: ButtonType.enable,
                      text: S
                          .of(context)
                          .i_donated,
                      onTap: () {
                        donationReqController.iDonatedButtonClick(donationReqController.myReqModel.value.requestId??"");
                      },
                    ):
                    CommonAppButton(
                      buttonType: ButtonType.enable,
                      text: S
                          .of(context)
                          .donate_now,
                      onTap: () {
                        donationReqController.donateNowButtonClick(donationReqController.myReqModel.value.requestId??"");
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  void directionSheet({
    double? lat,
    double? long,
  }) async {
    bool isAppleMapsAvailable =
        await MapLauncher.isMapAvailable(MapType.apple) ?? false;
    FocusManager.instance.primaryFocus?.unfocus();
    showModalBottomSheet(
        context: Get.context!,
        builder: (builder) {
          return Container(
            // height: 350.0,
            color: const Color(0xFF737373),
            child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                          width: 30,
                          height: 6,
                          decoration: BoxDecoration(
                              color: AppColor.textColor,
                              borderRadius: BorderRadius.circular(100))),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        await MapLauncher.showDirections(
                          mapType: MapType.google,
                          destination: Coords(lat!, long!),
                        );
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: Image.asset(
                              AppImage.googleMap,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Google Map",
                            style:
                            const TextStyle(color: AppColor.blackColor).normal14w400,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    !isAppleMapsAvailable
                        ? GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Row(
                        children: [
                          const Icon(Icons.close_outlined,
                              color: AppColor.primaryRed),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            S.of(context).cancel,
                            style: const TextStyle(color: AppColor.primaryRed)
                                .normal14w400,
                          ),
                        ],
                      ),
                    )
                        : GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        await MapLauncher.showDirections(
                          mapType: MapType.apple,
                          destination: Coords(lat!, long!),
                        );
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  AppImage.appleMap,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Apple Map",
                            style: const TextStyle(color: AppColor.blackColor)
                                .normal14w400,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )),
          );
        });
  }


}
