import 'package:fiap_test_flutter/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User Entity', () {
    const tUser = User(
      id: '1',
      name: 'João Silva',
      email: 'joao.silva@fiap.com.br',
    );

    test('deve instanciar a entidade com os campos corretos', () {
      expect(tUser.id, '1');
      expect(tUser.name, 'João Silva');
      expect(tUser.email, 'joao.silva@fiap.com.br');
    });

    test('deve suportar comparação por valor (==) e hashCode', () {
      const tUserEqual = User(
        id: '1',
        name: 'João Silva',
        email: 'joao.silva@fiap.com.br',
      );
      const tUserDifferent = User(
        id: '2',
        name: 'Maria Santos',
        email: 'maria.santos@fiap.com.br',
      );

      expect(tUser, equals(tUserEqual));
      expect(tUser.hashCode, equals(tUserEqual.hashCode));
      expect(tUser, isNot(equals(tUserDifferent)));
    });

    test('deve retornar a representação correta em toString()', () {
      expect(
        tUser.toString(),
        'User(id: 1, name: João Silva, email: joao.silva@fiap.com.br)',
      );
    });
  });
}
