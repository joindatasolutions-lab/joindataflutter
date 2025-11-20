class Pedido {
  final String pedido;
  final String fecha;
  final String identificacion;
  final String primerNombre;
  final String segundoNombre;
  final String primerApellido;
  final String segundoApellido;
  final String telefono;
  final String formaPago;
  final String destinatario;
  final String barrio;
  final String direccion;
  final String telefonoDestino;
  final String fechaEntrega;
  final String horaEntrega;
  final String cantidad;
  final String producto;
  final String precio;
  final String iva;
  final String domicilio;
  final String total;
  final String mensaje;
  final String estado;
  final String cuenta;

  Pedido({
    required this.pedido,
    required this.fecha,
    required this.identificacion,
    required this.primerNombre,
    required this.segundoNombre,
    required this.primerApellido,
    required this.segundoApellido,
    required this.telefono,
    required this.formaPago,
    required this.destinatario,
    required this.barrio,
    required this.direccion,
    required this.telefonoDestino,
    required this.fechaEntrega,
    required this.horaEntrega,
    required this.cantidad,
    required this.producto,
    required this.precio,
    required this.iva,
    required this.domicilio,
    required this.total,
    required this.mensaje,
    required this.estado,
    required this.cuenta,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    String toStr(dynamic v) => v?.toString() ?? '';

    return Pedido(
      pedido: toStr(json['Pedido']),
      fecha: toStr(json['Fecha']),
      identificacion: toStr(json['Identificacion']),
      primerNombre: toStr(json['PrimerNombre']),
      segundoNombre: toStr(json['SegundoNombre']),
      primerApellido: toStr(json['PrimerApellido']),
      segundoApellido: toStr(json['SegundoApellido']),
      telefono: toStr(json['Telefono']),
      formaPago: toStr(json['FormaPago']),
      destinatario: toStr(json['Destinatario']),
      barrio: toStr(json['Barrio']),
      direccion: toStr(json['Direccion']),
      telefonoDestino: toStr(json['telefonoDestino']),
      fechaEntrega: toStr(json['Fecha de Entrega']),
      horaEntrega: toStr(json['Hora de Entrega']),
      cantidad: toStr(json['Cantidad']),
      producto: toStr(json['Producto']),
      precio: toStr(json['Precio']),
      iva: toStr(json['Iva']),
      domicilio: toStr(json['Domicilio']),
      total: toStr(json['Total']),
      mensaje: toStr(json['Mensaje']),
      estado: toStr(json['Estado']),
      cuenta: toStr(json['Cuenta']),
    );
  }

  Map<String, dynamic> toJson() => {
        'Pedido': pedido,
        'Fecha': fecha,
        'Identificacion': identificacion,
        'PrimerNombre': primerNombre,
        'SegundoNombre': segundoNombre,
        'PrimerApellido': primerApellido,
        'SegundoApellido': segundoApellido,
        'Telefono': telefono,
        'FormaPago': formaPago,
        'Destinatario': destinatario,
        'Barrio': barrio,
        'Direccion': direccion,
        'telefonoDestino': telefonoDestino,
        'Fecha de Entrega': fechaEntrega,
        'Hora de Entrega': horaEntrega,
        'Cantidad': cantidad,
        'Producto': producto,
        'Precio': precio,
        'Iva': iva,
        'Domicilio': domicilio,
        'Total': total,
        'Mensaje': mensaje,
        'Estado': estado,
        'Cuenta': cuenta,
      };
}
