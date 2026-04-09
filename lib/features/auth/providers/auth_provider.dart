import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network/api_client.dart';

class AuthProvider extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  bool isLoading = false;
  String? errorMessage;

  Future<bool> login(String username, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners(); // Avisa a tela para mostrar um "carregando" (loader cirular girando)

    try {
      // O FastAPI usa OAuth2PasswordRequestForm, portanto aguarda dados como Formulário (FormData)
      final response = await _apiClient.dio.post(
        '/login',
        data: FormData.fromMap({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final token = response.data['access_token'];
        
        // Salvamos eternamente na memória protegida do celular:
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_auth_token', token);
        
        isLoading = false;
        notifyListeners();
        return true; // Autenticado com sucesso!
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 404) {
        errorMessage = 'Usuário ou senha inválidos.';
      } else {
        errorMessage = 'Acesso em modo desenvolvimento (Emulador sem acesso a porta ou Backend delisgado).';
      }
    } catch (e) {
      errorMessage = 'Erro grave de conexão: $e';
    }

    isLoading = false;
    notifyListeners();
    return false; // Falha na autenticação
  }
}
