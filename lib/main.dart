import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:duapa/onboarding_screen.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/util/translations.dart';
import 'package:duapa/views/account/account.dart';
import 'package:duapa/views/auth_views/coming_soon.dart';
import 'package:duapa/views/auth_views/company_signup_screen.dart';
import 'package:duapa/views/auth_views/farmer_signup_screen.dart';
import 'package:duapa/views/auth_views/forgotpassword_screen.dart';
import 'package:duapa/views/auth_views/general_user_signup.dart';
import 'package:duapa/views/auth_views/group_auths/extension_auth.dart';
import 'package:duapa/views/auth_views/group_auths/transport_auth.dart';
import 'package:duapa/views/auth_views/login_screen.dart';
import 'package:duapa/views/auth_views/other_groups_screen.dart';
import 'package:duapa/views/auth_views/role_screen.dart';
import 'package:duapa/views/blog/blog.dart';
import 'package:duapa/views/controller_bindings.dart';
import 'package:duapa/views/extention_officer/ext_officers_list.dart';
import 'package:duapa/views/home/farmers_union/co_group_list.dart';
import 'package:duapa/views/home/home.dart';
import 'package:duapa/views/home/no_internet.dart';
import 'package:duapa/views/home/notification_screen.dart';
import 'package:duapa/views/home/transport/transport_list.dart';
import 'package:duapa/views/splash_screen.dart';
import 'package:duapa/views/widgets/bottom_navy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // OpenAI.apiKey = 'sk-proj-Drxt3bvpzXTHKGXI8ZdxT3BlbkFJyHiCG6ObXiTApjTCRO5S';
  Gemini.init(apiKey: 'AIzaSyCWtVeGfNxwVlgCy_AcmW_HND64vwhLRTc');
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'welcome',
      channelName: 'Welcome Notification',
      channelDescription: 'Notification for welcome',
    ),
  ]);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String languageCode = prefs.getString('languageCode') ?? 'en';
  runApp(MyApp(languageCode: languageCode));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languageCode});
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      Theme.of(context).brightness == lightThemeData(context).brightness
          ? SystemUiOverlayStyle.light.copyWith(
              statusBarIconBrightness: lightThemeData(context).brightness,
              statusBarBrightness: lightThemeData(context).brightness,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              // statusBarColor is used to set Status bar color in Android devices.
              // statusBarColor: kContentColorLightTheme,

              // To make Status bar icons color white in Android devices.
              statusBarIconBrightness: darkThemeData(context).brightness,

              // statusBarBrightness is used to set Status bar icon color in iOS.
              statusBarBrightness: darkThemeData(context).brightness,
              // Here light means dark color Status bar icons.
            ),
    );
    return GetMaterialApp(
      initialBinding: ControllerBindings(),
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      translations: MyTranslations(),
      locale: Locale(languageCode),
      fallbackLocale: const Locale('en', 'UK'),
      routes: <String, WidgetBuilder>{
        "onboarding": (BuildContext context) => const OnboardingScreens(),
        "home": (BuildContext context) => const HomeScreen(),
        "signup": (BuildContext context) => const Signup(),
        "login": (BuildContext context) => const LoginScreen(),
        "farmersignup": (BuildContext context) => const FarmerSignup(),
        "othergroups": (BuildContext context) => const OtherGroupsScreen(),
        "coomingsoon": (BuildContext context) => const CoomingSoonScreen(),
        'accounts': (BuildContext context) => const AccountPage(),
        'nointernet': (BuildContext context) => const NoInternetScreen(),
        'bottomnavy': (BuildContext context) => const BottomNavy(),
        'forgotpassword': (BuildContext context) =>
            const ForgotPasswordScreen(),
        'role': (BuildContext context) => const RoleScreen(),
        // 'phone': (BuildContext context) => const PhoneSignupScreen(),
        'generaluser': (BuildContext context) => const GeneralSignup(),
        'notification': (BuildContext context) => const NotificationScreen(),
        'government': (BuildContext context) => const GovernmentOfficer(),
        'govenmentofficers': (BuildContext context) =>
            const ExtOfficersScreen(),
        'transport': (BuildContext context) => const TransportAuth(),
        'alldrivers': (BuildContext context) => const TransportScreen(),
        'allcoporategroups': (BuildContext context) =>
            const CoporateGroupScreen(),
        'blog': (BuildContext context) => const BlogScreen(),
        // 'shippingaddress': (BuildContext context) =>
        //     const ShippingAddressScreen(),
      },
    );
  }
}
