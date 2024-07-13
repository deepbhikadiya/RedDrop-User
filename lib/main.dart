import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/package/screen_packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FCMUtils.instance.setupChannel();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await AppPref().isPreferenceReady;

  Get.put<GlobalController>(GlobalController());

  String defaultLocale = "en";
  if (!kIsWeb) {
    defaultLocale = Platform.localeName.split('_')[0];
    AppPref().languageCode = defaultLocale;
    if (AppPref().languageCode.isEmpty) {
      AppPref().languageCode = 'en';
    }
  } else {
    AppPref().languageCode = 'en';
  }
  AppPref().languageCode = 'en';
  runApp(const RedDrop());
}
