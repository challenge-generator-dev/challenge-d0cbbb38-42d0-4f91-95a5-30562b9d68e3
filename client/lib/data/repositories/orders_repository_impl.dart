import 'package:dio/dio.dart';

import '../../domain/models/order.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_remote_data_source.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource remoteDataSource;

  OrdersRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<Order>> getOrders() async {
    try {
      final orderModels = await remoteDataSource.getOrders();
      return orderModels;
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw NetworkException('Unexpected error while fetching orders: $e');
    }
  }

  @override
  Future<List<Order>> refreshOrders() async {
    return getOrders();
  }

  NetworkException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('Connection timeout. Please check your internet connection.');
      case DioExceptionType.connectionError:
        return NetworkException('No internet connection. Please try again later.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode != null && statusCode >= 500) {
          return ServerException('Server error. Please try again later.');
        } else if (statusCode != null && statusCode >= 400) {
          return ServerException('Invalid request. Please contact support.');
        }
        return ServerException('Server returned an error: $statusCode');
      case DioExceptionType.cancel:
        return NetworkException('Request was cancelled.');
      default:
        return NetworkException('Network error occurred: ${e.message}');
    }
  }
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => message;
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => message;
}