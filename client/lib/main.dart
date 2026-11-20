// TODO(reto): archivo stubbeado; implementa los cuerpos.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'data/repositories/orders_repository_impl.dart';
import 'data/datasources/orders_remote_data_source.dart';
import 'presentation/blocs/orders_bloc.dart';
import 'presentation/screens/orders_screen.dart';

// Punto de entrada de la aplicación.
// Aquí solo se ensamblan las dependencias y se arranca la app: la lógica de
// presentación de la lista de pedidos vive en OrdersScreen (su dueño).
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('TODO(reto): build');
  }
}