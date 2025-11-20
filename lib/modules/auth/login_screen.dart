import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flora_app/services/auth_service.dart';
import 'package:flora_app/services/tenant_service.dart';
import 'package:flora_app/tenant/tenant_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  bool loading = false;

  Future<void> login() async {
    setState(() => loading = true);

    final auth = AuthService();
    final response =
        await auth.login(userCtrl.text.trim(), passCtrl.text.trim());

    setState(() => loading = false);

    // ============================================================
    // VALIDAR RESPUESTA LOGIN
    // ============================================================
    if (response["success"] == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("role", response["role"]);

      print("🟢 LOGIN OK, DATA COMPLETA:");
      print(response);

      // ============================================================
      // 1. OBTENER EL TENANT ID DEL LOGIN
      // ============================================================
      final String tenantId = response["tenant"] ?? "default";

      print("🟣 TENANT recibido por Flutter:");
      print(tenantId);

      if (tenantId == null || tenantId == "") {
        print("❌ ERROR: Tenant está vacío o null");
      }

      // ============================================================
      // 2. CARGAR CONFIGURACIÓN DEL TENANT DESDE TU APPS SCRIPT
      // ============================================================
      final tenantService = TenantService();
      final tenantConfig = await tenantService.getTenantConfig(tenantId);

      // ============================================================
      // 3. ACTUALIZAR EL PROVIDER GLOBAL
      // ============================================================
      Provider.of<TenantProvider>(context, listen: false)
          .setConfig(tenantConfig);

      // ============================================================
      // 4. NAVEGAR SEGÚN ROL
      // ============================================================
      switch (response["role"]) {

        case "super_admin":
          Navigator.pushReplacementNamed(context, "/superadmin");
          break;
        case "admin":
          Navigator.pushReplacementNamed(context, "/admin");
          break;
        case "pedidos":
          Navigator.pushReplacementNamed(context, "/pedidos");
          break;
        case "pipeline":
          Navigator.pushReplacementNamed(context, "/pipeline");
          break;
        default:
          Navigator.pushReplacementNamed(context, "/login");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Credenciales incorrectas")),
      );
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFE8F1F5), // Fondo JoinFlow

    body: Center(
      child: Container(
        width: 420,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
              offset: Offset(0, 6),
            )
          ],
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // LOGO
            SizedBox(
              height: 80,
              child: Image.network(
                'assets/images/Join_Data.png',
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Acceso administrador",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0C2D48),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Ingresa tus credenciales",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),

            const SizedBox(height: 25),

            // =====================================================
            //  USUARIO
            // =====================================================
            TextField(
              controller: userCtrl,
              decoration: InputDecoration(
                hintText: "Usuario",
                filled: true,
                fillColor: Colors.grey[100],
                prefixIcon: const Icon(Icons.person_outline),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // =====================================================
            //  CONTRASEÑA
            // =====================================================
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Contraseña",
                filled: true,
                fillColor: Colors.grey[100],
                prefixIcon: const Icon(Icons.lock_outline),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =====================================================
            //  BOTÓN
            // =====================================================
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: loading ? null : login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C86C6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Ingresar", style: TextStyle(fontSize: 16)),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "© Join Data Solutions",
              style: TextStyle(fontSize: 12, color: Colors.black45),
            ),
          ],
        ),
      ),
    ),
  );
}
}