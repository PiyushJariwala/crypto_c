import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigation();
  }

  void _navigation()
  async{
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/images/crypto.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100,left: 20,right: 20),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 3,color: Colors.white70),
                borderRadius: BorderRadius.circular(20),
                color: Colors.black54,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Welcome To Crypto Market",
                  style: TextStyle(
                    color: Colors.lightBlue.shade200,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    decorationColor: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
