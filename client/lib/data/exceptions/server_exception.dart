/// Excepcion lanzada cuando el backend responde, pero la respuesta no es valida:
/// codigo de estado inesperado o un cuerpo que no corresponde al contrato de Order.
/// Indica un problema del lado del servidor o del contrato, no de conectividad.
class ServerException implements Exception {
  final String message;

  const ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}