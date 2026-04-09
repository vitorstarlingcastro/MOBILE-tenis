import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/tournaments/presentation/pages/tournaments_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';

// O Container invisível que "prende" todas as outras telas juntas
// e coloca o Menu Inferior (BottomBar) para nós podermos navegar livremente.
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  // Começamos o App na Aba '0' (Ranking/Leaderboard)
  int _currentIndex = 0;

  // Nossa "Playlist" de Telas
  final List<Widget> _pages = const [
    HomePage(),
    ProfilePage(),
    TournamentsPage(),
    ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Renderiza apenas a tela do index atual
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.cardColor,
        selectedItemColor: AppTheme.primaryColor, // Verde fluor pra onde você clicou
        unselectedItemColor: AppTheme.textGrey, // Cinza discreto pro resto
        currentIndex: _currentIndex,
        onTap: (index) {
          // Quando clica, atualiza o index e o corpo é redesenhado com a nova página.
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Ranking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Meu Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stadium),
            label: 'Torneios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Bate Papo',
          ),
        ],
      ),
    );
  }
}
