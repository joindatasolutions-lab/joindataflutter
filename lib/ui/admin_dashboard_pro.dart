import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../tenant/tenant_provider.dart';

class AdminDashboardPro extends StatelessWidget {
  const AdminDashboardPro({super.key});

  @override
  Widget build(BuildContext context) {
    final tenant = Provider.of<TenantProvider>(context).config;

    if (tenant == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      drawer: _buildSidebar(context, tenant),
      appBar: AppBar(
        title: Text("Panel ${tenant.name}"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 900 ? 3 : 1,
            padding: const EdgeInsets.all(20),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: [
              _moduleCard(
                context,
                icon: Icons.shopping_bag,
                label: "Pedidos",
                route: "/pedidos",
                active: tenant.features["pedidos"] == true,
                primaryColor: tenant.primaryColor,
              ),
              _moduleCard(
                context,
                icon: Icons.local_florist,
                label: "Pipeline",
                route: "/pipeline",
                active: tenant.features["pipeline"] == true,
                primaryColor: tenant.primaryColor,
              ),
              _moduleCard(
                context,
                icon: Icons.inventory,
                label: "Inventario (Próximamente)",
                route: "",
                active: tenant.features["inventario"] == true,
                primaryColor: tenant.primaryColor.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, tenant) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: tenant.primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                tenant.logoUrl.isNotEmpty
                    ? Image.network(
                        tenant.logoUrl,
                        height: 70,
                      )
                    : const Icon(Icons.store, color: Colors.white, size: 60),
                const SizedBox(height: 10),
                Text(
                  tenant.name,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("Dashboard"),
            onTap: () => Navigator.pushReplacementNamed(context, "/admin"),
          ),

          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text("Pedidos"),
            onTap: () => Navigator.pushNamed(context, "/pedidos"),
          ),

          ListTile(
            leading: const Icon(Icons.local_florist),
            title: const Text("Pipeline"),
            onTap: () => Navigator.pushNamed(context, "/pipeline"),
          ),

          const Spacer(),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Cerrar sesión"),
            onTap: () => Navigator.pushReplacementNamed(context, "/login"),
          ),
        ],
      ),
    );
  }

  Widget _moduleCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    required bool active,
    required Color primaryColor,
  }) {
    return InkWell(
      onTap: active
          ? () => Navigator.pushNamed(context, route)
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (active)
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 55, color: primaryColor),
            const SizedBox(height: 20),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: active ? Colors.black87 : Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
