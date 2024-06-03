import 'dart:convert';


import 'package:plant_app/models/bill_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharePrefs {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<List<BillModel>?> getBills() async {
    SharedPreferences prefs = await _prefs;
    String? data = prefs.getString('listBill');
    if (data == null) return null;
      
    
    List<Map<String, dynamic>> maps = jsonDecode(data)
        .cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;
    List<BillModel> bills = maps.map((e) => BillModel.fromJson(e)).toList();
    return bills;
  }

  Future<void> addBills(List<BillModel> bills) async {
    List<Map<String, dynamic>> maps = bills.map((e) => e.toJson()).toList();
    SharedPreferences prefs = await _prefs;
    prefs.setString('listBill', jsonEncode(maps));
  }
}