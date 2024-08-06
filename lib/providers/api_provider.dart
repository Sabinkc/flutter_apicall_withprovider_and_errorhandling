import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ApiProvider extends ChangeNotifier {
  String? error;
  List data = [];
  Future fetchData() async {
    var url = "https://jsonplaceholder.typicode.com/users";
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List fetcheddata = jsonDecode(response.body);
        data = fetcheddata;
      } else {
        error = "cannot load data";
      }
    } catch (e) {
      error = " $e";
    }
    notifyListeners();
  }
}
