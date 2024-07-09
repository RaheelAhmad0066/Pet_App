import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:healmypet/appassets/colors/colors.dart';
import 'package:healmypet/firebase_option.dart';
import 'package:healmypet/view/Screens/joine_as_Petowner/splashscreen/splashscreen.dart';
import 'view/Screens/joine_as_Petowner/Add Profile/controller/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  Get.put(PetProfileController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: bgcolor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(
            backgroundColor: bgcolor,
            iconTheme: IconThemeData(color: whitecolor)),
        useMaterial3: true,
      ),
      home: Splashscreen(),
    );
  }
}
