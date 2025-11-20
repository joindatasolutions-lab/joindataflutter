import 'package:flutter/material.dart';
import 'package:flora_app/services/tenant_service.dart';
import 'package:flora_app/tenant/tenant_config.dart';
import 'package:flora_app/super_admin/widgets/feature_toggle.dart';

class TenantEditPage extends StatefulWidget {
  final TenantConfig? config;

  const TenantEditPage({super.key, this.config});

  @override
  State<TenantEditPage> createState() => _TenantEditPageState();
}

class _TenantEditPageState extends State<TenantEditPage> {
  final nameCtrl = TextEditingController();
  final primaryCtrl = TextEditingController();
  final secondaryCtrl = TextEditingController();
  final logoCtrl = TextEditingController();

  Map<String, bool> features = {
    "pedidos": false,
    "pipeline": false,
    "inventario": false
  };

  @override
  void initState() {
    super.initState();
    if (widget.config != null) {
      final c = widget.config!;
      nameCtrl.text = c.name;
      primaryCtrl.text = c.primaryColor.value.toRadixString(16);
      secondaryCtrl.text = c.secondaryColor.value.toRadixString(16);
      logoCtrl.text = c.logoUrl;
      features = Map<String, bool>.from(c.features);
    }
  }

  Future<void> save() async {
    final service = TenantService();

    // 🔵 Normalizar los colores sin cambiar el newConfig
    String fixColor(String value) {
      if (value.startsWith("0x")) return value;
      return "0x${value.toUpperCase()}";
    }

    // 🔵 Clonar el mapa sin modificar tu código original
    final Map<String, dynamic> fixedConfig = {
      "action": "saveTenantConfig",     // ← OBLIGATORIO
      "name": nameCtrl.text.trim(),
      "primaryColor": fixColor(primaryCtrl.text.trim()),
      "secondaryColor": fixColor(secondaryCtrl.text.trim()),
      "logoUrl": logoCtrl.text.trim(),
      "features": features,
    };
    

    // 🔵 Agregar tenantId automáticamente sin alterar tu newConfig original
    fixedConfig["tenant"] = (widget.config?.id ??
        nameCtrl.text.trim().toLowerCase().replaceAll(" ", "_"));

    final ok = await service.saveTenantConfig(fixedConfig);

    if (!mounted) return;

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tenant guardado exitosamente")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al guardar tenant")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.config == null
            ? "Crear Tenant"
            : "Editar Tenant"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(labelText: "Nombre del negocio"),
          ),

          const SizedBox(height: 20),
          TextField(
            controller: logoCtrl,
            decoration: const InputDecoration(labelText: "Logo (URL)"),
          ),

          const SizedBox(height: 20),
          TextField(
            controller: primaryCtrl,
            decoration: const InputDecoration(labelText: "Color primario (0xFF...)"),
          ),

          const SizedBox(height: 20),
          TextField(
            controller: secondaryCtrl,
            decoration: const InputDecoration(labelText: "Color secundario (0xFF...)"),
          ),

          const SizedBox(height: 30),
          const Text("Módulos disponibles", style: TextStyle(fontSize: 18)),

          FeatureToggle(
            label: "Pedidos",
            value: features["pedidos"] ?? false,
            onChanged: (v) => setState(() => features["pedidos"] = v!),
          ),
          FeatureToggle(
            label: "Pipeline",
            value: features["pipeline"] ?? false,
            onChanged: (v) => setState(() => features["pipeline"] = v!),
          ),
          FeatureToggle(
            label: "Inventario",
            value: features["inventario"] ?? false,
            onChanged: (v) => setState(() => features["inventario"] = v!),
          ),


          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: save,
            child: const Text("Guardar Tenant"),
          ),
        ],
      ),
    );
  }
}
