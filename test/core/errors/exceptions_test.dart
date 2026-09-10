import 'package:fiap_test_flutter/core/errors/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ServerException', () {
    const tMessage = 'Erro no servidor';
    const tStatusCode = 500;
    const tException = ServerException(
      message: tMessage,
      statusCode: tStatusCode,
    );

    test('deve instanciar com os valores corretos de message e statusCode', () {
      expect(tException.message, tMessage);
      expect(tException.statusCode, tStatusCode);
    });

    test('deve suportar igualdade por valor (==) e hashCode', () {
      const exception2 = ServerException(
        message: tMessage,
        statusCode: tStatusCode,
      );
      const differentException = ServerException(
        message: 'Outro erro',
        statusCode: 404,
      );

      expect(tException, equals(exception2));
      expect(tException.hashCode, equals(exception2.hashCode));
      expect(tException, isNot(equals(differentException)));
    });

    test('deve retornar a formatação correta no toString()', () {
      expect(
        tException.toString(),
        'ServerException(message: $tMessage, statusCode: $tStatusCode)',
      );
    });
  });
}
