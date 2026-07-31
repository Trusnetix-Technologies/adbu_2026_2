import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_app_2026/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_2026/utils/constants.dart';

class MovieProvider extends ChangeNotifier {
  // state variables
  List<Movie> _movies = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // public getters
  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // ============= FETCH ALL MOVIES ================
  Future<void> fetchMovies() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('$baseUrl/api/v1/get/movies'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        final List<dynamic> moviesJson = data['response'];
        _movies = moviesJson.map((json) => Movie.fromJson(json)).toList();
      } else {
        _errorMessage =
            "Failed to fetch mo+vies. Server returned: ${response.statusCode}";
      }
    } catch (error) {
      _errorMessage = "Error coonecting to server: $error";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ============= ADD NEW MOVIE ============================
  Future<void> addMovie(Movie movie) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/add/movie'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(movie.toJson()),
      );
      if (response.statusCode == 201) {
        await fetchMovies();
      } else {
        debugPrint('Failed to add movie: ${response.body}');
      }
    } catch (error) {
      debugPrint('Error adding movie: $error');
    }
  }

  // ============= UPDATE MOVIE ============================
  Future<void> updateMovie(String id, Movie movie) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/v1/update/movie/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(movie.toJson()),
      );
      if (response.statusCode == 201) {
        await fetchMovies();
      } else {
        debugPrint('Failed to update movie: ${response.body}');
      }
    } catch (error) {
      debugPrint('Error updating movie: $error');
    }
  }

  // ============= DELETE MOVIE ============================
  Future<void> deleteMovie(String id, Movie movie) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/v1/delete/movie/$id'),
      );
      if (response.statusCode == 200) {
        await fetchMovies();
      } else {
        debugPrint('Failed to update movie: ${response.body}');
      }
    } catch (error) {
      debugPrint('Error updating movie: $error');
    }
  }
}
