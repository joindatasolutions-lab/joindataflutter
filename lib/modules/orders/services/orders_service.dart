import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flora_app/modules/orders/models/pedido.dart';

class OrdersService {
  // 🟢 URL del Apps Script exclusivo para el módulo Orders
  static const String baseUrl =
      "https://script.google.com/macros/s/AKfycbxROcbC9sppAbKIcjzakCbekQyXypWL7r4PzJESSGtGItGER89HC5SzvlnKknQPmItt/exec"; // ⚠️ reemplaza con tu URL real

  /// 📥 Obtener todos los pedidos desde Google Sheets
  static Future<List<Pedido>> getOrders() async {
    final response = await http.get(Uri.parse(baseUrl));
  
    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");
  
    if (response.statusCode != 200) {
      throw Exception("Error ${response.statusCode}");
    }
  
    final decoded = jsonDecode(response.body);
    final List pedidos = decoded["pedidos"] ?? [];
    print("Pedidos recibidos: ${pedidos.length}");
  
    return pedidos.map((e) => Pedido.fromJson(e)).toList();
  }
 

  /// 📤 Guardar o actualizar un pedido existente
  static Future<String> saveOrder(Pedido pedido) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(pedido.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception("Error al guardar pedido: ${res.statusCode}");
    }

    final data = jsonDecode(res.body);
    return data["message"] ?? "Pedido actualizado correctamente";
  }

}
