import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../features/leaderboard/presentation/leaderboard_screen.dart';
import '../../features/tournaments/presentation/tournaments_screen.dart';
import '../../features/chat/presentation/chat_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../theme/app_theme.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [
    LeaderboardScreen(),
    TournamentsScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(height: 0.5, color: AppColors.surfaceHigh),
        BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          selectedLabelStyle: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 9,
            letterSpacing: 1.0,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontWeight: FontWeight.normal,
            fontSize: 9,
            letterSpacing: 1.0,
          ),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_outlined, size: 22),
              activeIcon: Icon(Icons.leaderboard, size: 22),
              label: 'RANKING',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined, size: 22),
              activeIcon: Icon(Icons.emoji_events, size: 22),
              label: 'TORNEIOS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.forum_outlined, size: 22),
              activeIcon: Icon(Icons.forum, size: 22),
              label: 'COMUNIDADE',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 22),
              activeIcon: Icon(Icons.person, size: 22),
              label: 'PERFIL',
            ),
          ],
        ),
      ],
    );
  }
}
