import 'package:ft_red_drop/package/screen_packages.dart';

import '../../../package/config_packages.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginController = Get.put<LoginController>(LoginController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: const CommonAppBar(
          automaticallyImplyLeading: false,
        ),
        backgroundColor: AppColor.whiteColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 10),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 40,
                        child: Image.asset(
                          AppImage.appLogoJpeg,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const Gap(20),
                    TitleSubTitleWidget(
                      title: S.of(context).welcome_back,
                      subTitle: S.of(context).please_enter_your_phone_number_to_login,
                    ),
                    const Gap(24),
                    Form(
                      key: formKey,
                      child: InputField(
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
                        controller: loginController.phoneNumberController,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const Gap(50),
                    CommonAppButton(
                      buttonType: ButtonType.enable,
                      text: S.of(context).login,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await loginController.sendOtpToUser();
                        }
                      },
                    ),
                  ],
                ),
              ),
              RichTextWidget(
                onTap: () {
                  Get.toNamed(AppRouter.registerScreen);
                },
                text1: "${S.of(context).don_have_an_account}  ",
                text2: S.of(context).register,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
