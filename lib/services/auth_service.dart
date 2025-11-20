import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl =
      "https://script.google.com/macros/s/AKfycbwtpB6vYEFFyhi6JvUKdzxuvRUR7vfKCH0iVs4EH5NbZI_vTadVYb8I0GI5o-FpP2or/exec";

  Future<Map<String, dynamic>> login(String user, String pass) async {
    final url = Uri.parse("$baseUrl?action=login&user=$user&pass=$pass");
  
    print("🔵 URL LOGIN que Flutter está enviando:");
    print(url.toString());
  
    final response = await http.get(url);
  
    print("🟢 Respuesta cruda del servidor:");
    print(response.body);
  
    return json.decode(response.body);
  }
}
