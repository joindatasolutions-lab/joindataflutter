import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pipeline/models/pedido.dart';

// ===========================
// Colores de marca
// ===========================
const kFloraWhite = Color(0xFFFEFEFE); // Fondo general blanco
const kFloraIvory = Color(0xFFFAF7EC); // Color cálido (blanco hueso) para las tarjetas
const kFloraBlush = Color(0xFFEDD5DA);
const kFloraDust  = Color(0xFFDCC7C4);
const kFloraSage  = Color(0xFFBDBEAD);
const kFloraRose  = Color(0xFFD996A5); // Primary
const kFloraTaupe = Color(0xFF948685);
const kFloraTeal  = Color(0xFF7BA9BA); // Secondary

// ===========================
// Colores de estado (Pipeline)
// ===========================
final Map<PedidoEstado, Color> estadoColor = {
  PedidoEstado.pendiente: Color(0xFFFFC107),
  PedidoEstado.aprobado: Color(0xFF81C784),
  PedidoEstado.rechazado: Color(0xFFE57373),
  PedidoEstado.enPreparacion: Color(0xFFF9A825),
  PedidoEstado.listoEnvio: Color(0xFF64B5F6),
  PedidoEstado.finalizado: Color(0xFFBA68C8),
  PedidoEstado.enCamino: Color(0xFF4DB6AC),
  PedidoEstado.entregado: Color(0xFF81C784),
  PedidoEstado.incidencia: Color(0xFFE57373),
};

// ===========================
// Theme Unificado
// ===========================
ThemeData buildFloraTheme() {
  const primary   = kFloraRose;
  const secondary = kFloraTeal;
  const surface   = kFloraIvory;   // Color cálido (hueso) para tarjetas
  const background= kFloraWhite;   // Fondo general blanco

  final colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.white,
    secondary: secondary,
    onSecondary: Colors.white,
    error: const Color(0xFFB00020),
    onError: Colors.white,
    surface: surface,
    onSurface: kFloraTaupe,
    background: background,
    onBackground: kFloraTaupe,
    outline: kFloraSage,
  );

  final display = GoogleFonts.playfairDisplay(
    color: kFloraTaupe,
    fontWeight: FontWeight.w600,
    height: 1.15,
  );

  final text = GoogleFonts.nunitoSans(
    color: kFloraTaupe,
    fontWeight: FontWeight.w500,
    height: 1.20,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,

    // 👇 Fondo general blanco
    scaffoldBackgroundColor: background,

    // ===========================
    // Tipografías
    // ===========================
    textTheme: TextTheme(
      displayLarge:  display.copyWith(fontSize: 44),
      displayMedium: display.copyWith(fontSize: 34),
      titleLarge:    display.copyWith(fontSize: 22, fontWeight: FontWeight.w700),
      titleMedium:   display.copyWith(fontSize: 18),
      bodyLarge:     text.copyWith(fontSize: 16),
      bodyMedium:    text.copyWith(fontSize: 14),
      labelLarge:    text.copyWith(fontSize: 14, fontWeight: FontWeight.w700),
      labelMedium:   text.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: kFloraTaupe.withOpacity(0.9),
      ),
    ),

    // ===========================
    // AppBar
    // ===========================
    appBarTheme: AppBarTheme(
      backgroundColor: kFloraWhite, // AppBar blanco
      foregroundColor: kFloraTaupe,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: display.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: kFloraTaupe,
      ),
      toolbarHeight: 64,
    ),

    // ===========================
    // Tarjetas (Cards)
    // ===========================
    cardTheme: const CardThemeData(
      color: kFloraIvory, // tono cálido para las tarjetas
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    

    // ===========================
    // Tabs (Pedidos, Producción, etc.)
    // ===========================
    tabBarTheme: TabBarThemeData(
      labelColor: primary,
      unselectedLabelColor: kFloraTaupe.withOpacity(0.7),
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: primary, width: 2.0),
        ),
      ),
      labelStyle: text.copyWith(fontSize: 15, fontWeight: FontWeight.w700),
      unselectedLabelStyle: text.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
    ),

    // ===========================
    // Barra de búsqueda
    // ===========================
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kFloraWhite,
      hintStyle: text.copyWith(color: kFloraTaupe.withOpacity(.7)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kFloraSage.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(30),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: kFloraRose, width: 1.4),
        borderRadius: BorderRadius.circular(30),
      ),
      prefixIconColor: kFloraTaupe.withOpacity(0.7),
    ),
  );
}
