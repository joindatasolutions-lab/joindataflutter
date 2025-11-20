import 'package:flutter/material.dart';
import 'package:flora_app/modules/theme.dart';
import 'package:flora_app/modules/orders/services/orders_service.dart';
import 'package:flora_app/modules/orders/models/pedido.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key, required this.order});
  final Map<String, String> order;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late String _estado;
  String? _cuenta;

  final List<String> _cuentasMock = [
    "Nequi 3xx xxx xxx",
    "Bancolombia Ahorros ****1234",
    "Daviplata ***5678"
  ];

  @override
  void initState() {
    super.initState();
    _estado = widget.order["Estado"] ?? "Pendiente";
  }

  Future<void> _guardarCambios() async {
    if (_estado == "Aprobado" && _cuenta == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona la cuenta bancaria")),
      );
      return;
    }

    // Convertimos el pedido recibido (Map) a objeto Pedido
    final pedido = Pedido.fromJson(widget.order);
    final actualizado = Pedido(
      pedido: pedido.pedido,
      fecha: pedido.fecha,
      identificacion: pedido.identificacion,
      primerNombre: pedido.primerNombre,
      segundoNombre: pedido.segundoNombre,
      primerApellido: pedido.primerApellido,
      segundoApellido: pedido.segundoApellido,
      telefono: pedido.telefono,
      formaPago: pedido.formaPago,
      destinatario: pedido.destinatario,
      barrio: pedido.barrio,
      direccion: pedido.direccion,
      telefonoDestino: pedido.telefonoDestino,
      fechaEntrega: pedido.fechaEntrega,
      horaEntrega: pedido.horaEntrega,
      cantidad: pedido.cantidad,
      producto: pedido.producto,
      precio: pedido.precio,
      iva: pedido.iva,
      domicilio: pedido.domicilio,
      total: pedido.total,
      mensaje: pedido.mensaje,
      estado: _estado, // 👈 nuevo estado seleccionado
      cuenta: _cuenta ?? pedido.cuenta,
    );

    // Llamada al servicio (App Script)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Guardando cambios...")),
    );

    final result = await OrdersService.saveOrder(actualizado);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final o = widget.order;
    return Scaffold(
      appBar: AppBar(title: Text("Pedido ${o["Pedido"] ?? ""}")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Tile(label: "Cliente", value: o["PrimerNombre"] ?? ""),
            _Tile(label: "Producto", value: o["Producto"] ?? ""),
            _Tile(label: "Fecha", value: o["Fecha"] ?? ""),
            _Tile(label: "Fecha de Entrega", value: o["Fecha de Entrega"] ?? ""),
            _Tile(label: "Forma de Pago", value: o["FormaPago"] ?? "Transferencia"),
            _Tile(label: "Total", value: "\$${o["Total"] ?? "0"}"),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Text("Cambiar estado", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text("Pendiente"),
                  selected: _estado == "Pendiente",
                  onSelected: (_) => setState(() => _estado = "Pendiente"),
                ),
                ChoiceChip(
                  label: const Text("Aprobado"),
                  selected: _estado == "Aprobado",
                  onSelected: (_) => setState(() => _estado = "Aprobado"),
                ),
                ChoiceChip(
                  label: const Text("No Aprobado"),
                  selected: _estado == "No Aprobado",
                  onSelected: (_) => setState(() => _estado = "No Aprobado"),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_estado == "Aprobado") ...[
              Text("Cuenta bancaria", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _cuenta,
                items: _cuentasMock
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _cuenta = v),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: kFloraSage),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: kFloraSage),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Regresar"),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _guardarCambios,
                  child: const Text("Guardar cambios"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.label, required this.value});
  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: const TextStyle(
                color: kFloraTaupe,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
