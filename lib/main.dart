import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Tenant
import 'package:flora_app/tenant/tenant_provider.dart';

// Módulos
import 'package:flora_app/modules/orders/features/orders/orders_list_page.dart';
import 'package:flora_app/modules/pipeline/screens/pipeline_screen.dart';
import 'package:flora_app/modules/auth/login_screen.dart';

// Tema base (solo seed)
import 'package:flora_app/modules/theme.dart' as orders_theme;

import 'package:flora_app/super_admin/super_admin_home.dart';
import 'package:flora_app/ui/admin_dashboard_pro.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TenantProvider()),
      ],
      child: const FloraApp(),
    ),
  );
}

class FloraApp extends StatelessWidget {
  const FloraApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tenant = Provider.of<TenantProvider>(context).config;

    final ThemeData finalTheme = tenant == null
        ? orders_theme.buildFloraTheme()
        : ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: tenant.primaryColor,
            ),
            scaffoldBackgroundColor: tenant.secondaryColor.withOpacity(0.03),
            appBarTheme: AppBarTheme(
              backgroundColor: tenant.primaryColor,
              foregroundColor: Colors.white,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: tenant.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          );

    return MaterialApp(
      title: 'Flora App Integrada',
      debugShowCheckedModeBanner: false,
      theme: finalTheme,

      initialRoute: "/login",

      routes: {
        "/login": (_) => const LoginScreen(),
        "/superadmin": (_) => const SuperAdminHome(),
        "/admin": (_) => const AdminDashboardPro(),

        // Módulos
        "/pedidos": (_) => const OrdersListPage(),
        "/pipeline": (_) => const PipelineScreen(),
      },
    );
  }
}
