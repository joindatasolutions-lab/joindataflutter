import 'package:flutter/material.dart';
import 'package:flora_app/tenant/tenant_config.dart';
import '../tenant_edit_page.dart';

class TenantCard extends StatelessWidget {
  final TenantConfig config;

  const TenantCard({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(config.logoUrl),
        ),
        title: Text(config.name),
        subtitle: Text("ID: ${config.id}"),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TenantEditPage(config: config),
            ),
          ),
        ),
      ),
    );
  }
}
