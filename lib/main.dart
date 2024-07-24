import 'package:awdotcom/Authtentication/signup.dart';
import 'package:awdotcom/Pages/home_page.dart';
import 'package:awdotcom/controller/home_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';

import 'Pages/add_product_page.dart';

//import 'Authtentication/signup.dart'; // Import Firebase Auth
//import 'package:flutter_firebase/features/app/splash_screen/splash_screen.dart';
//import 'package:flutter_firebase/features/user_auth/presentation/pages/home_page.dart';
//import 'package:flutter_firebase/features/user_auth/presentation/pages/login_page.dart';
//import 'package:flutter_firebase/features/user_auth/presentation/pages/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA8K1CZYStHpjf5Xvi4kH5h1-8jC1dVRiQ",
        appId: "1:544666270824:android:1b4705fc35b67b69b00fdd",
        messagingSenderId: "544666270824",
        projectId: "flutter-firebase-6e376",
        storageBucket: "gs://flutter-firebase-6e376.appspot.com",
        // Your web Firebase config options
      ),

    );
  await FirebaseAppCheck.instance.activate(
      // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
      // argument for `webProvider`
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
  // your preferred provider. Choose from:
  // 1. Debug provider
  // 2. Safety Net provider
  // 3. Play Integrity provider
  androidProvider: AndroidProvider.debug,
  );
    //await Firebase.initializeApp();
  Get.put(HomeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      /*routes: {
        '/': (context) => SplashScreen(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
      },*/
      //home: const SignUp(),
      home: const HomePage(),
    );

  }
}