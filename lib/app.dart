import 'package:ft_red_drop/package/config_packages.dart';

class RedDrop extends StatefulWidget {
  const RedDrop({super.key});

  @override
  State<RedDrop> createState() => _RedDropState();
}

class _RedDropState extends State<RedDrop> with WidgetsBindingObserver {
  final List<StreamSubscription> _streams = [];

  var locales = [
    const Locale('en', ''),
    const Locale('gu', ''),
    const Locale('hi', ''),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    FCMUtils.instance.init(_streams);
    super.initState();
  }

  @override
  void dispose() {
    for (var element in _streams) {
      element.cancel();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RedDrop',
      debugShowCheckedModeBanner: false,
      themeMode: AppPref().isDark == null ? ThemeMode.system : (AppPref().isDark! ? ThemeMode.dark : ThemeMode.light),
      getPages: AppRouter.getPages,
      initialRoute: AppRouter.splashScreen,
      locale: Locale(AppPref().languageCode, ''),
      supportedLocales: locales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
