import 'package:cryptox/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CoinBigTile extends StatelessWidget {
  final String subTitle;
  final String price;
  final String imageUrl;
  final double percent;
  final String id;
  const CoinBigTile({Key? key,
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
        width: 35.w,
        height: 10.h,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        margin: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(
              imageUrl,
              scale:6,
            ),
            Text(
                subTitle.toUpperCase(),
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700)
            ),
            Text(
              "\u{20B9}" + price,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
              softWrap: true,
            ),
           Text(
                  percent.toStringAsFixed(2) + "%",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: percent.toString().contains("-") ? Colors.red : Colors.lightGreen,
                      fontWeight: FontWeight.w600),
                  softWrap: true,
                ),
          ],
        ),
      ),
    );
  }
}
