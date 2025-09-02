import 'dart:convert';
import 'package:atmavishwasect/utilites/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  List<String> _categories = [];
  bool _isLoading = false;

  List<String> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse('$BASEURL/category/list'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> categoryList = data['data'] ?? [];
        _categories = categoryList
            .map<String>((item) => item['name'].toString())
            .toList();
      } else {
        print('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}
