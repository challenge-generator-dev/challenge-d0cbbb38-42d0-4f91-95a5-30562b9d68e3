import 'package:dio/dio.dart';

import '../../domain/models/order.dart';
import '../exceptions/network_exception.dart';
import '../exceptions/server_exception.dart';

/// Fuente de datos remota de pedidos.
/// Consume el endpoint GET /orders del API Gateway aprovisionado con Terraform.
/// Traduce los errores de transporte de Dio a excepciones propias de la aplicacion,
/// para que las capas superiores no dependan de los tipos de la libreria HTTP.
class OrdersRemoteDataSource {
  final Dio dio;
  final String baseUrl;

  OrdersRemoteDataSource({required this.dio, required this.baseUrl});

  Future<List<Order>> getOrders() async {
    try {
      final response = await dio.get<dynamic>('$baseUrl/orders');
      final statusCode = response.statusCode ?? 0;

      if (statusCode != 200) {
        throw ServerException('El servidor respondio con codigo $statusCode');
      }

      final data = response.data;
      if (data is! List<dynamic>) {
        throw ServerException('Formato de respuesta invalido: se esperaba una lista');
      }

      return data
          .map((item) => Order.fromJson(item as Map<String, dynamic>))
          .toList(growable: false);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Error inesperado al procesar pedidos: $e');
    }
  }

  NetworkException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('Tiempo de espera agotado al conectar con el servidor');
      case DioExceptionType.connectionError:
        return NetworkException('No se pudo establecer conexion con el servidor');
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode ?? 0;
        return NetworkException('Respuesta de red invalida (codigo $code)');
      default:
        return NetworkException('Error de red: ${e.message ?? 'desconocido'}');
    }
  }
}