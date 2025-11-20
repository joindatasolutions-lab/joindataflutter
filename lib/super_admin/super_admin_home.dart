import 'package:flutter/material.dart';
import 'tenant_list_page.dart';

class SuperAdminHome extends StatelessWidget {
  const SuperAdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF0A84FF)),
              child: Center(
                child: Text(
                  "JOIN DATA — Super Admin",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text("Tenants / Negocios"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TenantListPage()),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Super Panel Administrador"),
      ),
      body: const Center(
        child: Text(
          "Bienvenido al Panel Global de Join Data",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
