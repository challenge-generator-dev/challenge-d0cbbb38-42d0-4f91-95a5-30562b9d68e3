// TODO(reto): archivo stubbeado; implementa los cuerpos.
import 'package:flutter/material.dart';

// Envoltorio reutilizable de RefreshIndicator para el gesto pull-to-refresh.
// Recibe la acción de recarga por parámetro: no conoce el Bloc ni el repositorio.
class CustomRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final String? refreshText;

  const CustomRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    this.refreshText,
  });

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('TODO(reto): build');
  }
}