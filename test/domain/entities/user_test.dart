import 'package:fiap_test_flutter/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User Entity', () {
    const tUser = User(
      id: '1',
      name: 'João das Neves',
      email: 'joao.neves@fiap.com.br',
    );

    test('deve instanciar a entidade com os campos corretos', () {
      expect(tUser.id, '1');
      expect(tUser.name, 'João das Neves');
      expect(tUser.email, 'joao.neves@fiap.com.br');
    });

    test('Deve suportar comparação por valor (==) e hashCode', () {
      const tUserEqual = User(id: '1', name: 'João das Neves', email: 'joao.neves@fiap.com.br');
      const tUserDiffent = User(id: '2', name: 'Naomi Monteiro', email: 'naomi.monteiro@fiap.com.br');

      expect(tUser, equals(tUserEqual));
      expect(tUser.hashCode, equals(tUserEqual.hashCode));
      expect(tUser, isNot(equals(tUserDiffent)));
    });

    test('deve retornar a representação correta em toString()', () {
      expect(
        tUser.toString(),
        'User(id: 1, name: João das Neves, email: joao.neves@fiap.com.br)',
      );
    });
  });
}
