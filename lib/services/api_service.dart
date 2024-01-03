import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> getBooks(String authToken) async {
    final response = await _dio.get(
      'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/books',
      options: Options(headers: {'Authorization': 'Bearer $authToken'}),
    );
    return response;
  }
  

  Future<Response> addBook(
      String authToken, Map<String, dynamic> bookData) async {
    final response = await _dio.post(
      'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/books/add',
      options: Options(headers: {'Authorization': 'Bearer $authToken'}),
      data: bookData,
    );
    return response;
  }

  Future<Response> updateBook(
      String authToken, int bookId, Map<String, dynamic> bookData) async {
    final response = await _dio.put(
      'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/books/${bookId.toString()}/edit',
      options: Options(headers: {'Authorization': 'Bearer $authToken'}),
      data: bookData,
    );
    return response;
  }

  Future<Response> getBook(String authToken, String bookId) async {
    final response = await _dio.get(
      'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/books/$bookId',
      options: Options(headers: {'Authorization': 'Bearer $authToken'}),
    );
    return response;
  }

  Future<Response> deleteBook(String authToken, String bookId) async {
    final response = await _dio.delete(
      'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/books/$bookId',
      options: Options(headers: {'Authorization': 'Bearer $authToken'}),
    );
    return response;
  }

  Future<Response> registerUser(Map<String, dynamic> userData) async {
    final response = await _dio.post(
      'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/register',
      data: userData,
    );
    return response;
  }

  Future<Response> loginUser(Map<String, dynamic> credentials) async {
    final response = await _dio.post(
      'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/login',
      data: credentials,
    );
    return response;
  }

  Future<Response> getUserProfile(String authToken) async {
    final response = await _dio.get(
      'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/user',
      options: Options(headers: {'Authorization': 'Bearer $authToken'}),
    );
    return response;
  }

  Future<Response> logoutUser(String authToken) async {
    final response = await _dio.delete(
      'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/user/logout',
      options: Options(headers: {'Authorization': 'Bearer $authToken'}),
    );
    return response;
  }
}
