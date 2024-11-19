import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  final String baseUrl = 'https://mediadwi.com/api/latihan';

  Future<Map<String, dynamic>> register(
      String username, String password, String fullName, String email) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/register-user'));

      // form-data fields
      request.fields['username'] = username;
      request.fields['password'] = password;
      request.fields['full_name'] = fullName;
      request.fields['email'] = email;

      request.headers.addAll({
        'Accept': 'application/json',
        // soalny api ny minta form-data
        'Content-Type': 'multipart/form-data',
      });

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      return json.decode(response.body);
    } catch (e) {
      print('Exception: $e');
      return {
        'status': false,
        'message':
            'An error occurred while registering. Please try again later.',
      };
    }
  }
}
