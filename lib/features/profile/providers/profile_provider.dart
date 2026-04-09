import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';

class ProfileProvider extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  bool isLoading = true; // Nasce carregando
  Map<String, dynamic>? userProfile;
  String? errorMessage;

  Future<void> fetchMyProfile() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Bate no Python pegando os próprios dados usando o Token "escondido" no Dio
      final response = await _apiClient.dio.get('/users/me');
      if (response.statusCode == 200) {
        userProfile = response.data;
      }
    } on DioException catch (e) {
      errorMessage = 'Não foi possível carregar suas estatísticas.';
      debugPrint('Profile error: $e');
    } catch (e) {
      errorMessage = 'Erro desconhecido.';
    }

    isLoading = false;
    notifyListeners();
  }
}
