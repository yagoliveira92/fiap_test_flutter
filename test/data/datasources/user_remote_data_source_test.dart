import 'dart:convert';
import 'package:fiap_test_flutter/core/errors/exceptions.dart';
import 'package:fiap_test_flutter/data/datasources/user_remote_data_source.dart';
import 'package:fiap_test_flutter/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late UserRemoteDataSourceImpl dataSource;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = UserRemoteDataSourceImpl(client: mockHttpClient);
  });

  const tUserId = '1';
  final tUri = Uri.parse('https://api.exemplo.com/users/$tUserId');
  const tUserModel = UserModel(
    id: '1',
    name: 'João Silva',
    email: 'joao.silva@fiap.com.br',
  );

  final tJsonResponse = json.encode({
    'id': '1',
    'name': 'João Silva',
    'email': 'joao.silva@fiap.com.br',
  });

  group('fetchUser', () {
    test(
      'deve realizar uma requisição GET na URL correta com headers application/json',
      () async {
        when(
          () => mockHttpClient.get(
            tUri,
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(tJsonResponse, 200),
        );

        await dataSource.fetchUser(tUserId);

        verify(
          () => mockHttpClient.get(
            tUri,
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(1);
      },
    );

    test(
      'deve retornar um UserModel quando o status code da resposta for 200',
      () async {
        when(
          () => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(tJsonResponse, 200),
        );

        final result = await dataSource.fetchUser(tUserId);

        expect(result, equals(tUserModel));
      },
    );

    test(
      'deve lançar ServerException quando o status code da resposta for diferente de 200 (ex: 404)',
      () async {
        when(
          () => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        final call = dataSource.fetchUser;

        expect(
          () => call(tUserId),
          throwsA(
            isA<ServerException>()
                .having((e) => e.statusCode, 'statusCode', 404)
                .having(
                  (e) => e.message,
                  'message',
                  'Falha ao buscar usuário no servidor',
                ),
          ),
        );
      },
    );

    test(
      'deve lançar ServerException com status 500 em erro interno do servidor',
      () async {
        when(
          () => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Internal Server Error', 500),
        );

        final call = dataSource.fetchUser;

        expect(
          () => call(tUserId),
          throwsA(
            isA<ServerException>()
                .having((e) => e.statusCode, 'statusCode', 500),
          ),
        );
      },
    );
  });
}
