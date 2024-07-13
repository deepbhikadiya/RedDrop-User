

import 'package:ft_red_drop/module/authorization/questionnairesScreen/questionnaires_screen.dart';
import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/package/screen_packages.dart';

class AppRouter {
  static const loginScreen = '/loginScreen';
  static const splashScreen = '/splashScreen';
  static const forgotPasswordScreen = '/forgotPasswordScreen';
  static const registerScreen = '/registerScreen';
  static const otpVerificationScreen = '/otpVerificationScreen';
  static const bottomBarScreen = '/bottomBarScreen';
  static const questionnairesScreen = '/questionnairesScreen';
  static const createRequestScreen = '/createRequestScreen';
  static const editProfileScreen = '/editProfileScreen';
  static const changeLanguageScreen = '/changeLanguageScreen';
  static const historyScreen = '/historyScreen';
  static const aadharCardScreen = '/aadharCardScreen';
  static const onBoardingScreen = '/onBoardingScreen';


  static List<GetPage> getPages = [
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: forgotPasswordScreen, page: () => const ForgotPasswordScreen()),
    GetPage(name: registerScreen, page: () => const RegisterScreen()),
    GetPage(name: otpVerificationScreen, page: () =>  const OtpVerificationScreen()),
    GetPage(name: bottomBarScreen, page: () =>  const BottomBarScreen()),
    GetPage(name: questionnairesScreen, page: () =>  QuestionnairesScreen()),
    GetPage(name: createRequestScreen, page: () =>  CreateRequestScreen()),
    GetPage(name: editProfileScreen, page: () =>  const EditProfileScreen()),
    GetPage(name: changeLanguageScreen, page: () =>  ChangeLanguageScreen()),
    GetPage(name: historyScreen, page: () =>  const HistoryScreen()),
    GetPage(name: aadharCardScreen, page: () =>  const AadharCardScreen()),
    GetPage(name: onBoardingScreen, page: () =>  const OnBoardingScreen()),
  ];
}
