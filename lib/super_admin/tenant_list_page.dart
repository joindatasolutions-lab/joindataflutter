import 'package:flutter/material.dart';
import 'package:flora_app/services/tenant_service.dart';
import 'package:flora_app/tenant/tenant_config.dart';
import 'tenant_edit_page.dart';
import 'widgets/tenant_card.dart';

class TenantListPage extends StatefulWidget {
  const TenantListPage({super.key});

  @override
  State<TenantListPage> createState() => _TenantListPageState();
}

class _TenantListPageState extends State<TenantListPage> {
  List<TenantConfig> tenants = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadTenants();
  }

  Future<void> loadTenants() async {
    final service = TenantService();
    tenants = await service.listTenants();  // debes agregar este método
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Negocios / Tenants")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TenantEditPage()),
        ),
        child: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: tenants.length,
              itemBuilder: (_, i) => TenantCard(config: tenants[i]),
            ),
    );
  }
}
