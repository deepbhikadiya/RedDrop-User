import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ft_red_drop/components/common_appbar.dart';
import 'package:ft_red_drop/global_controller.dart';
import 'package:ft_red_drop/package/config_packages.dart';

import '../../../../components/common_fun.dart';
import '../../../../components/red_drop/common_outer_container.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        automaticallyImplyLeading: true,
        title: Text(S
            .of(context)
            .donation_history, style: const TextStyle().normal16w600.textColor(
            AppColor.blackColor),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donation_history')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(S.of(context).no_donation_history_found),
            );
          }

          List<QueryDocumentSnapshot> filteredDocs = snapshot.data!.docs.where((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return data['donor']['user_id'] == Get.find<GlobalController>().userData.value.userId;
          }).toList();

          print(filteredDocs);
          if (filteredDocs.isEmpty) {
            return Center(
              child: Text(S.of(context).no_donation_history_found,style: const TextStyle().normal16w600.textColor(AppColor.textColor2)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            itemCount: filteredDocs.length,
            itemBuilder: (context, index) {
              var donationHistory = filteredDocs[index].data() as Map<String, dynamic>;
              Timestamp timestamp = donationHistory['date'];
              DateTime dateTime = timestamp.toDate();
              String formattedDateTime = DateFormat('hh:mm a, dd MMMM yyyy')
                  .format(dateTime);
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: CommonOuterContainer(
                  onTap: () {
                    // Get.to(() =>
                    //     DonationReqDetailScreen(id: donationHistory['request_id']));
                  },
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${donationHistory['location']['address']}',
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
                              getBloodImage(donationHistory['blood_group']),
                              height: 40,
                              width: 40,
                            ),
                          )
                        ],
                      ),
                      const Gap(10),
                      const Divider(
                        thickness: 2,
                        color: AppColor.secondaryTextColor,
                      ),
                      const Gap(10),
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
                        )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
