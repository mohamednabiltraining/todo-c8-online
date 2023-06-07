import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c8_online/providers/auth_provider.dart';
import 'package:todo_c8_online/ui/home/home_screen.dart';
import 'package:todo_c8_online/ui/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = 'splash-screen';

  void checkLoggedInUser(BuildContext context) async {
    var authProvider = Provider.of<AuthProvider>(context,listen: false);

    if (FirebaseAuth.instance.currentUser != null) {
      var user = await authProvider.getUserFromDataBase();
      if (user != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        return;
      }
    }

    Navigator.pushReplacementNamed(context, LoginScreen.routeName);

  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      checkLoggedInUser(context);
    });
    return Scaffold(
      body: Image.asset(
        'assets/images/splash_screen.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
