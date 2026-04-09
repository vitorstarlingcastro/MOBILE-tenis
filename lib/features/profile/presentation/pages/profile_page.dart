import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../providers/profile_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Assim que o layout renderiza, dispara o pedido à API silenciosamente
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).fetchMyProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu Perfil'),
        centerTitle: true,
        backgroundColor: AppTheme.backgroundDark,
        elevation: 0, // Fica plano com a tela inteira
      ),
      body: profile.isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor))
          : profile.errorMessage != null
              ? Center(child: Text(profile.errorMessage!, style: const TextStyle(color: AppTheme.errorRed)))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // O "Avatar" arredondado
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: AppTheme.primaryColor,
                        child: Icon(Icons.person, size: 60, color: AppTheme.backgroundDark),
                      ),
                      const SizedBox(height: 24),
                      
                      // Nome e Email
                      Text(
                        profile.userProfile?['username'] ?? 'Jogador Misterioso',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profile.userProfile?['email'] ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 48),
                      
                      // Dashboard Rápido de Cards de Estatísticas
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatBox(context, 'ELO', '${profile.userProfile?['elo_score']?.round() ?? 1200}', Colors.amber),
                          _buildStatBox(context, 'Vitórias', '${profile.userProfile?['matches_won'] ?? 0}', AppTheme.primaryColor),
                          _buildStatBox(context, 'Partidas', '${profile.userProfile?['matches_played'] ?? 0}', AppTheme.textGrey),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }

  // Peça de Lego isolada apenas para criar cartões de Status pequenos e rápidos
  Widget _buildStatBox(BuildContext context, String label, String value, Color corDestaque) {
    return Card(
      elevation: 0,
      color: AppTheme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: corDestaque)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
          ],
        ),
      ),
    );
  }
}
