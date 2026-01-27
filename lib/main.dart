import 'package:crudfirestoreandpaymentgateway/firebase_option.dart';
import 'package:crudfirestoreandpaymentgateway/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Burger Queen',
      theme: ThemeData(
        fontFamily: 'monospace',
        scaffoldBackgroundColor: const Color(0xFFFFF2D6),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9B97D1),
          primary: const Color(0xFF9B97D1),
          secondary: const Color(0xFFEB8D9F),
          surface: const Color(0xFFFCDCB3),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEB8D9F),
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontFamily: 'monospace',
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: -1,
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFFFCDCB3),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: const BorderSide(color: Colors.black, width: 3),
          ),
          margin: const EdgeInsets.all(0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9B97D1),
            foregroundColor: Colors.black,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: const BorderSide(color: Colors.black, width: 3),
            ),
            textStyle: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(color: Colors.black, width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(color: Colors.black, width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(color: Colors.black, width: 4),
          ),
          labelStyle: const TextStyle(
            fontFamily: 'monospace',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFBDDAF0),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w900,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: AppRoutes.mainnavpage,
      getPages: AppPages.pages,
    );
  }
}
