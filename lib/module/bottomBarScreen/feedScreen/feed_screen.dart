import 'package:ft_red_drop/components/common_appbar.dart';
import 'package:ft_red_drop/module/bottomBarScreen/feedScreen/feed_controller.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../../../package/config_packages.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final feedController = Get.put<FeedController>(FeedController());

  final List<PageController> _pageControllers = [];
  final List<int> _currentPages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        automaticallyImplyLeading: false,
        title: Text(S
            .of(context)
            .feed, style: const TextStyle().normal16w600.textColor(
            AppColor.blackColor),),
      ),
      backgroundColor: AppColor.whiteColor,
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: () async {
            int length = feedController.postList.length;
            await feedController.getAllPost();
            feedController.postList.removeRange(0, length);
          },
          color: AppColor.primaryRed,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Gap(50);
            },
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: feedController.postList.length,
            itemBuilder: (context, index) {
              _pageControllers.add(PageController());
              _currentPages.add(0);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColor.primaryRed,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Image.asset(AppImage.appLogoJpeg,fit: BoxFit.fitWidth),
                        ),
                        const Gap(20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "RedDrop Community",
                                style: const TextStyle().normal14w800,
                                maxLines: 1,
                              ),
                              Text(
                                feedController.postList[index].location??"",
                                style: const TextStyle().normal12w500.textColor(AppColor.textColor2),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: _pageControllers[index],
                            scrollDirection: Axis.horizontal,
                            itemCount: feedController.postList[index].imageUrls?.length ?? 0,
                            itemBuilder: (context, idx) {
                              return getImageView(
                                finalUrl: feedController.postList[index].imageUrls?[idx] ?? "",
                                fit: BoxFit.cover,
                              );
                            },
                            onPageChanged: (int page) {
                              setState(() {
                                _currentPages[index] = page;
                              });
                            },
                          ),
                        ),
                        const Gap(10),
                        DotsIndicator(
                          dotsCount: feedController.postList[index].imageUrls?.length ?? 0,
                          position: _currentPages[index],
                          decorator: DotsDecorator(
                            color: AppColor.lightRedColor, // Inactive dot color
                            activeColor: AppColor.primaryRed, // Active dot color
                            size: const Size.square(9.0), // Size of the dots
                            activeSize: const Size.square(9.0), // Size of the active dot
                            spacing: const EdgeInsets.symmetric(horizontal: 2.0), // Spacing between the dots
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ), // Shape of the active dot
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Text(
                      "${feedController.postList[index].title}",
                      style: const TextStyle().normal16w600.textColor(
                          AppColor.textColor2),
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Text(
                      DateFormat('MMMM dd,yyyy hh:mm a').format(feedController.postList[index].createdAt!),
                      style: const TextStyle().normal12w500.textColor(
                          AppColor.textColor2),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
