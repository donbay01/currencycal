// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ApiClient{
  final Uri currencyURL  = Uri.http("free.currconv.com", '/api/v7/currencies',
      {"apiKey": "3729b56fceb7b5e1bc81"});


  Future<List<String>> getCurrencies() async{
    http.Response res = await http.get(currencyURL);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var list = body["results"];
      List<String> currencies = (list.keys).toList();
      print(currencies);
      return currencies;
    }else {
      throw Exception("Failed to connect to api");

    }
  }

  Future<double> getRate(String from, String to) async {
    final Uri rateUrl = Uri.http('free.currconv.com', '/api/v7/convert',
        {
          "apiKey": "3729b56fceb7b5e1bc81",
          "q": "${from}_${to}",
          "compact": "ultra"
        });
    http.Response res = await http.get(rateUrl);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return body["${from}_${to}"];
    }else {
      throw Exception("Failed to connect to Api");
    }

  }
}
