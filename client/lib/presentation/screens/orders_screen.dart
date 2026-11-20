// TODO(reto): archivo stubbeado; implementa los cuerpos.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/order.dart';
import '../blocs/orders_bloc.dart';
import '../widgets/order_list_item.dart';
import '../widgets/refresh_indicator.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('TODO(reto): build');
  }

  Widget _buildErrorView(BuildContext context, String message) {
    throw UnimplementedError('TODO(reto): _buildErrorView');
  }

  Widget _buildOrdersList(BuildContext context, List<Order> orders) {
    throw UnimplementedError('TODO(reto): _buildOrdersList');
  }
}