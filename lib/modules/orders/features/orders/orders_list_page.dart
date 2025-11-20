import 'package:flutter/material.dart';
import 'package:flora_app/modules/theme.dart';
import 'package:flora_app/modules/orders/widgets/brand_header.dart';
import 'package:flora_app/modules/orders/features/orders/order_detail_page.dart';
import 'package:flora_app/modules/orders/services/orders_service.dart';
import 'package:flora_app/modules/orders/models/pedido.dart';

class OrdersListPage extends StatefulWidget {
  const OrdersListPage({super.key});

  @override
  State<OrdersListPage> createState() => _OrdersListPageState();
}

class _OrdersListPageState extends State<OrdersListPage> {
  List<Pedido> _orders = [];
  bool _loading = true;
  String _query = "";

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      final pedidos = await OrdersService.getOrders();
      setState(() {
        _orders = pedidos;
        _loading = false;
      });
    } catch (err) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error cargando pedidos: $err")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _orders.where((o) {
      final q = _query.toLowerCase();
      return o.pedido.toLowerCase().contains(q) ||
          o.primerNombre.toLowerCase().contains(q) ||
          o.producto.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/flora_logo.png',
                height: 28,
                width: 28,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            const Text('Pedidos'),
          ],
        ),
      ),
      body: Column(
        children: [
          const FloraBrandHeader(subtitle: 'Tienda de flores'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: const InputDecoration(
                hintText: 'Buscar por pedido, cliente o producto...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : filtered.isEmpty
                    ? const Center(child: Text("No hay pedidos disponibles"))
                    : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, i) {
                          final o = filtered[i];
                          return _OrderCard(
                            pedido: o.pedido,
                            fecha: o.fechaEntrega.isNotEmpty
                                ? o.fechaEntrega
                                : o.fecha,
                            cliente:
                                "${o.primerNombre} ${o.primerApellido}".trim(),
                            producto: o.producto,
                            estado: o.estado,
                            total: o.total,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OrderDetailPage(
                                  order: o.toJson().map(
                                        (k, v) =>
                                            MapEntry(k, v?.toString() ?? ''),
                                      ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

// ================== CARD DE PEDIDO ==================
class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.pedido,
    required this.fecha,
    required this.cliente,
    required this.producto,
    required this.estado,
    required this.total,
    required this.onTap,
  });

  final String pedido, fecha, cliente, producto, estado, total;
  final VoidCallback onTap;

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "aprobado":
        return const Color(0xFF6FB07F);
      case "no aprobado":
      case "rechazado":
        return const Color(0xFFCB6E6E);
      case "pendiente":
        return kFloraRose;
      default:
        return Colors.grey;
    }
  }

  String _fmt(String v) {
    final n = int.tryParse(v) ?? 0;
    final s = n.toString();
    final b = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) b.write('.');
      b.write(s[i]);
    }
    return b.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: kFloraBlush,
                child: Text(
                  pedido,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: kFloraTaupe,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cliente,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(producto),
                    const SizedBox(height: 4),
                    Text("Fecha: $fecha"),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: _statusColor(estado).withOpacity(.12),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: _statusColor(estado),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      estado,
                      style: TextStyle(
                        color: _statusColor(estado),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${_fmt(total)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
