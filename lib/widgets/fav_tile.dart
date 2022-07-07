import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/coin_provider.dart';
import '../screens/details_screen.dart';
class FavouriteTile extends StatefulWidget {
  final String id;
  const FavouriteTile({Key? key,required this.id}) : super(key: key);

  @override
  State<FavouriteTile> createState() => _FavouriteTileState();
}

class _FavouriteTileState extends State<FavouriteTile> {
  dynamic _coinResponse;

  Future<void> getData() async{
    await Provider.of<CoinInfo>(context, listen: false).getParticularCoinData(widget.id);
    final coinResponse = Provider.of<CoinInfo>(context,listen: false).coinData;
    _coinResponse = coinResponse;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context,snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const SizedBox();
        }
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(id: widget.id,)));
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFF1d2c4b),
                borderRadius: BorderRadius.circular(20.0)),
            width: 80.w,
            height: 15.h,
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            margin: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                  _coinResponse[0]["image"],
                  scale: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ListTile(
                    title: Text(
                      _coinResponse[0]["name"],
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis),
                      softWrap: true,
                    ),
                    subtitle: Text(
                        _coinResponse[0]["symbol"].toUpperCase(),
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFFAEB2BA),
                            fontWeight: FontWeight.w600)),
                    trailing: Text(
                      "\u{20B9} ${_coinResponse[0]["current_price"]}",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                      softWrap: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child:Chip(
                    label:Text(
                      "${_coinResponse[0]["price_change_percentage_24h"].toStringAsFixed(2)}%",
                      style: TextStyle(
                          fontSize: 12.0,
                          color: _coinResponse[0]["price_change_percentage_24h"].toString().contains("-") ?  Colors.red : Colors.lightGreen,
                          fontWeight: FontWeight.bold),
                      softWrap: true,
                    ),
                    backgroundColor: _coinResponse[0]["price_change_percentage_24h"].toString().contains("-") ? Colors.redAccent.withOpacity(0.4) : Colors.lightGreenAccent.withOpacity(0.4),
                  )
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
