import 'package:cryptox/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'coin_provider.dart';

class Favourites with ChangeNotifier{
  List _favs = [];

  List get favs {
    return [..._favs];
  }

  void addFavs(String id){
    _favs.add({
      "id" : id,
    });
    notifyListeners();
    DBHelper.insert('favourites', {
      "id" : id,
    });
  }

  void deleteFav(String id){
    _favs.removeWhere((element) => element["id"] == id);
    notifyListeners();
    DBHelper.delete("favourites", id);
  }

  Future<void> fetchAndSetFavs(BuildContext context) async {
    final dataList = await DBHelper.getData('favourites');
    final List coins = [];
    dataList.forEach((element) async{
      coins.add({
        "id" : element["id"],
      });
    });
    _favs = coins;
    notifyListeners();
  }
}