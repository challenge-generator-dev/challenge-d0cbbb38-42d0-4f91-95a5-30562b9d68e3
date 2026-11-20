// TODO(reto): archivo stubbeado; implementa los cuerpos.
import 'package:flutter/material.dart';
import '../../domain/models/order.dart';

// Elemento visual de un pedido dentro de la lista.
// Solo presenta los datos del modelo de dominio; no conoce el origen de los datos
// ni el estado de carga, que pertenecen a la capa de presentación de la pantalla.
class OrderListItem extends StatelessWidget {
  final Order order;
  final VoidCallback? onTap;

  const OrderListItem({
    super.key,
    required this.order,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('TODO(reto): build');
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}