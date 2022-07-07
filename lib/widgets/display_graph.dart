import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/graph_provider.dart';

class DisplayGraph extends StatefulWidget {
  final String id;
  final String percent;
  const DisplayGraph({Key? key,required this.percent, required this.id}) : super(key: key);

  @override
  State<DisplayGraph> createState() => _DisplayGraphState();
}

class _DisplayGraphState extends State<DisplayGraph> {
  int defaultChoiceIndex = 0;
  List<String> _choicesList = [
    "1D",
    "1W",
    "1M",
    "1Y",
  ];
  List<String> _days = [
    "1",
    "7",
    "30",
    "365"
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Graphs>(context,listen: false).getGraphData(_days[defaultChoiceIndex],widget.id),
      builder: (context,snapshot) {
        return Column(
          children: [
            Consumer<Graphs>(
                child: Text(
                  "Unable to Fetch Data",
                  style: TextStyle(
                      fontSize: 3.w, color: Colors.white),
                ),
                builder: (context, graphData, child) {
                  return Container(
                    height: 50.w,
                    margin: EdgeInsets.symmetric(
                        vertical: 2.h, horizontal: 2.5.w),
                    child: Sparkline(
                      data: graphData.graphData,
                      lineColor: widget.percent
                          .contains("-")
                          ? Colors.redAccent
                          : Colors.lightGreenAccent,
                    ),
                  );
                }),
            Container(
                height: 10.h,
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(_choicesList.length, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: ChoiceChip(
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 0.2.h),
                        label: Text(
                          _choicesList[index],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:3.w,
                              fontWeight: FontWeight.w400),
                        ),
                        selected: defaultChoiceIndex == index,
                        selectedColor:
                        Color(0xFF0a7ff1),
                        disabledColor: Theme.of(context).scaffoldBackgroundColor,
                        onSelected: (value){
                          setState(() {
                            defaultChoiceIndex =
                            value ? index : defaultChoiceIndex;
                          });
                          //await Provider.of<Graphs>(context,listen: false).getGraphData(_days[defaultChoiceIndex],widget.id);
                        },
                        // backgroundColor: color,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(horizontal: 6),
                      ),
                    );
                  }),
                )),
          ],
        );
      }
    );
  }
}
