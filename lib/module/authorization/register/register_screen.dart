import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/package/screen_packages.dart';
import 'package:ft_red_drop/utils/app_toast.dart';

import '../../bottomBarScreen/profileScreen/padf_viewer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final registerController = Get.put<RegisterController>(RegisterController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: const CommonAppBar(
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleSubTitleWidget(
                    title: S.of(context).personal_information,
                    subTitle: S.of(context).mission_to_save_life,
                  ),
                  const Gap(24),
                  Text(
                    S.of(context).profile_image,
                    style: const TextStyle().normal16w600,
                  ),
                  const Gap(10),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        showBottomSheetForImage();
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          // shape: BoxShape.circle,
                          border: Border.all(
                            color: registerController.profileImage != null ? Colors.transparent : AppColor.textColor,
                          ),
                        ),
                        child: registerController.profileImage == null
                            ? const Icon(
                                Icons.camera_alt,
                                color: AppColor.textColor,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  File(registerController.profileImage?.path ?? ""),
                                  fit: BoxFit.fitWidth,
                                  height: 150,
                                  width: double.infinity,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const Gap(24),
                  InputField(
                    inputFormatter: [UpperCaseTextFormatter()],
                    prefixImage: AppImage.profileIcon,
                    hint: S.of(context).enter_first_name,
                    controller: registerController.firstNameController,
                    onChange: (val) {
                      registerController.firstName.value = val ?? "";
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return S.of(context).first_name_can_not_be_empty;
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  InputField(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return S.of(context).middle_name_can_not_be_empty;
                      }
                      return null;
                    },
                    inputFormatter: [UpperCaseTextFormatter()],
                    prefixImage: AppImage.profileIcon,
                    hint: '${S.of(context).enter_middle_name} ${S.of(context).option}',
                    controller: registerController.middleNameController,
                    onChange: (val) {
                      registerController.middleName.value = val ?? "";
                    },
                  ),
                  const Gap(16),
                  InputField(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return S.of(context).last_name_can_not_be_empty;
                      }
                      return null;
                    },
                    inputFormatter: [UpperCaseTextFormatter()],
                    prefixImage: AppImage.profileIcon,
                    hint: S.of(context).enter_last_name,
                    controller: registerController.lastNameController,
                    onSubmitted: (va) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onChange: (val) {
                      registerController.lastName.value = val ?? "";
                    },
                  ),
                  const Gap(16),
                  GestureDetector(
                    onTap: () {
                      genderBottomSheet();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        border: Border.all(
                          width: 1,
                          color: AppColor.secondaryTextColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10.0, right: 16, left: 16),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Image.asset(
                                AppImage.profileIcon,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            const Gap(8),
                            Obx(
                              () => registerController.selectedGender.value == ""
                                  ? Text(
                                      S.of(context).select_gender,
                                      style: const TextStyle(color: AppColor.secondaryColor).normal14w500,
                                    )
                                  : Text(
                                      registerController.selectedGender.value,
                                      style: const TextStyle(color: AppColor.textColor).normal14w500,
                                    ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColor.secondaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(16),
                  GestureDetector(
                    onTap: () {
                      openDatePicker();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        border: Border.all(
                          width: 1,
                          color: AppColor.secondaryTextColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10.0, right: 16, left: 16),
                        child: Row(
                          children: [
                            SizedBox(
                                height: 24,
                                width: 24,
                                child: Image.asset(
                                  AppImage.calendarIcon,
                                  fit: BoxFit.fitHeight,
                                )),
                            const Gap(8),
                            Obx(
                              () => !registerController.isDate.value
                                  ? Text(
                                      S.of(context).select_birthdate,
                                      style: const TextStyle(color: AppColor.secondaryColor).normal14w500,
                                    )
                                  : Text(
                                      DateFormat("dd/MM/yyyy", AppPref().languageCode).format(registerController.selectedBirthdate.value),
                                      style: const TextStyle(color: AppColor.textColor).normal14w500,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(16),
                  InputField(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return S.of(context).phone_number_can_not_be_empty;
                      } else if (val.length != 10) {
                        return S.of(context).invalid_phone_number;
                      }
                      return null;
                    },
                    prefixImage: AppImage.phoneIcon,
                    hint: S.of(context).enter_phone_number,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    controller: registerController.phoneNumberController,
                    keyboardType: TextInputType.phone,
                    onChange: (val) {
                      registerController.phoneNumber.value = val ?? "";
                    },
                  ),
                  const Gap(16),
                  CSCPicker(
                    defaultCountry: CscCountry.India,
                    disableCountry: true,
                    selectedItemStyle: const TextStyle(color: AppColor.textColor).normal14w500,
                    dropdownDecoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColor.secondaryTextColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                    disabledDropdownDecoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColor.secondaryTextColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onCountryChanged: (value) {
                      registerController.country.value = value;
                    },
                    onStateChanged: (value) {
                      registerController.state.value = value ?? "";
                    },
                    onCityChanged: (value) {
                      registerController.city.value = value ?? "";
                    },
                  ),
                  const Gap(16),
                  InputField(
                    prefixImage: AppImage.referralCode,
                    controller: registerController.referralCodeController,
                    hint: S.of(context).enter_referral_code,
                    onChange: (val) {},
                  ),
                  const Gap(24),
                  Text(
                    S.of(context).your_blood_group,
                    style: const TextStyle().normal16w500.textColor(AppColor.textColor),
                  ),
                  const Gap(12),
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10, mainAxisExtent: 60),
                    shrinkWrap: true,
                    itemCount: registerController.allBloodGroup.length,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          registerController.selectedIndex.value = index;
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: registerController.selectedIndex.value == index ? AppColor.lightRedColor : AppColor.whiteColor,
                              border: Border.all(
                                width: 2,
                                color: registerController.selectedIndex.value == index ? AppColor.primaryRed : AppColor.secondaryColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "${registerController.allBloodGroup[index]}",
                                style: TextStyle(color: registerController.selectedIndex.value == index ? AppColor.primaryRed : AppColor.textColor)
                                    .normal14w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  GestureDetector(
                    onTap: () {
                      registerController.isAccepted.value = !registerController.isAccepted.value;
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              fillColor: registerController.isAccepted.value
                                  ? MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                      if (states.contains(MaterialState.disabled)) {
                                        return Colors.red.withOpacity(.32);
                                      }
                                      return Colors.red;
                                    })
                                  : null,
                              checkColor: AppColor.whiteColor,
                              value: registerController.isAccepted.value,
                              onChanged: (val) {
                                registerController.isAccepted.value = val!;
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        const Gap(8),
                        Expanded(
                          child: Text.rich(
                            textAlign: TextAlign.start,
                            softWrap: true,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "${S.of(context).i_accept_the} ",
                                  style: const TextStyle().normal14w500.textColor(AppColor.textColor),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(() => PdfViewer(path: 'asset/terms_and_condition.pdf', title: S.of(context).terms_and_condition));
                                    },
                                  text: S.of(context).terms_and_condition,
                                  style: const TextStyle(decoration: TextDecoration.underline).normal14w500.textColor(AppColor.primaryRed),
                                ),
                                TextSpan(
                                  text: " ${S.of(context).oof} ",
                                  style: const TextStyle().normal14w500.textColor(AppColor.textColor),
                                ),
                                TextSpan(
                                  text: "RedDrop",
                                  style: const TextStyle().normal14w500.textColor(AppColor.textColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(40),
                  CommonAppButton(
                    buttonType: ButtonType.enable,
                    text: S.of(context).continue_,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (registerController.profileImage == null) {
                          showErrorToast(S.of(context).please_select_profile_image);
                          return;
                        }
                        if (registerController.selectedGender.value.isEmpty) {
                          showErrorToast(S.of(context).please_select_gender);
                          return;
                        }
                        if (registerController.isDate.value == false) {
                          showErrorToast(S.of(context).please_select_valid_birth_date);
                          return;
                        }
                        // if (registerController.aadharImage == null) {
                        //   showErrorToast(S.of(context).please_select_national_identification);
                        //   return;
                        // }
                        // if(registerController.selectedCity.value.isEmpty){
                        //   showErrorToast(S.of(context).please_select_city);
                        //   return;
                        // }
                        // if(registerController.selectedArea.value.isEmpty){
                        //   showErrorToast(S.of(context).please_select_area);
                        //   return;
                        // }
                        Get.toNamed(AppRouter.aadharCardScreen);
                        // await registerController.sendOtpToUser();
                      }
                    },
                  ),
                  const Gap(20),
                  RichTextWidget(
                    onTap: () {
                      Get.back();
                    },
                    text1: "${S.of(context).already_have_an_account}  ",
                    text2: S.of(context).login_here,
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showBottomSheetForImage() {
    FocusManager.instance.primaryFocus?.unfocus();
    return showModalBottomSheet(
      enableDrag: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.whiteColor,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(right: 30, left: 30.0, bottom: 30, top: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: SizedBox(
                  height: 6,
                  width: 35,
                  child: Image.asset(
                    AppImage.modalSheetLine,
                    fit: BoxFit.fill,
                    color: AppColor.textColor,
                  ),
                ),
              ),
              const Gap(20),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  await getProfileImage(
                    ImageSource.camera,
                  );
                },
                child: Row(
                  children: [
                    Text(
                      S.of(context).camera_roll,
                      style: const TextStyle(color: AppColor.textColor).normal14w500,
                    ),
                    Expanded(child: Container()),
                    const Icon(
                      Icons.camera_alt,
                      color: AppColor.textColor,
                      size: 20,
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: Divider(),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  await getProfileImage(
                    ImageSource.gallery,
                  );
                },
                child: Row(
                  children: [
                    Text(
                      S.of(context).gallery,
                      style: const TextStyle(color: AppColor.textColor).normal14w500,
                    ),
                    Expanded(child: Container()),
                    const Icon(
                      Icons.image,
                      color: AppColor.textColor,
                      size: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future getProfileImage(ImageSource source) async {
    final pickedFile = await registerController.picker.pickImage(source: source);
    if (pickedFile != null) {
      registerController.profileImage = XFile(pickedFile.path);
      // registerController.bits = await registerController.image?.readAsBytes();
      setState(() {});
      Get.back();
    }
  }

  /// bottom sheet for selecting gender
  genderBottomSheet() {
    FocusManager.instance.primaryFocus?.unfocus();
    showModalBottomSheet(
      enableDrag: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.whiteColor,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(right: 30, left: 30.0, bottom: 30, top: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: SizedBox(
                  height: 6,
                  width: 35,
                  child: Image.asset(
                    AppImage.modalSheetLine,
                    fit: BoxFit.fill,
                    color: AppColor.textColor,
                  ),
                ),
              ),
              const Gap(20),
              ListView.separated(
                  shrinkWrap: true,
                  itemCount: registerController.genderList.length,
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      child: Divider(),
                    );
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        registerController.selectedGender.value = registerController.genderList[index].toString();

                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            registerController.genderList[index],
                            style: const TextStyle(color: AppColor.textColor).normal14w500,
                          ),
                          Expanded(child: Container()),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColor.textColor,
                            size: 15,
                          )
                        ],
                      ),
                    );
                  }),
            ],
          ),
        );
      },
    );
  }

  /// bottom sheet for selecting city
  cityBottomSheet() {
    FocusManager.instance.primaryFocus?.unfocus();
    showModalBottomSheet(
      enableDrag: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.whiteColor,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(right: 30, left: 30.0, bottom: 30, top: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: SizedBox(
                  height: 6,
                  width: 35,
                  child: Image.asset(
                    AppImage.modalSheetLine,
                    fit: BoxFit.fill,
                    color: AppColor.textColor,
                  ),
                ),
              ),
              const Gap(20),
              ListView.separated(
                  shrinkWrap: true,
                  itemCount: registerController.cityList.length,
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      child: Divider(),
                    );
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        registerController.selectedCity.value = registerController.cityList[index].toString();

                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            registerController.cityList[index],
                            style: const TextStyle(color: AppColor.textColor).normal14w500,
                          ),
                          Expanded(child: Container()),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColor.textColor,
                            size: 15,
                          )
                        ],
                      ),
                    );
                  }),
            ],
          ),
        );
      },
    ).then((value) {
      registerController.searchController.clear();
    });
  }

  /// bottom sheet for selecting area
  areaBottomSheet() {
    return showModalBottomSheet(
      enableDrag: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.whiteColor,
      elevation: 10,
      // gives rounded corner to modal bottom screen
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(right: 30, left: 30.0, bottom: 30, top: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: SizedBox(
                  height: 6,
                  width: 35,
                  child: Image.asset(
                    AppImage.modalSheetLine,
                    fit: BoxFit.fill,
                    color: AppColor.textColor,
                  ),
                ),
              ),
              const Gap(20),
              ListView.separated(
                  shrinkWrap: true,
                  itemCount: registerController.areaList.length,
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: Divider(),
                    );
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        registerController.selectedArea.value = registerController.areaList[index].toString();

                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            registerController.areaList[index],
                            style: const TextStyle(color: AppColor.textColor).normal14w500,
                          ),
                          Expanded(child: Container()),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColor.textColor,
                            size: 15,
                          )
                        ],
                      ),
                    );
                  }),
            ],
          ),
        );
      },
    );
  }

  bool isNid() {
    if (registerController.nationalIdNo.value == "") {
      return true;
    } else if (registerController.nationalIdNo.value.length != 10) {
      return false;
    } else {
      return true;
    }
  }

  void openDatePicker() async {
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
                      },
                      child: Text(
                        S.of(context).cancel,
                        style: const TextStyle(decoration: TextDecoration.none).normal16w500.textColor(AppColor.primaryRed),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Duration dif = DateTime.now().difference(registerController.selectedBirthdate.value);
                        if (dif.inDays ~/ 365 >= 18 && dif.inDays ~/ 365 <= 65) {
                          registerController.isDate.value = true;
                          Get.back();
                        } else {
                          Get.back();
                          registerController.isDate.value = false;
                          showSheet(S.of(context).select_birthdate_is_not_eligible_to_donate_blood, context: context).then((value) {
                            return registerController.selectedBirthdate.value = DateTime.now();
                          });
                        }
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
                      initialDateTime: registerController.selectedBirthdate.value,
                      maximumDate: DateTime.now(),
                      minimumYear: 1900,
                      maximumYear: DateTime.now().year,
                      onDateTimeChanged: (DateTime newDateTime) {
                        registerController.selectedBirthdate = newDateTime.obs;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      Duration dif = DateTime.now().difference(registerController.selectedBirthdate.value);
      if (!(dif.inDays ~/ 365 >= 18 && dif.inDays ~/ 365 <= 65)) {
        registerController.isDate.value = false;
        registerController.selectedBirthdate.value = DateTime.now();
      }
    });
  }

  Future<void> showSheet(String errorText, {Function()? onTap, BuildContext? context}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context!,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        padding: const EdgeInsetsDirectional.only(
          start: 24,
          end: 24,
          top: 18,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 30,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColor.primarySkyBlue,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            for (var data in errorText.split(',')) ...{
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 4),
                      child: CircleAvatar(backgroundColor: context.textTheme.titleLarge?.color, radius: 5),
                    ),
                    const Gap(8),
                    Expanded(
                        child: Text(
                      data.trim().capitalizeFirst!,
                      style: const TextStyle().normal14w500,
                    )),
                  ],
                ),
              ),
            },
            const Gap(16),
            CommonAppButton(
              buttonType: ButtonType.enable,
              onTap: onTap ??
                  () {
                    Navigator.pop(context);
                  },
              text: S.of(context).okay,
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}
