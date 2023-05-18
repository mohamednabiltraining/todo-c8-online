import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_c8_online/firebase_options.dart';
import 'package:todo_c8_online/ui/home/home_screen.dart';
import 'package:todo_c8_online/ui/login/login_screen.dart';
import 'package:todo_c8_online/ui/register/register_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          headline4: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true
        ),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFDFECDB),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0
        )
      ),
      routes: {
        RegisterScreen.routeName : (_)=>RegisterScreen(),
        LoginScreen.routeName : (_)=>LoginScreen(),
        HomeScreen.routeName : (_)=>HomeScreen(),
      },
      initialRoute: RegisterScreen.routeName,
    );
  }
}