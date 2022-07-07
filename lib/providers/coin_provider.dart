import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'graph_provider.dart';


class CoinInfo with ChangeNotifier{
  Future<List> getCoinData()async {
    try{
      const url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=24h";
      http.Response response = await http.get(Uri.parse(url)).catchError((_){
        Fluttertoast.showToast(
            msg: "Something Went Wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
      final result = jsonDecode(response.body);
      return result;
    } catch(e){
      return [];
    }
  }

  List _popularCoins = [
    "bitcoin",
    "ethereum",
    "matic-network",
    "ripple",
    "solana",
    "cardano",
  ];
  List _popCoins =[];
  List get popCoins{
    return [..._popCoins];
  }
  Future<void> getPopularData() async{
    try{
      List<Map> data = [];
      var result;
      _popularCoins.forEach((element) async {
        String url = "https://api.coingecko.com/api/v3/coins/$element";
        http.Response response = await http.get(Uri.parse(url)).catchError((_){
          Fluttertoast.showToast(
              msg: "Something Went Wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        });
        result =  jsonDecode(response.body);
        data.add(result);
        _popCoins = data;
        notifyListeners();
      });      return result;
    } catch(e){
      throw e.toString();
    }
  }

  List _coinData = [];
  List get coinData{
    return [..._coinData];
  }

  Future<void> getParticularCoinData(String id) async{
    String url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&ids=$id&per_page=100&page=1&sparkline=false";
    final response = await http.get(Uri.parse(url)).catchError((_) {
      Fluttertoast.showToast(
          msg: "Something Went Wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
    final result = jsonDecode(response.body);
    _coinData = result;
    notifyListeners();
  }
}