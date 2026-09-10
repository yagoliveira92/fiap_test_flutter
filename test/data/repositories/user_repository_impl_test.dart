import 'package:fiap_test_flutter/core/errors/exceptions.dart';
import 'package:fiap_test_flutter/data/datasources/user_remote_data_source.dart';
import 'package:fiap_test_flutter/data/models/user_model.dart';
import 'package:fiap_test_flutter/data/repositories/user_repository_impl.dart';
import 'package:fiap_test_flutter/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

void main() {
  late MockUserRemoteDataSource mockRemoteDataSource;
  late UserRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    repository = UserRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tUserId = '1';
  const tUserModel = UserModel(
    id: '1',
    name: 'João Silva',
    email: 'joao.silva@fiap.com.br',
  );

  group('fetchUser', () {
    test(
      'deve retornar o Usuário quando a chamada ao remoteDataSource for bem-sucedida',
      () async {
        when(() => mockRemoteDataSource.fetchUser(tUserId))
            .thenAnswer((_) async => tUserModel);

        final result = await repository.fetchUser(tUserId);

        expect(result, equals(tUserModel));
        expect(result, isA<User>());
        verify(() => mockRemoteDataSource.fetchUser(tUserId)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'deve repassar a ServerException quando a chamada ao remoteDataSource falhar',
      () async {
        const tException = ServerException(
          statusCode: 500,
          message: 'Falha ao buscar usuário no servidor',
        );

        when(() => mockRemoteDataSource.fetchUser(tUserId))
            .thenThrow(tException);

        final call = repository.fetchUser;

        expect(() => call(tUserId), throwsA(equals(tException)));
        verify(() => mockRemoteDataSource.fetchUser(tUserId)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });
}
