// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/login_screen.dart';
// ignore: unused_import
import 'package:plant_app/screens/main_screen.dart';
import 'package:plant_app/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _context = context;
  }

  void _checkOnboardingStatus() async {
    bool hasSeenOnboarding = await _getOnboardingStatus();

    if (hasSeenOnboarding) {
      // Nếu đã xem qua Onboarding, điều hướng đến LoginScreen
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          _context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    } else {
      // Nếu chưa xem qua Onboarding, điều hướng đến OnboardingScreen
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          _context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      });
    }
  }

  Future<bool> _getOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('has_seen_onboarding') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("lotties/plant_lottie.json"),
            const SizedBox(height: 24.0),
            const Text(
              'Plant Shop',
              style: TextStyle(
                color: Color.fromARGB(255, 195, 248, 216),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}