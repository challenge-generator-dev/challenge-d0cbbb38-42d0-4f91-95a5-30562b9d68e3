import '../models/order.dart';

abstract class OrdersRepository {
  /// Fetches a list of orders from the remote data source.
  ///
  /// Throws [NetworkException] if the network request fails.
  /// Throws [ServerException] if the server returns an error.
  Future<List<Order>> getOrders();

  /// Refreshes the list of orders, typically used for pull-to-refresh functionality.
  ///
  /// Throws the same exceptions as [getOrders].
  Future<List<Order>> refreshOrders();
}