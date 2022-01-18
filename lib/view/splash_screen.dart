import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../config/web_service.dart';

class SplashScreen extends StatefulWidget {

  static const String routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState()  {
      final myAuthProvider = Provider.of<AuthProvider>(context , listen: false);
      myAuthProvider.checkToken().whenComplete(() async {

        Timer(const Duration(seconds: 2) ,
                () => Navigator.pushReplacementNamed(context, myAuthProvider.hasToken ? "/home" : "/login")
        );

      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(250)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(250),
            child: Image.network(splashImage , fit: BoxFit.cover,),
          ),
        ),
      ),
    );
  }
}
