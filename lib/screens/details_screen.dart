import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:cryptox/providers/coin_provider.dart';
import 'package:cryptox/providers/fav_provider.dart';
import 'package:cryptox/providers/graph_provider.dart';
import 'package:cryptox/widgets/display_graph.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DetailScreen extends StatelessWidget {
  final String id;
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            width: 100.w,
            height: 100.h,
            child: FutureBuilder(
                future: Provider.of<CoinInfo>(context, listen: false)
                    .getParticularCoinData(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        value: 10.0,
                        color: Color(0xFF26324B),
                      ),
                    );
                  }
                  return Consumer<CoinInfo>(builder: (context, data, child) {
                    if (data.coinData.isEmpty) {
                      return Center(
                          child: Lottie.asset("assets/not-added.json",
                              width: 50.w, height: 50.h));
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 2.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 20.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 1.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Image.network(
                                            data.coinData[0]["image"],
                                            scale: 6,
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Text(data.coinData[0]["name"],
                                              softWrap: true,
                                              style: TextStyle(
                                                fontSize: 5.w,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              )),
                                        ],
                                      ),
                                      Text(
                                        "\u{20B9}" +
                                            data.coinData[0]["current_price"]
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                        softWrap: true,
                                      ),
                                      Text(
                                        data.coinData[0][
                                                    "price_change_percentage_24h"]
                                                .toStringAsFixed(2) +
                                            "%",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: data.coinData[0][
                                                        "price_change_percentage_24h"]
                                                    .toString()
                                                    .contains("-")
                                                ? Colors.red
                                                : Colors.lightGreen,
                                            fontWeight: FontWeight.w600),
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<Favourites>(context,
                                                listen: false)
                                            .addFavs(id);
                                        Fluttertoast.showToast(
                                            msg: "Added to Watchlist",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.lightGreen,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      },
                                      child: Icon(
                                        Icons.remove_red_eye,
                                        color: Color(0xFF0a7ff1),
                                      ),
                                    ),
                                    SizedBox(width: 2.w,),
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<Favourites>(context,
                                                listen: false)
                                            .deleteFav(id);
                                        Fluttertoast.showToast(
                                            msg: "Removed from Watchlist",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          DisplayGraph(
                              percent: data.coinData[0]
                                      ["price_change_percentage_24h"]
                                  .toString(),
                              id: id),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            width: 80.w,
                            height: 25.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              color: Color(0xFF26324B),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "24h Low",
                                          style: TextStyle(
                                              fontSize: 4.w,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "\u{20B9} " +
                                              data.coinData[0]["low_24h"]
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 5.w,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "24h High",
                                          style: TextStyle(
                                              fontSize: 4.w,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "\u{20B9} " +
                                              data.coinData[0]["high_24h"]
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 5.w,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                                  child: const Divider(
                                    color: Color(0xFF0a7ff1),
                                    thickness: 1.0,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Market Cap Rank",
                                      style: TextStyle(
                                          fontSize: 4.w,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      data.coinData[0]["market_cap_rank"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 5.w,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h,)
                        ],
                      ),
                    );
                  });
                }),
          ),
        ));
  }
}
