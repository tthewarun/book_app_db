import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      'https://bookapp-49yg.onrender.com/api/'; // URL ของ RESTful API

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        print("JSON Decode Error in login: $e");
        return null;
      }
    } else {
      print("Login request failed with status: ${response.statusCode}");
      return null;
    }
  }

  Future<Map<String, dynamic>?> signup(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'username': username, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        print("JSON Decode Error in signup: $e");
        return null;
      }
    } else {
      print("Signup request failed with status: ${response.statusCode}");
      return null;
    }
  }

  Future<bool> deleteAccount(int userId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$userId'),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print("Delete request failed with status: ${response.statusCode}");
      return false;
    }
  }

  Future<Map<String, dynamic>?> updateProfile(
      int userId, String username, String email, String password) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'username': username, 'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        print("JSON Decode Error in updateProfile: $e");
        return null;
      }
    } else {
      print("Update request failed with status: ${response.statusCode}");
      return null;
    }
  }
}
