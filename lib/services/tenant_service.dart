import 'package:http/http.dart' as http;
import 'dart:convert';

import '../tenant/tenant_config.dart';

class TenantService {
  final String baseUrl =
      "https://script.google.com/macros/s/AKfycbwtpB6vYEFFyhi6JvUKdzxuvRUR7vfKCH0iVs4EH5NbZI_vTadVYb8I0GI5o-FpP2or/exec";

  // =============================================================
  // 🔵 1. OBTENER CONFIGURACIÓN DE UN TENANT
  // =============================================================
  Future<TenantConfig> getTenantConfig(String tenantId) async {
    final url = Uri.parse("$baseUrl?action=getTenantConfig&tenant=$tenantId");

    print("🟣 URL TENANT:");
    print(url.toString());

    final res = await http.get(url);

    print("🟤 Respuesta TENANT:");
    print(res.body);

    if (res.statusCode != 200) {
      throw Exception("Error obteniendo config del tenant");
    }

    final data = json.decode(res.body);
    return TenantConfig.fromJson(data);
  }

  // =============================================================
  // 🟢 2. LISTAR TODOS LOS TENANTS
  // =============================================================
  Future<List<TenantConfig>> listTenants() async {
    final url = Uri.parse("$baseUrl?action=listTenants");

    print("🔵 URL LIST TENANTS:");
    print(url.toString());

    final res = await http.get(url);

    print("🟢 Respuesta LIST TENANTS:");
    print(res.body);

    if (res.statusCode != 200) {
      throw Exception("Error obteniendo lista de tenants");
    }

    final decoded = json.decode(res.body);

    // 🔥 El arreglo real está en decoded["tenants"]
    final List tenants = decoded["tenants"] ?? [];

    return tenants.map((t) => TenantConfig.fromJson(t)).toList();
  }


  // =============================================================
  // 🟣 3. CREAR / ACTUALIZAR TENANT
  // =============================================================
  Future<bool> saveTenantConfig(Map<String, dynamic> tenantData) async {
    final url = Uri.parse(baseUrl); // <-- YA NO SE USA ?action=

    // agregar acción dentro del body
    tenantData["action"] = "saveTenantConfig";

    print("🟠 URL SAVE TENANT:");
    print(url.toString());

    print("🟠 Enviando data al servidor:");
    print(json.encode(tenantData));

    final res = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(tenantData),
    );

    print("🟣 Respuesta SAVE TENANT:");
    print(res.body);

    if (res.statusCode != 200) {
      throw Exception("Error guardando tenant");
    }

    final Map resp = json.decode(res.body);
    return resp["success"] == true;
  }
}
