import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticked/utils/authentication_wrapper.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (context) => const AuthenticationWrapper()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/splash_image.png'),
              Text(
                'TICKED',
                style: GoogleFonts.jetBrainsMono(
                    textStyle: const TextStyle(color: Colors.white, fontSize: 50.0),
                letterSpacing: 2.0)
              ),
            ],
          ),
        ),
      ),
    );
  }

}
