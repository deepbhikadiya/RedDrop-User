import 'package:flutter/material.dart';
import 'package:ft_red_drop/components/buttons.dart';
import 'package:ft_red_drop/components/input_field.dart';
import 'package:ft_red_drop/module/authorization/register/register_controller.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/utils/app_loader.dart';
import 'package:ft_red_drop/utils/app_toast.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../components/common_appbar.dart';
import '../../../data/network/api_client.dart';
class AadharCardScreen extends StatefulWidget {
  const AadharCardScreen({super.key});

  @override
  State<AadharCardScreen> createState() => _AadharCardScreenState();
}

class _AadharCardScreenState extends State<AadharCardScreen> {
  final registerController = Get.find<RegisterController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    dismissLoader();

    return Scaffold(
      appBar: CommonAppBar(
        automaticallyImplyLeading: false,
        title: Text(S
            .of(context)
            .upload_your_aadhar, style: const TextStyle().normal16w600.textColor(
            AppColor.blackColor),),
      ),
      backgroundColor: AppColor.whiteColor,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Gap(16),
              Text(
                S.of(context).national_identification,
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
                        color: registerController.aadharImage != null ? Colors.transparent : AppColor.textColor,
                      ),
                    ),
                    child: registerController.aadharImage == null
                        ? const Icon(
                      Icons.camera_alt,
                      color: AppColor.textColor,
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        File(registerController.aadharImage?.path ?? ""),
                        fit: BoxFit.fitWidth,
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
                hint: S.of(context).enter_national_id_no,
                controller: registerController.nationalIdNoController,
                focusNode: registerController.nationalIdFocusNode,
                keyboardType: TextInputType.number,
                onChange: (val) {
                  registerController.nationalIdNo.value = val ?? "";
                },
              ),
              Spacer(),
              CommonAppButton(
                buttonType: ButtonType.enable,
                text: S.of(context).register,
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    if (registerController.aadharImage == null) {
                      showErrorToast(S.of(context).please_select_national_identification);
                      return;
                    }

                    await registerController.sendOtpToUser();
                  }
                },
              ),
              const Gap(30),

            ],
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
                  await getAAdharImage(
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
                  await getAAdharImage(
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

  Future getAAdharImage(ImageSource source) async {
    Get.back();
    showLoader();
    try{
      final pickedFile = await registerController.picker.pickImage(source: source);
      if (pickedFile != null) {
        registerController.aadharImage = XFile(pickedFile.path);
        final inputImage = InputImage.fromFilePath(pickedFile.path);
        final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
        final RecognizedText recognisedText = await textRecognizer.processImage(inputImage);

        final RegExp aadharPattern = RegExp(r'\b\d{4}\s\d{4}\s\d{4}\b');
        bool containsAadharCard = false;

        for (TextBlock block in recognisedText.blocks) {
          for (TextLine line in block.lines) {
            if (aadharPattern.hasMatch(line.text)) {
              containsAadharCard = true;
              registerController.nationalIdNoController.text = line.text.trim().replaceAll(' ', '');
              registerController.nationalIdNo.value = line.text.trim().replaceAll(' ', '');

              break;
            } else {

              break;
            }
          }
        }

        if (containsAadharCard) {
        } else {
          dismissLoader();
          registerController.aadharImage = null;
          showErrorSheet("Aadhar Card not detected");
        }
        setState(() {});
      }
      dismissLoader();
    }catch(e){
      dismissLoader();

    }
  }

}
