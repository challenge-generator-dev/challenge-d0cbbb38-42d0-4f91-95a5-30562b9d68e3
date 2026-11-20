import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String id;
  final String description;
  final String status;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.description,
    required this.status,
    required this.createdAt,
  })  : assert(id.isNotEmpty, 'Order ID cannot be empty'),
        assert(description.isNotEmpty, 'Order description cannot be empty'),
        assert(status.isNotEmpty, 'Order status cannot be empty');

  @override
  List<Object?> get props => [id, description, status, createdAt];

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}