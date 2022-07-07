import 'package:cryptox/providers/fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../screens/details_screen.dart';


class CoinTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String price;
  final String imageUrl;
  final double percent;
  final String id;
  const CoinTile({Key? key,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.price,
    required this.percent,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(id: id,)));
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
              imageUrl,
              scale: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ListTile(
                title: Text(
                  title,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis),
                  softWrap: true,
                ),
                subtitle: Text(
                    subTitle.toUpperCase(),
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFFAEB2BA),
                        fontWeight: FontWeight.w600)),
                trailing: Text(
                  "\u{20B9} ${price}",
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
              child: percent.toString().contains("-")
                ? Chip(
                  label:Text(
                    "${percent.toStringAsFixed(2)}%",
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                backgroundColor: Colors.redAccent.withOpacity(0.4),
              )
              : Chip(
                label:Text(
                  "${percent.toStringAsFixed(2)}%",
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
                backgroundColor: Colors.greenAccent.withOpacity(0.4),
              ),
            )
          ],
        ),
      ),
    );
  }
}
// Provider.of<Favourites>(context,listen: false).addFavs(id, title, subTitle, imageUrl, percent, int.parse(price));