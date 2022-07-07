import 'package:cryptox/providers/coin_provider.dart';
import 'package:cryptox/widgets/coin_tile.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({Key? key}) : super(key: key);

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {

  List _coinData = [];
  void getData() async {
    List response = await CoinInfo().getCoinData();
    setState(() {
      _coinData = response;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 2.h,),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text("All Coins",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
            Container(
              height: 100.h,
              child: ListView.builder(
                  itemCount: _coinData.length,
                  itemBuilder: (context, index) => CoinTile(
                    title: _coinData[index]["name"],
                    subTitle: _coinData[index]["symbol"],
                    imageUrl: _coinData[index]["image"],
                    price: _coinData[index]["current_price"]
                        .toString(),
                    percent: _coinData[index]
                    ["price_change_percentage_24h"],
                    id: _coinData[index]["id"],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}