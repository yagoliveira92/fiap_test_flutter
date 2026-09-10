import '../entities/user.dart';

/// Contrato do repositório de Usuários no Domínio (Dependency Inversion Principle).
abstract class UserRepository {
  Future<User> fetchUser(String id);
}
