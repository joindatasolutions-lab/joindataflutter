import 'package:flutter/material.dart';

class TenantConfig {
  final String id;
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final String logoUrl;
  final Map<String, bool> features;
  final Map<String, dynamic> businessRules;

  TenantConfig({
    required this.id,
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.logoUrl,
    required this.features,
    required this.businessRules,
  });

  /// --------------------------------------------------------
  ///  🔥 Conversión segura de color compatible con Flutter Web
  /// --------------------------------------------------------
  static Color _parseColor(String hex) {
    hex = hex.trim(); // limpia espacios

    // Si ya viene "0xFF4CAF50"
    if (hex.startsWith("0x")) {
      return Color(int.parse(hex));
    }

    // Si viene "FF4CAF50" o "4CAF50"
    if (hex.length == 6) {
      hex = "FF$hex"; // agrega alfa FF
    }

    return Color(int.parse("0x$hex"));
  }

  /// --------------------------------------------------------
  ///  🔥 Factory fromJson corregido
  /// --------------------------------------------------------
  factory TenantConfig.fromJson(Map<String, dynamic> json) {
    return TenantConfig(
      id: json['id'],
      name: json['name'],
      primaryColor: _parseColor(json['primaryColor']),
      secondaryColor: _parseColor(json['secondaryColor']),
      logoUrl: json['logoUrl'],
      features: Map<String, bool>.from(json['features']),
      businessRules: json['businessRules'] ?? {},
    );
  }
}