// TODO(reto): archivo stubbeado; implementa los cuerpos.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/models/order.dart';
import '../../domain/repositories/orders_repository.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

class OrdersLoadRequested extends OrdersEvent {
  const OrdersLoadRequested();
}

class OrdersRefreshRequested extends OrdersEvent {
  const OrdersRefreshRequested();
}

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

class OrdersLoading extends OrdersState {
  const OrdersLoading();
}

class OrdersLoadSuccess extends OrdersState {
  final List<Order> orders;

  const OrdersLoadSuccess({required this.orders});

  @override
  List<Object?> get props => [orders];
}

class OrdersLoadFailure extends OrdersState {
  final String message;

  const OrdersLoadFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository ordersRepository;

  OrdersBloc({required this.ordersRepository}) : super(const OrdersInitial()) {
    throw UnimplementedError('TODO(reto): super');
  }

  Future<void> _onOrdersLoadRequested(
    OrdersLoadRequested event,
    Emitter<OrdersState> emit,
  ) async {
    throw UnimplementedError('TODO(reto): _onOrdersLoadRequested');
  }

  Future<void> _onOrdersRefreshRequested(
    OrdersRefreshRequested event,
    Emitter<OrdersState> emit,
  ) async {
    throw UnimplementedError('TODO(reto): _onOrdersRefreshRequested');
  }
}