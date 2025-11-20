import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // ----------------------------------------------------------
  // GET
  // ----------------------------------------------------------
  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http
          .get(url, headers: _mergeHeaders(headers))
          .timeout(const Duration(seconds: 20));

      _logRequest("GET", url.toString(), response.body);

      return _handleResponse(response);
    } catch (e) {
      throw Exception("Error en GET: $e");
    }
  }

  // ----------------------------------------------------------
  // POST
  // ----------------------------------------------------------
  Future<dynamic> post(String endpoint,
      {Map<String, dynamic>? body,
      Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http
          .post(
            url,
            headers: _mergeHeaders(headers),
            body: jsonEncode(body ?? {}),
          )
          .timeout(const Duration(seconds: 20));

      _logRequest("POST", url.toString(), response.body);

      return _handleResponse(response);
    } catch (e) {
      throw Exception("Error en POST: $e");
    }
  }

  // ----------------------------------------------------------
  // Handle responses
  // ----------------------------------------------------------
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(response.body);
      } catch (_) {
        return response.body; // No es JSON, devuelve texto
      }
    } else {
      throw Exception(
          "Error: ${response.statusCode} - ${response.body}");
    }
  }

  // ----------------------------------------------------------
  // Merge default headers
  // ----------------------------------------------------------
  Map<String, String> _mergeHeaders(Map<String, String>? custom) {
    return {
      "Content-Type": "application/json",
      ...?custom,
    };
  }

  // ----------------------------------------------------------
  // LOG para debug
  // ----------------------------------------------------------
  void _logRequest(String method, String url, String body) {
    print('====== API REQUEST ======');
    print('Method: $method');
    print('URL: $url');
    print('Response: $body');
    print('=========================');
  }
}
