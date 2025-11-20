import 'package:flutter/material.dart';
import 'tenant_config.dart';

class TenantProvider extends ChangeNotifier {
  TenantConfig? _config;

  TenantConfig? get config => _config;

  void setConfig(TenantConfig cfg) {
    _config = cfg;
    notifyListeners();
  }
}
