import 'package:fiap_test_flutter/data/models/user_model.dart';
import 'package:fiap_test_flutter/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tUserModel = UserModel(
    id: '1',
    name: 'João Silva',
    email: 'joao.silva@fiap.com.br',
  );

  final tUserMap = {
    'id': '1',
    'name': 'João Silva',
    'email': 'joao.silva@fiap.com.br',
  };

  group('UserModel', () {
    test('deve ser uma subclasse da entidade User', () {
      expect(tUserModel, isA<User>());
    });

    group('fromJson', () {
      test('deve retornar um UserModel válido a partir de um JSON Map', () {
        final result = UserModel.fromJson(tUserMap);

        expect(result, equals(tUserModel));
        expect(result.id, '1');
        expect(result.name, 'João Silva');
        expect(result.email, 'joao.silva@fiap.com.br');
      });
    });

    group('toJson', () {
      test('deve retornar um Map<String, dynamic> contendo os dados corretos', () {
        final result = tUserModel.toJson();

        expect(result, equals(tUserMap));
      });
    });
  });
}
