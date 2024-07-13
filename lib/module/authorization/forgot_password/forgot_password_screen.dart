import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/package/screen_packages.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final forgetPasswordController = Get.put<ForgotPasswordController>(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        resizeToAvoidBottomInset: false,
        appBar: const CommonAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleSubTitleWidget(
                title: S.of(context).forgot_password,
                subTitle: S.of(context).don_worry_it_happen,
              ),
              const Gap(24),
              InputField(
                prefixImage: AppImage.phoneIcon,
                hint: S.of(context).enter_phone_number,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                textInputAction: TextInputAction.done,
                controller: forgetPasswordController.phoneNumberController,
                keyboardType: TextInputType.phone,
                onChange: (val) {
                  forgetPasswordController.phoneNumber.value = val ?? "";
                },
              ),
              const Gap(40),
              Obx(
                () => CommonAppButton(
                  buttonType: forgetPasswordController.phoneNumber.value.length < 10 ? ButtonType.disable : ButtonType.enable,
                  onTap: () {},
                  text: S.of(context).submit,
                ),
              ),
              const Gap(60),
            ],
          ),
        ),
      ),
    );
  }
}
