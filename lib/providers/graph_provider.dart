
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Graphs with ChangeNotifier{
  List<double> _graphData = [];
  List<double> get graphData{
    return [..._graphData];
  }

  Future<void> getGraphData(String time,String id) async{
    final response = await http.get(Uri.parse("https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=inr&days=$time"),);
    final result = <double>[];
    List data = jsonDecode(response.body)["prices"];
    for(var i in data){
      result.add(i[1]);
    }
    _graphData = result;
    notifyListeners();
  }
}