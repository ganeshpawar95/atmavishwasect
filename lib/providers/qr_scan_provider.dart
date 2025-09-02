import 'dart:convert';
import 'package:atmavishwasect/utilites/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QrScanProvider extends ChangeNotifier {
  String? qrText;
  String? apiResult;
  Map<String, dynamic>? resultData; // <-- NEW
  bool isLoading = false;
  String? error;

  void setQrText(String text) {
    qrText = text;
    notifyListeners();
  }

  Future<void> fetchResultFromApi() async {
    if (qrText == null || qrText!.isEmpty) {
      error = "QR text is empty";
      notifyListeners();
      return;
    }

    isLoading = true;
    error = null;
    apiResult = null;
    resultData = null; // <-- Clear previous data
    notifyListeners();

    try {
      final uri = Uri.parse("$BASEURL/verifyqr/$qrText");
      debugPrint("Calling API: $uri");

      final response = await http.get(uri);
      debugPrint("Response: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map && decoded['status'] == true) {
          apiResult = decoded['message'] ?? "Verified successfully";
          resultData = decoded['data'] as Map<String, dynamic>?;
        } else {
          error = decoded['message'] ?? "Verification failed";
        }
      } else {
        error = "Server returned ${response.statusCode}";
      }
    } catch (e) {
      error = "Error: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    qrText = null;
    apiResult = null;
    resultData = null;
    error = null;
    isLoading = false;
    notifyListeners();
  }
}
