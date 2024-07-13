import 'package:flutter/cupertino.dart';
import 'package:ft_red_drop/components/red_drop/common_outer_container.dart';
import 'package:ft_red_drop/models/address.dart';
import 'package:ft_red_drop/module/bottomBarScreen/createRequestScreen/create_request_controller.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/package/screen_packages.dart';
import 'package:ft_red_drop/utils/app_loader.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../global_controller.dart';

class CreateRequestScreen extends StatefulWidget {
  CreateRequestScreen({super.key});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  final createRequestController = Get.put<CreateRequestController>(CreateRequestController());
  final globalController =Get.find<GlobalController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if(globalController.locationController.value.text.isEmpty){
        PermissionStatus status = await Permission.location.request();
        if (status == PermissionStatus.permanentlyDenied || status == PermissionStatus.denied || status.isRestricted) {
          openAppSettings();
        } else if (status.isGranted) {
          try{
            showLoader();
            await getCurrentLocation().then((value) async {
              await getPlaceMarks(value.latitude, value.longitude).then((List<Placemark> placeMarks) {
                final firstPlaceMark = placeMarks[0];

                createRequestController.address.value = Address(
                  address: globalController.locationController.value.text,
                  coordinates: [
                    value.latitude.toString(),
                    value.longitude.toString(),
                  ],
                );
                globalController.locationController.value.text = '${firstPlaceMark.street}, ${firstPlaceMark.name}, ${firstPlaceMark.locality}';
              });
            });
            dismissLoader();

          }catch(e){
            dismissLoader();
          }
        }
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CommonAppBar(
          title: Text(
            S.of(context).create_a_request,
            style: const TextStyle().normal16w600.textColor(AppColor.blackColor),
          ),
        ),
        backgroundColor: AppColor.whiteColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                controller: globalController.locationController.value,
                hint: S.of(context).choose_current_location,
                onChange: (val){
                  createRequestController.address.value = Address();
                },
              ),
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: CommonOuterContainer(
                      onTap: (){
                        openDatePicker(context);
                      },
                      padding: const EdgeInsets.only(top: 11, bottom: 11.0, right: 13, left: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => !createRequestController.isDate.value
                                ? Text(
                                    S.of(context).date,
                                    style: const TextStyle(color: AppColor.secondaryColor).normal14w500,
                                  )
                                : Text(
                                    DateFormat("dd/MM/yyyy", AppPref().languageCode).format(createRequestController.selectedDate.value),
                                    style: const TextStyle(color: AppColor.textColor).normal14w500,
                                  ),
                          ),
                          InkWell(
                              onTap: () {
                                openDatePicker(context);
                              },
                              child: const Icon(Icons.calendar_today, size: 20, color: AppColor.secondaryColor))
                        ],
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: CommonOuterContainer(
                      onTap: (){
                        openTimePicker(context);
                      },
                      padding: const EdgeInsets.only(top: 9, bottom: 9.0, right: 13, left: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => !createRequestController.isTime.value
                                ? Text(
                                    S.of(context).time,
                                    style: const TextStyle(color: AppColor.secondaryColor).normal14w500,
                                  )
                                : Text(
                                    DateFormat("hh:mm a", AppPref().languageCode).format(createRequestController.selectedDate.value),
                                    style: const TextStyle(color: AppColor.textColor).normal14w500,
                                  ),
                          ),
                          InkWell(
                              onTap: () {
                                openTimePicker(context);
                              },
                              child: const Icon(Icons.watch_later_outlined, size: 24, color: AppColor.secondaryColor))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              InputField(
                controller: createRequestController.noteController.value,
                hint: S.of(context).note,
              ),
              const Gap(10),
              Text(
                S.of(context).blood_group,
                style: const TextStyle().normal16w500.textColor(AppColor.textColor),
              ),
              const Gap(10),
              GridView.builder(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10, mainAxisExtent: 60),
                shrinkWrap: true,
                itemCount: createRequestController.allBloodGroup.length,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      createRequestController.selectedIndex.value = index;
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: createRequestController.selectedIndex.value == index ? AppColor.lightRedColor : AppColor.whiteColor,
                          border: Border.all(
                            width: 2,
                            color: createRequestController.selectedIndex.value == index ? AppColor.primaryRed : AppColor.secondaryColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "${createRequestController.allBloodGroup[index]}",
                            style: TextStyle(color: createRequestController.selectedIndex.value == index ? AppColor.primaryRed : AppColor.textColor)
                                .normal14w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Spacer(),
              CommonAppButton(
                onTap: () async {
                  await createRequestController.createBloodRequest();
                  // Get.toNamed(AppRouter.myRequestDetailScreen);
                },
                buttonType: ButtonType.enable,
                text: S.of(context).create_a_request,
              )
            ],
          ),
        ),
      ),
    );
  }

  void openDatePicker(context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await showCupertinoModalPopup<DateTime>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          color: CupertinoColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24, left: 24, top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        createRequestController.selectedDate.value = DateTime.now();
                        createRequestController.isDate.value = false;
                      },
                      child: Text(
                        S.of(context).cancel,
                        style: const TextStyle(decoration: TextDecoration.none).normal16w500.textColor(AppColor.primaryRed),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        createRequestController.isDate.value = true;
                      },
                      child: Text(
                        S.of(context).done,
                        style: const TextStyle(decoration: TextDecoration.none).normal16w500.textColor(AppColor.primaryRed),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 218,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: const TextStyle(color: AppColor.blackColor).normal14w400,
                    ),
                  ),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      physics: const BouncingScrollPhysics(),
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.trackpad,
                      },
                    ),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: createRequestController.selectedDate.value.isAfter(DateTime.now())
                          ? createRequestController.selectedDate.value
                          : DateTime.now(),
                      maximumDate: DateTime.now().add(const Duration(days: 1000)),
                      minimumDate: DateTime.now().subtract(const Duration(minutes: 1)),
                      onDateTimeChanged: (DateTime newDateTime) {
                        createRequestController.selectedDate.value = newDateTime;
                        createRequestController.isDate.value = true;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void openTimePicker(context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await showCupertinoModalPopup<DateTime>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          color: CupertinoColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24, left: 24, top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        createRequestController.selectedTime.value = DateTime.now();
                        createRequestController.isTime.value = false;
                      },
                      child: Text(
                        S.of(context).cancel,
                        style: const TextStyle(decoration: TextDecoration.none).normal16w500.textColor(AppColor.primaryRed),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        createRequestController.isTime.value = true;
                      },
                      child: Text(
                        S.of(context).done,
                        style: const TextStyle(decoration: TextDecoration.none).normal16w500.textColor(AppColor.primaryRed),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 218,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: const TextStyle(color: AppColor.blackColor).normal14w400,
                    ),
                  ),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      physics: const BouncingScrollPhysics(),
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.trackpad,
                      },
                    ),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: createRequestController.selectedTime.value.isAfter(DateTime.now())
                          ? createRequestController.selectedTime.value
                          : DateTime.now(),
                      maximumDate: DateTime.now().add(const Duration(days: 1000)),
                      minimumDate: DateTime.now().subtract(const Duration(minutes: 1)),
                      onDateTimeChanged: (DateTime newDateTime) {
                        createRequestController.selectedTime.value = newDateTime;
                        createRequestController.isTime.value = true;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
