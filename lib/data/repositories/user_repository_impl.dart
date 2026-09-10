import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

/// Implementação do repositório desacoplada através do [UserRemoteDataSource].
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> fetchUser(String id) async {
    return await remoteDataSource.fetchUser(id);
  }
}
