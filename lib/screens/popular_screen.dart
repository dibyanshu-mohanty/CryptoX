import 'package:cryptox/providers/fav_provider.dart';
import 'package:cryptox/providers/coin_provider.dart';
import 'package:cryptox/widgets/coin_tile.dart';
import 'package:cryptox/widgets/coin_tile_big.dart';
import 'package:cryptox/widgets/fav_tile.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Center(
              child: Text(
            "CryptoX",
            style: TextStyle(
                color: Colors.white,
                fontSize: 6.w,
                fontWeight: FontWeight.w600),
          )),
        ),
        body: SafeArea(
            child: FutureBuilder(
                future: Provider.of<CoinInfo>(context, listen: false)
                    .getPopularData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        value: 10.0,
                        color: Color(0xFF26324B),
                      ),
                    );
                  }
                  return SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 3.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Popular Coins",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 5.w,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Consumer<CoinInfo>(
                                  child: Center(
                                      child: Lottie.asset(
                                          "assets/not-added.json",
                                          width: 50.w,
                                          height: 20.w)),
                                  builder: (context, items, child) {
                                    if (items.popCoins.isEmpty) {
                                      return child!;
                                    }
                                    return Container(
                                      height: 25.h,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: ListView.builder(
                                          itemCount: items.popCoins.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) =>
                                              CoinBigTile(
                                                subTitle: items.popCoins[index]
                                                    ["symbol"],
                                                price: items.popCoins[index]
                                                        ["market_data"]
                                                        ["current_price"]["inr"]
                                                    .toString(),
                                                imageUrl: items.popCoins[index]
                                                    ["image"]["large"],
                                                percent: items.popCoins[index]
                                                            ["market_data"][
                                                        "price_change_percentage_24h_in_currency"]
                                                    ["inr"],
                                                id: items.popCoins[index]["id"],
                                              )),
                                    );
                                  }),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Favourites",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 5.w,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              FutureBuilder(
                                  future: Provider.of<Favourites>(context,
                                          listen: false)
                                      .fetchAndSetFavs(context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator(color: Color(0xFF0a7ff1),));
                                    } else {
                                      return Consumer<Favourites>(
                                        child: Center(
                                            child: Lottie.asset(
                                                "assets/not-added.json",
                                                width: 100.0,
                                                height: 100.0)),
                                        builder: (context, data, ch) {
                                          if(data.favs.isEmpty) {
                                            return ch!;
                                          }
                                          return Container(
                                              height: 70.h,
                                              margin:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              child: ListView.builder(
                                                  itemCount: data.favs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return FavouriteTile(id: data.favs[index]["id"]);
                                                  }));
                                        }

                                      );
                                    }
                                  })
                            ]),
                      ));
                })));
  }
}
