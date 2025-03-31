import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PopularRepositoriesViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> _repositories = [];
  bool _isLoading = false;
  String? _error;

  List<Map<String, dynamic>> get repositories => _repositories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchRepositories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final url = Uri.parse("https://api.github.com/users/deepakkaligotla/repos?sort=stars&per_page=6");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _repositories = data.map((repo) {
          return {
            "name": repo["name"] ?? "No Name",
            "description": repo["description"] ?? "No Description",
            "language": repo["language"] ?? "Unknown",
            "stars": repo["stargazers_count"] ?? 0,
          };
        }).toList();
      } else {
        _error = "Failed to load repositories: ${response.statusCode}";
      }
    } catch (e) {
      _error = "An error occurred: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}