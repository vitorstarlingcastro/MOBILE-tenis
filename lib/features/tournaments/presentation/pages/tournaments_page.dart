import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/components/custom_tennis_button.dart';
import '../../providers/tournaments_provider.dart';

class TournamentsPage extends StatefulWidget {
  const TournamentsPage({super.key});

  @override
  State<TournamentsPage> createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TournamentsProvider>(context, listen: false).fetchTournaments();
    });
  }

  void _handleSubscription(int tournamentId) async {
    final success = await Provider.of<TournamentsProvider>(context, listen: false)
        .subscribeToTournament(tournamentId);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inscrição confirmada com sucesso! 🏆')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inscrição recusada. Você já está inscrito! ⚠️')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tourneyProvider = Provider.of<TournamentsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Torneios Oficiais'),
        centerTitle: true,
        backgroundColor: AppTheme.backgroundDark,
        elevation: 0,
      ),
      body: tourneyProvider.isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor))
          : tourneyProvider.errorMessage != null
              ? Center(child: Text(tourneyProvider.errorMessage!, style: const TextStyle(color: AppTheme.errorRed)))
              : tourneyProvider.tournaments.isEmpty
                  ? Center(
                      child: Text(
                        "Nenhum torneio criado pelo Administrador ainda.\nAguarde ou aproveite para jogar os Rachões!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : RefreshIndicator(
                      color: AppTheme.primaryColor,
                      onRefresh: tourneyProvider.fetchTournaments,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: tourneyProvider.tournaments.length,
                        itemBuilder: (context, index) {
                          final tourney = tourneyProvider.tournaments[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.stadium, color: AppTheme.primaryColor, size: 28),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          tourney['name'] ?? 'Grand Slam',
                                          style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    tourney['description'] ?? "Um evento especial para todos os jogadores lutarem por pontos de Elo no ranking global.",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 24),
                                  CustomTennisButton(
                                    label: "REALIZAR INSCRIÇÃO",
                                    onPressed: () => _handleSubscription(tourney['id']),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}
