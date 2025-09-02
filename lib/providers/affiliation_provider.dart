import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/affiliation_model.dart';

class AffiliationProvider with ChangeNotifier {
  List<AffiliationModel> _affiliations = [];
  bool _hasReachedMax = false;
  int _offset = 0;

  final int _limit = 10;
  String _name = "";
  String _category = "";
  bool _isLoading = false;

  List<AffiliationModel> get affiliations => _affiliations;
  bool get hasReachedMax => _hasReachedMax;
  bool get isLoading => _isLoading;

  Future<void> fetchAffiliations({bool isRefresh = false}) async {
    if (_hasReachedMax && !isRefresh) return;

    _isLoading = true;
    notifyListeners();

    if (isRefresh) {
      _affiliations.clear();
      _offset = 0;
      _hasReachedMax = false;
    }

    final uri =
        Uri.https('manager.atmavishwasect.org', '/api/affiliation/list', {
          'limit': _limit.toString(),
          'offset': _offset.toString(),
          if (_name.isNotEmpty) 'name': _name,
          if (_category.isNotEmpty) 'category': _category,
        });

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> list = data['data'];

        if (list.length < _limit) {
          _hasReachedMax = true;
        }

        _affiliations.addAll(
          list.map((e) => AffiliationModel.fromJson(e)).toList(),
        );
        _offset += _limit;
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void setFilters({String? name, String? category}) {
    _name = name ?? "";
    _category = category ?? "";
    fetchAffiliations(isRefresh: true);
  }
}
