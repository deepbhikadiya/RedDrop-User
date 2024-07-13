import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:ft_red_drop/global_controller.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/package/screen_packages.dart';
import 'package:ft_red_drop/utils/app_toast.dart';

import 'edit_profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final editProfileController = Get.put<EditProfileController>(EditProfileController());

  final globalController = Get.find<GlobalController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        automaticallyImplyLeading: true,
        title: Text(
          S.of(context).edit_profile,
          style: const TextStyle().normal16w600.textColor(AppColor.blackColor),
        ),
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
                const Gap(10),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showBottomSheetForImage(true);
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // shape: BoxShape.circle,
                        border: Border.all(
                          color: editProfileController.profileImage != null ? Colors.transparent : AppColor.textColor,
                        ),
                      ),
                      child: editProfileController.profileImage == null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: getImageView(
                                finalUrl: globalController.userData.value.image!,
                                height: 150,
                                width: double.infinity,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                File(editProfileController.profileImage?.path ?? ""),
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
                  controller: editProfileController.firstNameController,
                  onChange: (val) {
                    editProfileController.firstName.value = val ?? "";
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
                  controller: editProfileController.middleNameController,
                  onChange: (val) {
                    editProfileController.middleName.value = val ?? "";
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
                  controller: editProfileController.lastNameController,
                  onSubmitted: (va) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onChange: (val) {
                    editProfileController.lastName.value = val ?? "";
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
                            () => editProfileController.selectedGender.value == ""
                                ? Text(
                                    S.of(context).select_gender,
                                    style: const TextStyle(color: AppColor.secondaryColor).normal14w500,
                                  )
                                : Text(
                                    editProfileController.selectedGender.value,
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
                            () => !editProfileController.isDate.value
                                ? Text(
                                    S.of(context).select_birthdate,
                                    style: const TextStyle(color: AppColor.secondaryColor).normal14w500,
                                  )
                                : Text(
                                    DateFormat("dd/MM/yyyy", AppPref().languageCode).format(editProfileController.selectedBirthdate.value),
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
                      return S.of(context).aadhar_number_can_not_be_empty;
                    } else if (val.length != 12) {
                      return S.of(context).invalid_aadhar_number;
                    }
                    return null;
                  },
                  prefixImage: AppImage.nationalIdIcon,
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(12),
                  ],
                  hint: S.of(context).enter_national_id_no + S.of(context).option,
                  controller: editProfileController.nationalIdNoController,
                  focusNode: editProfileController.nationalIdFocusNode,
                  keyboardType: TextInputType.number,
                  onChange: (val) {
                    editProfileController.nationalIdNo.value = val ?? "";
                  },
                ),
                const Gap(16),
                Text(
                  S.of(context).national_identification,
                  style: const TextStyle().normal16w600,
                ),
                const Gap(10),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showBottomSheetForImage(false);
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // shape: BoxShape.circle,
                        border: Border.all(
                          color: editProfileController.aadharImage != null && globalController.userData.value.aadharImage != ""
                              ? Colors.transparent
                              : AppColor.textColor,
                        ),
                      ),
                      child: editProfileController.aadharImage == null && globalController.userData.value.aadharImage == ""
                          ? const Icon(
                              Icons.camera_alt,
                              color: AppColor.textColor,
                            )
                          : editProfileController.aadharImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    File(editProfileController.aadharImage?.path ?? ""),
                                    fit: BoxFit.fitWidth,
                                    height: 150,
                                    width: double.infinity,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: getImageView(
                                    finalUrl: globalController.userData.value.aadharImage!,
                                    height: 150,
                                    width: double.infinity,
                                  ),
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
                  disable: true,
                  prefixImage: AppImage.phoneIcon,
                  hint: S.of(context).enter_phone_number,
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  controller: editProfileController.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  onChange: (val) {
                    editProfileController.phoneNumber.value = val ?? "";
                  },
                ),
                const Gap(16),
                Obx(
                  () => CSCPicker(
                    currentState: 'Gujarat',
                    currentCity: editProfileController.city.value,
                    currentCountry: editProfileController.country.value,
                    defaultCountry: CscCountry.India,
                    disableCountry: true,
                    selectedItemStyle: const TextStyle(color: AppColor.textColor).normal14w500,
                    dropdownDecoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColor.secondaryTextColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    showStates: true,
                    flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                    disabledDropdownDecoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColor.secondaryTextColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onCountryChanged: (value) {
                      editProfileController.country.value = value;
                    },
                    onStateChanged: (value) {
                      editProfileController.state.value = value ?? "";
                    },
                    onCityChanged: (value) {
                      editProfileController.city.value = value ?? "";
                    },
                  ),
                ),
                const Gap(24),
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
                  itemCount: editProfileController.allBloodGroup.length,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        editProfileController.selectedIndex.value = index;
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: editProfileController.selectedIndex.value == index ? AppColor.lightRedColor : AppColor.whiteColor,
                            border: Border.all(
                              width: 2,
                              color: editProfileController.selectedIndex.value == index ? AppColor.primaryRed : AppColor.secondaryColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${editProfileController.allBloodGroup[index]}",
                              style: TextStyle(color: editProfileController.selectedIndex.value == index ? AppColor.primaryRed : AppColor.textColor)
                                  .normal14w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Gap(40),
                CommonAppButton(
                  buttonType: ButtonType.enable,
                  text: S.of(context).edit_profile,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if (editProfileController.profileImage == null && globalController.userData.value.image == "") {
                        showErrorToast(S.of(context).please_select_profile_image);
                        return;
                      }
                      if (editProfileController.selectedGender.value.isEmpty) {
                        showErrorToast(S.of(context).please_select_gender);
                        return;
                      }
                      if (editProfileController.isDate.value == false) {
                        showErrorToast(S.of(context).please_select_valid_birth_date);
                        return;
                      }
                      if (editProfileController.aadharImage == null && globalController.userData.value.aadharImage == "") {
                        showErrorToast(S.of(context).please_select_national_identification);
                        return;
                      }
                      // if (editProfileController.selectedCity.value.isEmpty) {
                      //   showErrorToast(S.of(context).please_select_city);
                      //   return;
                      // }
                      // if (editProfileController.selectedArea.value.isEmpty) {
                      //   showErrorToast(S.of(context).please_select_area);
                      //   return;
                      // }
                      editProfileController.updateProfile(context);
                    }
                  },
                ),
                const Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showBottomSheetForImage(bool isFromProfile) {
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
                  if (isFromProfile) {
                    await getProfileImage(
                      ImageSource.camera,
                    );
                  } else {
                    await getAAdharImage(
                      ImageSource.camera,
                    );
                  }
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
                  if (isFromProfile) {
                    await getProfileImage(
                      ImageSource.gallery,
                    );
                  } else {
                    await getAAdharImage(
                      ImageSource.gallery,
                    );
                  }
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
    final pickedFile = await editProfileController.picker.pickImage(source: source);
    if (pickedFile != null) {
      editProfileController.profileImage = XFile(pickedFile.path);
      // registerController.bits = await registerController.image?.readAsBytes();
      setState(() {});
      Get.back();
    }
  }

  Future getAAdharImage(ImageSource source) async {
    final pickedFile = await editProfileController.picker.pickImage(source: source);
    if (pickedFile != null) {
      editProfileController.aadharImage = XFile(pickedFile.path);
      setState(() {});
      Get.back();
    }
  }

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
                  itemCount: editProfileController.genderList.length,
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
                        editProfileController.selectedGender.value = editProfileController.genderList[index].toString();

                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            editProfileController.genderList[index],
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
                        Duration dif = DateTime.now().difference(editProfileController.selectedBirthdate.value);
                        if (dif.inDays ~/ 365 >= 18 && dif.inDays ~/ 365 <= 65) {
                          editProfileController.isDate.value = true;
                          Get.back();
                        } else {
                          Get.back();
                          editProfileController.isDate.value = false;
                          showSheet(S.of(context).select_birthdate_is_not_eligible_to_donate_blood).then((value) {
                            return editProfileController.selectedBirthdate.value = DateTime.now();
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
                      initialDateTime: editProfileController.selectedBirthdate.value,
                      maximumDate: DateTime.now(),
                      minimumYear: 1900,
                      maximumYear: DateTime.now().year,
                      onDateTimeChanged: (DateTime newDateTime) {
                        editProfileController.selectedBirthdate = newDateTime.obs;
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
      Duration dif = DateTime.now().difference(editProfileController.selectedBirthdate.value);
      if (!(dif.inDays ~/ 365 >= 18 && dif.inDays ~/ 365 <= 65)) {
        editProfileController.isDate.value = false;
        editProfileController.selectedBirthdate.value = DateTime.now();
      }
    });
  }

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
                  itemCount: editProfileController.cityList.length,
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
                        editProfileController.selectedCity.value = editProfileController.cityList[index].toString();

                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            editProfileController.cityList[index],
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
      editProfileController.searchController.clear();
    });
  }

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
                  itemCount: editProfileController.areaList.length,
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
                        editProfileController.selectedArea.value = editProfileController.areaList[index].toString();

                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            editProfileController.areaList[index],
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
}
