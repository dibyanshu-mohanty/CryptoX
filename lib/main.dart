import 'package:cryptox/providers/fav_provider.dart';
import 'package:cryptox/providers/graph_provider.dart';
import 'package:cryptox/screens/home_screen.dart';
import 'package:cryptox/providers/coin_provider.dart';
import 'package:cryptox/screens/splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context,_,__) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Favourites()),
        ChangeNotifierProvider(create: (context) => CoinInfo()),
          ChangeNotifierProvider(create: (context) => Graphs()),
        ],
        child: MaterialApp(
          title: 'CryptoX',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFF081631),
            canvasColor: Color(0xFF081631),
            fontFamily: "Poppins"
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}