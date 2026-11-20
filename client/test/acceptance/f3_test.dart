import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../lib/domain/models/order.dart';
import '../../lib/domain/repositories/orders_repository.dart';
import '../../lib/presentation/blocs/orders_bloc.dart';

class MockOrdersRepository extends Mock implements OrdersRepository {}

void main() {
  late MockOrdersRepository mockOrdersRepository;

  setUp(() {
    mockOrdersRepository = MockOrdersRepository();
  });

  group('OrdersBloc - Caso de aceptación: Bloc carga pedidos al inicializarse', () {
    final testOrders = [
      Order(
        id: '1',
        description: 'Pedido de prueba 1',
        status: 'pending',
        createdAt: DateTime(2024, 1, 1),
      ),
      Order(
        id: '2',
        description: 'Pedido de prueba 2',
        status: 'completed',
        createdAt: DateTime(2024, 1, 2),
      ),
    ];

    blocTest<OrdersBloc, OrdersState>(
      'dado El OrdersBloc se inicializa, cuando Se emite el evento OrdersLoadRequested, entonces El estado se actualiza con la lista de pedidos',
      build: () {
        when(() => mockOrdersRepository.getOrders())
            .thenAnswer((_) async => testOrders);
        return OrdersBloc(ordersRepository: mockOrdersRepository);
      },
      act: (bloc) => bloc.add(const OrdersLoadRequested()),
      expect: () => [
        const OrdersLoading(),
        OrdersLoadSuccess(orders: testOrders),
      ],
      verify: (_) {
        verify(() => mockOrdersRepository.getOrders()).called(1);
      },
    );
  });

  group('OrdersBloc - Caso de aceptación: Bloc maneja errores al cargar pedidos', () {
    blocTest<OrdersBloc, OrdersState>(
      'dado El OrdersBloc se inicializa con un repositorio que falla, cuando Se emite el evento OrdersLoadRequested, entonces El estado se actualiza con un error',
      build: () {
        when(() => mockOrdersRepository.getOrders())
            .thenThrow(Exception('Error de red'));
        return OrdersBloc(ordersRepository: mockOrdersRepository);
      },
      act: (bloc) => bloc.add(const OrdersLoadRequested()),
      expect: () => [
        const OrdersLoading(),
        isA<OrdersLoadFailure>(),
      ],
      verify: (_) {
        verify(() => mockOrdersRepository.getOrders()).called(1);
      },
    );
  });

  group('OrdersBloc - Caso de aceptación: Pull-to-refresh recarga la lista de pedidos', () {
    final refreshedOrders = [
      Order(
        id: '3',
        description: 'Pedido actualizado',
        status: 'shipped',
        createdAt: DateTime(2024, 1, 3),
      ),
    ];

    blocTest<OrdersBloc, OrdersState>(
      'dado La pantalla OrdersScreen está visible, cuando El usuario realiza un pull-to-refresh (OrdersRefreshRequested), entonces El OrdersBloc emite un evento para recargar los pedidos',
      build: () {
        when(() => mockOrdersRepository.refreshOrders())
            .thenAnswer((_) async => refreshedOrders);
        return OrdersBloc(ordersRepository: mockOrdersRepository);
      },
      act: (bloc) => bloc.add(const OrdersRefreshRequested()),
      expect: () => [
        OrdersLoadSuccess(orders: refreshedOrders),
      ],
      verify: (_) {
        verify(() => mockOrdersRepository.refreshOrders()).called(1);
      },
    );
  });

  group('OrdersBloc - Caso de aceptación: Pull-to-refresh maneja errores', () {
    blocTest<OrdersBloc, OrdersState>(
      'dado La pantalla OrdersScreen está visible y el OrdersBloc falla al recargar, cuando El usuario realiza un pull-to-refresh, entonces La pantalla muestra un mensaje de error',
      build: () {
        when(() => mockOrdersRepository.refreshOrders())
            .thenThrow(Exception('Error al actualizar'));
        return OrdersBloc(ordersRepository: mockOrdersRepository);
      },
      act: (bloc) => bloc.add(const OrdersRefreshRequested()),
      expect: () => [
        isA<OrdersLoadFailure>(),
      ],
      verify: (_) {
        verify(() => mockOrdersRepository.refreshOrders()).called(1);
      },
    );
  });
}