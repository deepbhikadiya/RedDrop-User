import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ft_red_drop/components/common_fun.dart';
import 'package:ft_red_drop/components/red_drop/common_outer_container.dart';
import 'package:ft_red_drop/global_controller.dart';
import 'package:ft_red_drop/models/user_model.dart';
import 'package:ft_red_drop/module/bottomBarScreen/homeScreen/donationReqDetailScreen/donation_req_detail_screen.dart';
import 'package:ft_red_drop/module/bottomBarScreen/homeScreen/home_controller.dart';
import 'package:ft_red_drop/module/bottomBarScreen/homeScreen/myReqDetailScreen/my_req_detail_screen.dart';
import 'package:ft_red_drop/package/config_packages.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  HomeController homeController = Get.put<HomeController>(HomeController());
  late final _tabController = TabController(length: 2,
      vsync: this,
      initialIndex: homeController.currentPageIndex.value);
  final globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 24.0, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return Text(
                            "${S
                                .of(context)
                                .hello} ${globalController.userData.value
                                .firstName?.trim()}!",
                            style: const TextStyle().normal18w600.textColor(
                                AppColor.blackColor),
                          );
                        }),
                        Text(
                          homeController.getCurrentTime(context),
                          style: const TextStyle().normal16w600.textColor(
                              AppColor.textColor2),
                        )
                      ],
                    ),
                  ),
                  Obx(() {
                    return Text(
                      "${globalController.userData.value.stars}",
                      style: const TextStyle().normal14w600.textColor(
                          AppColor.textColor2),
                    );
                  }),
                  const Gap(4),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset(AppImage.starIcon),
                  ),
                  Obx(
                        () =>
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: getImageView(
                              finalUrl: globalController.userData.value.image ??
                                  "", height: 50, width: 50, fit: BoxFit.cover),
                        ),
                  ),
                  // )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: _buildTab(),
            ),
            Obx(() {
              return homeController.currentPageIndex.value == 0
                  ? _buildDonationRequestList()
                  : _buildMyRequestList();
            })
          ],
        ),
      ),
    );
  }

  Widget _buildTab() {
    return Obx(
          () =>
          CommonOuterContainer(
            child: TabBar(
              controller: _tabController,
              splashBorderRadius: BorderRadius.circular(10),
              onTap: (value) async {
                homeController.currentPageIndex.value = value;
              },
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: AppColor.primaryRed,
                borderRadius: BorderRadius.circular(9),
              ),
              dividerHeight: 0,
              tabs: [
                Tab(
                  height: 44,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      S
                          .of(context)
                          .donation_request,
                      textAlign: TextAlign.center,
                      style: const TextStyle().normal14w600.copyWith(
                        color: homeController.currentPageIndex.value == 0
                            ? AppColor.whiteColor
                            : AppColor.primaryRed,
                      ),
                    ),
                  ),
                ),
                Tab(
                  height: 44,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      S
                          .of(context)
                          .your_request,
                      textAlign: TextAlign.center,
                      style: const TextStyle().normal14w600.copyWith(
                        color: homeController.currentPageIndex.value == 1
                            ? AppColor.whiteColor
                            : AppColor.primaryRed,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _showDialogLogOut(BuildContext context, final String? id) async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(S.of(context).are_you_sure_to_decline_blood_request,
              style: const TextStyle().normal16w600.textColor(
                  AppColor.blackColor)),
          actions: [
            CupertinoDialogAction(
              child: Text(
                S
                    .of(context)
                    .cancel,
                style: const TextStyle().normal14w600.textColor(
                    AppColor.textColor2),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: Text(S.of(context).yes,
                  style: const TextStyle().normal14w600.textColor(
                      AppColor.primaryRed)),
              onPressed: () async {
                FirebaseFirestore.instance.runTransaction((transaction) async {
                  // Get the reference to the blood request document
                  var bloodRequestRef = FirebaseFirestore.instance.collection(
                      'blood_request').doc(id);

                  // Fetch the current data
                  var snapshot = await transaction.get(bloodRequestRef);
                  var requestData = snapshot.data();

                  // Modify the potential_donors list
                  var potentialDonors = List.from(
                      requestData?['potential_donors']);
                  potentialDonors.removeWhere((donor) =>
                  donor['user_id'] == AppPref().userId);

                  // Update the document
                  transaction.update(
                      bloodRequestRef, {'potential_donors': potentialDonors});
                  Get.back();
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDonationRequestList() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('blood_request')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(S.of(context).blood_donation_request_not_found,style: const TextStyle().normal16w600.textColor(AppColor.textColor2)),
            );
          }
          var bloodRequests = snapshot.data!.docs.where((doc) {
            var potentialDonors = (doc.data() as Map<String,
                dynamic>)['potential_donors'] ?? [];
            for (var donor in potentialDonors) {
              if (donor is Map<String, dynamic> &&
                  donor['user_id'] == AppPref().userId) {
                return true;
              }
            }
            return false;
          }).toList();

          if (bloodRequests.isEmpty) {
            return Center(
              child: Text(S.of(context).blood_donation_request_not_found,style: const TextStyle().normal16w600.textColor(AppColor.textColor2),),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            itemCount: bloodRequests.length,
            itemBuilder: (context, index) {
              var requestData = bloodRequests[index].data() as Map<
                  String,
                  dynamic>;
              DateTime time = requestData['time'].toDate();
              DateTime date = requestData['date'].toDate();
              String d = DateFormat('dd MMMM yyyy')
                  .format(date);
              String t = DateFormat('hh:mm a')
                  .format(time);
              String formattedDateTime = '$t, $d';


              return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(requestData["user_id"])
                      .get(),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  UserData seeker = UserData.fromMap(snapshot.data!.data() as Map<String, dynamic>);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: CommonOuterContainer(
                      onTap: () {
                        Get.to(() =>
                            DonationReqDetailScreen(id: requestData['request_id']));
                      },
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: getImageView(
                                      finalUrl: seeker.image??"",
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${seeker.firstName} ${seeker.lastName}',
                                      style: const TextStyle().normal14w600
                                          .textColor(AppColor.blackColor),
                                    ),
                                    Text(
                                      '${requestData['location']['address']}',
                                      style: const TextStyle().normal13w600
                                          .textColor(AppColor.textColor3),
                                    ),
                                    Text(
                                      "Time: $formattedDateTime",
                                      style: const TextStyle().normal13w600
                                          .textColor(AppColor.textColor3),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                flex: 1,
                                child: Image.asset(
                                  getBloodImage(requestData['blood_group']),
                                  height: 40,
                                  width: 40,
                                ),
                              )
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                            color: AppColor.secondaryTextColor,
                          ),
                          requestData['potential_donors'].toList().indexWhere((
                              donor) =>
                          (donor["user_id"] == Get
                              .find<GlobalController>()
                              .userData
                              .value
                              .userId) && (donor["is_confirm"] ?? false)) != -1 ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S
                                    .of(context)
                                    .donation_confirmed,
                                style: const TextStyle().normal16w600.textColor(
                                    AppColor.greenColor.withOpacity(.5)),
                              ),
                              const Icon(Icons.check_circle, color: AppColor.greenColor,)
                            ],
                          ) :
                          requestData['potential_donors'].toList().indexWhere((
                              donor) =>
                          (donor["user_id"] == Get
                              .find<GlobalController>()
                              .userData
                              .value
                              .userId) && (donor["is_donated"] ?? false) &&
                              (donor["is_available"] ?? false)) != -1 ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S
                                    .of(context)
                                    .in_pending,
                                style: const TextStyle().normal16w600.textColor(
                                    AppColor.secondaryColor),
                              ),
                            ],
                          ) :
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await _showDialogLogOut(
                                        context, bloodRequests[index].id);
                                  },
                                  child: Center(
                                    child: Text(
                                      S
                                          .of(context)
                                          .decline,
                                      style: const TextStyle().normal16w600
                                          .textColor(AppColor.secondaryColor),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 2,
                                color: AppColor.secondaryTextColor,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    requestData['potential_donors']
                                        .toList()
                                        .indexWhere((donor) =>
                                    (donor["user_id"] == Get
                                        .find<GlobalController>()
                                        .userData
                                        .value
                                        .userId) &&
                                        (donor["is_available"] ?? false)) != -1 ?
                                    S
                                        .of(context)
                                        .i_donated :
                                    S
                                        .of(context)
                                        .donate_now,
                                    style: const TextStyle().normal16w600
                                        .textColor(AppColor.primaryRed),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMyRequestList() {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('blood_request').where(
            'user_id', isEqualTo: AppPref().userId).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryRed,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(S.of(context).blood_donation_request_not_found,style: const TextStyle().normal16w600.textColor(AppColor.textColor2)),
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String,
                  dynamic>;
              DateTime time = data['time'].toDate();
              DateTime date = data['date'].toDate();
              String d = DateFormat('dd MMMM yyyy')
                  .format(date);
              String t = DateFormat('hh:mm a')
                  .format(time);
              String formattedDateTime = '$t, $d';
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: CommonOuterContainer(
                  onTap: () {
                    Get.to(() =>
                        MyRequestDetailScreen(id: data['request_id']));
                  },
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            getBloodImage(data['blood_group']),
                            height: 50,
                            width: 50,
                          ),
                          const Gap(10),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data['location']['address']}',
                                  style: const TextStyle().normal14w600
                                      .textColor(AppColor.textColor2),
                                ),
                                Text(
                                  "Time: $formattedDateTime",
                                  style: const TextStyle().normal13w600
                                      .textColor(AppColor.textColor3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                        color: AppColor.secondaryTextColor,
                      ),
                      Center(
                        child: Text(
                          S
                              .of(context)
                              .view_details,
                          style: const TextStyle().normal16w600.textColor(
                              AppColor.textColor2),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
