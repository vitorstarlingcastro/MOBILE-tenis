import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';

class HomeProvider extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  bool isLoading = true; // Já nasce rodando
  List<dynamic> leaderboard = [];
  String? errorMessage;

  Future<void> fetchLeaderboard() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Faz o GET na rota recém-criada do Python
      final response = await _apiClient.dio.get('/users/leaderboard');
      if (response.statusCode == 200) {
        leaderboard = response.data; // Lista JSON decodificada automaticamente pelo Dio
      }
    } on DioException catch (e) {
      errorMessage = 'Falha ao sincronizar o Ranking Oficial.';
      debugPrint('Leaderboard error: $e');
    } catch (e) {
      errorMessage = 'Erro desconhecido.';
    }

    isLoading = false;
    notifyListeners();
  }
}
