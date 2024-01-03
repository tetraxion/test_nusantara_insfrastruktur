// ignore_for_file: unnecessary_overrides

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nusantarainfra_test/services/api_service.dart';

class DataController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  var books = <dynamic>[].obs;
  var isLoading = false.obs;

  var isLoggedIn = false.obs;
  var currentUser = {}.obs;
  var authToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> registerUser(Map<String, dynamic> userData) async {
    try {
      isLoading(true);
      final response = await _apiService.registerUser(userData);
      final data = response.data;

      authToken(data['token']);
    } catch (error) {
      isLoggedIn(false);
      currentUser({});
      throw Exception('Failed to register: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> loginUser(String username, String password) async {
    try {
      isLoading(true);
      final response = await _apiService
          .loginUser({'email': username, 'password': password});
      final data = response.data;
      isLoggedIn(true);
      authToken(data['token']);

      final res = await _apiService.getUserProfile(authToken.value);
      currentUser(res.data);
      debugPrint("Current User Name: ${currentUser['name']}");
      debugPrint('Current User: $currentUser');
    } catch (error) {
      isLoggedIn(false);
      currentUser({});
      throw Exception('Failed to login: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> logoutUser() async {
    try {
      isLoading(true);
      await _apiService.logoutUser(authToken.value);
      isLoggedIn(false);
      currentUser({});
      authToken('');
    } catch (error) {
      throw Exception('Failed to logout: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchBooks() async {
    try {
      isLoading(true);
      final response = await _apiService.getBooks(authToken.value);
      final data = response.data;
      if (data is List<dynamic>) {
        books.assignAll(data);
      } else if (data is Map<String, dynamic>) {
        books.assignAll([data]);
      } else {
        throw Exception('Invalid response format');
      }
    } catch (error) {
      throw Exception('Failed to fetch books: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addBook(Map<String, dynamic> bookData) async {
    try {
      isLoading(true);
      await _apiService.addBook(authToken.value, bookData);
      await fetchBooks();
    } catch (error) {
      throw Exception('Failed to add book: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateBook(int bookId, Map<String, dynamic> bookData) async {
    try {
      isLoading(true);
      await _apiService.updateBook(authToken.value, bookId, bookData);
      await fetchBooks();
    } catch (error) {
      throw Exception('Failed to update book: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteBook(String bookId) async {
    try {
      isLoading(true);
      await _apiService.deleteBook(authToken.value, bookId);
      await fetchBooks();
    } catch (error) {
      throw Exception('Failed to delete book: $error');
    } finally {
      isLoading(false);
    }
  }
}
