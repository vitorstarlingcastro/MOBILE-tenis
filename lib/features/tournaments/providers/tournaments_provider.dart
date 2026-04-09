import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';

class TournamentsProvider extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  bool isLoading = true;
  List<dynamic> tournaments = [];
  String? errorMessage;

  Future<void> fetchTournaments() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiClient.dio.get('/tournaments/');
      if (response.statusCode == 200) {
        tournaments = response.data;
      }
    } on DioException catch (e) {
      errorMessage = 'Não foi possível buscar os campeonatos ativos.';
      debugPrint('Tournaments fetch error: $e');
    } catch (e) {
      errorMessage = 'Erro desconhecido.';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> subscribeToTournament(int tournamentId) async {
    try {
      final response = await _apiClient.dio.post('/tournaments/$tournamentId/subscribe');
      if (response.statusCode == 201) return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        debugPrint('Você já está inscrito neste torneio.');
      }
      return false;
    }
    return false;
  }
}
