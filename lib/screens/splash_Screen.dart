import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cryptox/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    Timer(Duration(seconds: 2), () async{
      var connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult == ConnectivityResult.none){
        Fluttertoast.showToast(
            msg: "Please Check your Internet",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: 100.w,
          height: 100.h,
          alignment: Alignment.center,
          child: Image.asset("assets/splash_logo.png"),
        )
    );
  }
}
