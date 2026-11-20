/// Excepcion lanzada cuando no es posible completar la comunicacion de red
/// con el backend: timeouts, falta de conectividad o respuestas de transporte invalidas.
/// Permite a la capa de presentacion mostrar un mensaje de reintento al usuario.
class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}