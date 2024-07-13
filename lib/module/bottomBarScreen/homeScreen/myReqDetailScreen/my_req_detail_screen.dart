import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ft_red_drop/components/common_fun.dart';
import 'package:ft_red_drop/components/red_drop/common_back_button.dart';
import 'package:ft_red_drop/components/red_drop/common_outer_container.dart';
import 'package:ft_red_drop/models/user_model.dart';
import 'package:ft_red_drop/module/bottomBarScreen/createRequestScreen/create_request_controller.dart';
import 'package:ft_red_drop/module/bottomBarScreen/homeScreen/myReqDetailScreen/my_req_detail_controller.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../components/buttons.dart';
import '../../../../components/red_drop/common_dialog.dart';

class MyRequestDetailScreen extends StatefulWidget {
  final String id;

  const MyRequestDetailScreen({super.key,required this.id});

  @override
  State<MyRequestDetailScreen> createState() => _MyRequestDetailScreenState();
}

class _MyRequestDetailScreenState extends State<MyRequestDetailScreen> {
  final myReqDetailController = Get.put<MyReqDetailController>(
      MyReqDetailController());
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  void onMapCreated(GoogleMapController controller) {
    1.delay(
            (){
          setState(() {
            _controller.complete(controller);
            myReqDetailController.mapController = controller;
            myReqDetailController.allMarkers.add(Marker(
              icon: BitmapDescriptor.defaultMarker,
              markerId: const MarkerId("1"),
              position: LatLng(
                  (myReqDetailController.myReqModel.value.location!.coordinates![0]),
                  (myReqDetailController.myReqModel.value.location!.coordinates![1])),
            ));

            final cameraPosition = CameraPosition(
              target: myReqDetailController.allMarkers.toList()[0].position,
              zoom: 14.0,
            );
            Future.delayed(
              const Duration(seconds: 1),
                  () =>
                      myReqDetailController.mapController
                      .animateCamera(CameraUpdate.newCameraPosition(cameraPosition)),
            );
            setState(() {

            });
          });
        }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      myReqDetailController.isLoading.value = true;
      await myReqDetailController.getRequestData(widget.id);
      myReqDetailController.isLoading.value = false;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGoogleMap(context),
          const CommonBackButton(),
          Obx(() {
            return Visibility(
              visible: myReqDetailController.isShowDonorBottomSheet.value && !myReqDetailController.isLoading.value,
              child: _buildDonorList(context),
            );
          }),
        ],
      ),

    );
  }

  _buildGoogleMap(context) {
    return GoogleMap(
      onMapCreated: onMapCreated,
      markers: myReqDetailController.allMarkers,
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
    );
  }

  _buildDonorList(context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        initialChildSize: .35,
        minChildSize: .35,
        maxChildSize: .9,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      spreadRadius: .1
                  )
                ]
            ),
            child: Column(
              children: [
                const Gap(30),
                Container(
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.secondaryColor
                  ),
                ),
                const Gap(20),
                Text(
                  S
                      .of(context)
                      .available_donors,
                  style: const TextStyle().normal16w600,
                ),
                const Gap(10),
                Text(
                  S
                      .of(context)
                      .swipe_up_for_more,
                  style: const TextStyle().normal10w500,
                ),
                const Gap(15),
                Expanded(
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection('blood_request').doc(widget.id).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return Center(
                          child: Text(S.of(context).blood_donation_request_not_found,style: const TextStyle().normal16w600.textColor(AppColor.textColor2)),
                        );
                      }

                      var requestData = snapshot.data!.data() as Map<String, dynamic>;
                      var potentialDonors = requestData['potential_donors'] ?? [];

                      var availableDonors = potentialDonors.where((donor) => donor['is_available'] == true).toList();


                      if (availableDonors.isEmpty) {
                        return Center(
                          child: Text(S.of(context).no_available_donor,
                            style: const TextStyle().normal18w600,
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: availableDonors.length,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        controller: scrollController,
                        separatorBuilder: (context, index) {
                          return const Gap(15);
                        },
                        itemBuilder: (context, index) {

                          return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(availableDonors[index]["user_id"])
                                  .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container();
                              }
                              if (snapshot.hasError) {
                                print(snapshot.error);
                                return Text('Error: ${snapshot.error}');
                              }
                              UserData donor = UserData.fromMap(snapshot.data!.data() as Map<String, dynamic>);

                              myReqDetailController.allMarkers.add(Marker(
                                  icon: BitmapDescriptor.defaultMarker,
                                  markerId: MarkerId(Random().nextInt(100).toString()),
                                  position: LatLng(
                                    availableDonors[index]["lat"],
                                    availableDonors[index]["long"],
                                  ),
                                  infoWindow: InfoWindow(title: donor.firstName)
                              ));
                              return Stack(
                                children: [
                                  CommonOuterContainer(
                                    onTap: ()async {
                                      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(availableDonors[index]["user_id"])
                                          .get();
                                      myReqDetailController.userData.value = UserData.fromMap(documentSnapshot.data() as Map<String, dynamic>);
                                       await myReqDetailController.getLocation(availableDonors[index]["lat"], availableDonors[index]["long"],);
                                      myReqDetailController.isShowDonorBottomSheet.value = false;

                                      _buildDonorProfileBottomSheet(context);
                                      await getCurrentLocation().then((value) async {
                                        await myReqDetailController.calculateDistance(
                                            startLatitude: availableDonors[index]["lat"]??0.0,
                                            startLongitude: availableDonors[index]["long"]??0.0,
                                            endLatitude: value.latitude,
                                            endLongitude: value.longitude
                                        );

                                      });
                                      final cameraPosition = CameraPosition(
                                        target: LatLng(availableDonors[index]["lat"],availableDonors[index]["long"]),
                                        zoom: 16.0,
                                      );
                                      Future.delayed(
                                        const Duration(seconds: 1),
                                            () =>
                                            myReqDetailController.mapController
                                                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition)),
                                      );
                                      setState(() {

                                      });
                                    },
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: getImageView(
                                              finalUrl: donor.image??"",
                                            height: 75,
                                            width: 75
                                          ),
                                        ),
                                        const Gap(10),
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${donor.firstName} ${donor.lastName}",
                                                style: const TextStyle().normal14w600.textColor(
                                                    AppColor.blackColor),
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                          child: Image.asset(
                                                            AppImage.starIcon,
                                                            height: 20,)
                                                      ),
                                                      const WidgetSpan(
                                                          child: SizedBox(width: 5,)
                                                      ),
                                                      TextSpan(
                                                        text: "${donor.stars}",
                                                        style: const TextStyle().normal13w600
                                                            .textColor(
                                                            AppColor.yellowColor),
                                                      ),
                                                    ]
                                                ),

                                              ),
                                            ],
                                          ),
                                        ),
                                        const Gap(10),
                                        Expanded(
                                          flex: 1,
                                          child: Image.asset(
                                            getBloodImage(donor.bloodGroup), height: 40, width: 40,),
                                        )
                                      ],
                                    ),
                                  ),
                                  availableDonors[index]["is_confirm"] == true?
                                  Positioned(
                                    right: 0,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
                                        child: Stack(
                                          children: [
                                            Image.asset(AppImage.rectangle,height: 38,),
                                            Positioned(
                                                bottom: 20,
                                                right: 7,
                                                child: Image.asset(AppImage.check,height: 6.5,)),
                                          ],
                                        )),
                                  ):Container()
                                ],
                              );
                            }
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future _buildDonorProfileBottomSheet(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        enableDrag: false,
        builder: (builder) {
          return Container(
            decoration: const BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      spreadRadius: .1
                  )
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: getImageView(
                              finalUrl: myReqDetailController.userData.value.image??"",
                              height: 75,
                              width: 75
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${myReqDetailController.userData.value.firstName} ${myReqDetailController.userData.value.lastName}",
                                style: const TextStyle().normal14w600.textColor(
                                    AppColor.blackColor),
                              ),
                              Text(
                                myReqDetailController.addressOfDonor.value,
                                style: const TextStyle().normal13w600.textColor(
                                    AppColor.textColor3),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
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
                                          TextSpan(text: "${myReqDetailController.distance.toStringAsFixed(2)}KM away",
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
                          child: Image.asset(
                            getBloodImage(myReqDetailController.userData.value.bloodGroup), height: 40, width: 40,),
                        )
                      ],
                    ),
                  ),
                  const Gap(15),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(
                                TextSpan(
                                    children: [
                                      WidgetSpan(
                                          child: Image.asset(
                                            AppImage.starIcon,
                                            height: 20,)
                                      ),
                                      const WidgetSpan(
                                          child: SizedBox(width: 5,)
                                      ),
                                      TextSpan(
                                        text: "${myReqDetailController.userData.value.stars}",
                                        style: const TextStyle().normal13w600
                                            .textColor(
                                            AppColor.yellowColor),
                                      ),
                                    ]
                                ),

                              ),
                              FittedBox(
                                child: Text(
                                  S.of(context).points,
                                  style: const TextStyle().normal13w600.textColor(
                                      AppColor.textColor3),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor: AppColor.primaryRed,
                                child: Icon(Icons.person,color: AppColor.whiteColor,),
                              ),
                              Text(
                                "${((myReqDetailController.userData.value.stars??0)/25).toStringAsFixed(0)} ${S.of(context).life_saved}",
                                style: const TextStyle().normal13w600.textColor(
                                    AppColor.textColor3),
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                            ],
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor: AppColor.primaryRed,
                                child: Icon(Icons.star,color: AppColor.whiteColor,),
                              ),
                              Text(
                                S.of(context).top_rated,
                                style: const TextStyle().normal13w600.textColor(
                                    AppColor.textColor3),
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                            ],
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor: AppColor.primaryRed,
                                child: Icon(Icons.check_circle_outline_sharp,color: AppColor.whiteColor,),
                              ),
                              Text(
                                S.of(context).good_behaviour,
                                style: const TextStyle().normal13w600.textColor(
                                    AppColor.textColor3),
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                            ],
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                  const Gap(15),
                  Text.rich(
                      TextSpan(
                          style: const TextStyle().normal16w600.textColor(AppColor.textColor2),
                          children: [
                            const WidgetSpan(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Icon(Icons.call,color: AppColor.textColor,),
                                )
                            ),
                            const WidgetSpan(child: SizedBox(width: 10,)),
                            TextSpan(
                                text: "+91 ${myReqDetailController.userData.value.phoneNumber}",
                                style: const TextStyle().normal16w600.textColor(AppColor.textColor2)
                            ),
                            const WidgetSpan(child: SizedBox(width: 10,)),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: (){
                                  myReqDetailController.makePhoneCall("+91 65789 89766");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.lightRedColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 12),
                                    child: Text(
                                      S.of(context).call,
                                        style: const TextStyle().normal16w600.textColor(AppColor.textColor2)
                                    ),
                                  ),
                                ),
                              )
                            )
                          ]
                      )
                  ),
                  const Gap(25),
                  myReqDetailController.myReqModel.value.potentialDonors?.indexWhere((donor) => (donor.userId == myReqDetailController.userData.value.userId) && (donor.isConfirm == true) ) != -1?
                  CommonAppButton(
                    buttonType:
                    myReqDetailController.myReqModel.value.potentialDonors?.indexWhere((donor) => (donor.userId == myReqDetailController.userData.value.userId) && (donor.isDonated??false) && (donor.isConfirm == false) ) != -1?
                    ButtonType.enable:
                    ButtonType.disable,
                    text: S.of(context).donation_confirmed,
                    onTap: (){
                      commonDialog(
                          image: AppImage.onBoarding1,
                          text: S.of(Get.context!).donation_confirmed,
                          onTap: (){
                            Get.back();
                          },
                          then: (value){
                            Get.back();
                            myReqDetailController.isShowDonorBottomSheet.value = true;

                          }
                      );
                    },
                  )
                  :CommonAppButton(
                    buttonType:
                    myReqDetailController.myReqModel.value.potentialDonors?.indexWhere((donor) => (donor.userId == myReqDetailController.userData.value.userId) && (donor.isDonated??false) && (donor.isConfirm == false) ) != -1?
                    ButtonType.enable:
                    ButtonType.disable,
                    text: S.of(context).confirm_donation,
                    onTap: (){
                      myReqDetailController.confirmDonationButtonClick(myReqDetailController.myReqModel.value.requestId??"");

                    },
                  )
                ],
              ),
            ),
          );
        }).then((value){
          myReqDetailController.isShowDonorBottomSheet.value = true;
    });
  }
}
