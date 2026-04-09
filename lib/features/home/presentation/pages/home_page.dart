import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../providers/home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Gatilho Fantasma: Assim que a tela nasce pela primeira vez, 
    // ele já manda baixar o Ranking automaticamente.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).fetchLeaderboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    // Estrutura Visual da Página de Ranking
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Ranking Global', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppTheme.backgroundDark,
        elevation: 0,
      ),
      body: homeProvider.isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor)) // Loading
          : homeProvider.errorMessage != null
              ? Center(child: Text(homeProvider.errorMessage!, style: const TextStyle(color: AppTheme.errorRed)))
              : RefreshIndicator( // Permite puxar a tela pra baixo pra recarregar os dados!
                  color: AppTheme.primaryColor,
                  onRefresh: homeProvider.fetchLeaderboard,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: homeProvider.leaderboard.length,
                    itemBuilder: (context, index) {
                      final player = homeProvider.leaderboard[index];
                      
                      // Lógica Simples de Pódio: Damos cores especiais para os 3 primeiros!
                      final isFirst = index == 0;
                      final isSecond = index == 1;
                      final isThird = index == 2;
                      Color positionColor = AppTheme.textWhite;
                      if (isFirst) positionColor = Colors.amber;
                      else if (isSecond) positionColor = Colors.grey[400]!;
                      else if (isThird) positionColor = Colors.brown[300]!;

                      // Peça de Lego do Material Design: O ListTile (Formata o Box automaticamente)
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: CircleAvatar(
                            backgroundColor: positionColor.withOpacity(0.2),
                            child: Text(
                              '${index + 1}º',
                              style: TextStyle(color: positionColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(
                            player['username'],
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
                          ),
                          subtitle: Text('Partidas: ${player['matches_played']} | Vitórias: ${player['matches_won']}'),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'ELO ${player['elo_score'].round()}',
                              style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
