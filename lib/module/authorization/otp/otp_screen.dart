import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/package/screen_packages.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final otpVerificationController = Get.put<OtpVerificationController>(OtpVerificationController());

  @override
  void initState() {
    super.initState();
    otpVerificationController.phoneNumber = Get.arguments['phoneNumber'];
    otpVerificationController.isFromForgetPassword = Get.arguments['isFromForgetPassword'];
    if (!Get.arguments['isFromLogin']) {
      otpVerificationController.userObject = Get.arguments['user_object'];
    }

    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    otpVerificationController.timer?.cancel();
    Get.delete<OtpVerificationController>();
  }

  /// timer for otp
  void startTimer() async {
    otpVerificationController.counter = 60;
    otpVerificationController.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (otpVerificationController.counter > 0) {
          otpVerificationController.counter--;
        } else {
          otpVerificationController.timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: const CommonAppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleSubTitleWidget(
              title: S.of(context).enter_otp,
              subTitle: S.of(context).we_have_just_sent_you_code,
            ),
            const Gap(60),
            Theme(
              data: ThemeData(
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: AppColor.blackColor,
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.blackColor, // Set your desired border color
                    ),
                  ),
                ),
              ),
              child: OTPTextField(
                length: 6,
                controller: otpVerificationController.otpController,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 40,
                isDense: true,
                style: const TextStyle(
                  fontSize: 17,
                ),
                onChanged: (val){

                },
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  otpVerificationController.otpString.value = pin;
                },
              ),
            ),
            const Gap(20),
            otpVerificationController.counter == 00
                ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () async {
                      await otpVerificationController.reSendOTP(phone: otpVerificationController.phoneNumber ?? "");
                    },
                    child: Center(
                      child: Text(
                        S.of(context).resend_code,
                        style: const TextStyle().normal16w500.textColor(AppColor.primaryRed),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          border: Border.all(color: AppColor.primaryRed, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                        child: Text(
                          "00 : ${otpVerificationController.counter.toString().padLeft(2, "0")}",
                          style: const TextStyle().normal14w500.textColor(AppColor.primaryRed),
                        ),
                      ),
                    ),
                  ),
            const Gap(40),
            CommonAppButton(
              onTap: () async {
                await otpVerificationController.verifyPhone(context);
              },
              buttonType: ButtonType.enable,
              text: otpVerificationController.isFromForgetPassword! ? S.of(context).submit : S.of(context).continue_,
            ),
            const Gap(60),
          ],
        ),
      ),
    );
  }
}
