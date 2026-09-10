import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/errors/exceptions.dart';
import '../models/user_model.dart';

/// Contrato para o Data Source remoto de Usuários.
abstract class UserRemoteDataSource {
  Future<UserModel> fetchUser(String id);
}

/// Implementação do Data Source remoto com injeção do [http.Client].
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> fetchUser(String id) async {
    final uri = Uri.parse('https://api.exemplo.com/users/$id');
    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return UserModel.fromJson(data);
    } else {
      throw ServerException(
        statusCode: response.statusCode,
        message: 'Falha ao buscar usuário no servidor',
      );
    }
  }
}
