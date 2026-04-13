import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../profile/presentation/profile_detail_screen.dart';
import '../../notifications/presentation/notifications_screen.dart';

// ─── Mock Data (replaced by GET /users/leaderboard in Phase 3) ───────────────

class _Player {
  final int rank;
  final String name;
  final String city;
  final int wins;
  final int elo;
  final Color color;
  final bool isMe;

  const _Player({
    required this.rank,
    required this.name,
    required this.city,
    required this.wins,
    required this.elo,
    required this.color,
    this.isMe = false,
  });
}

const _podium = [
  _Player(rank: 1, name: 'El Samir', city: 'Dubai, UAE', wins: 61, elo: 2380, color: Color(0xFF4A90E2)),
  _Player(rank: 2, name: 'M. Chen', city: 'Shanghai, CN', wins: 55, elo: 2240, color: Color(0xFF5DB075)),
  _Player(rank: 3, name: 'S. Khan', city: 'Mumbai, IN', wins: 48, elo: 2190, color: Color(0xFFE74C3C)),
];

const _rankList = [
  _Player(rank: 4, name: 'Alex Rivera', city: 'São Paulo, SP', wins: 42, elo: 1892, color: Color(0xFF4A90E2)),
  _Player(rank: 5, name: 'Jordan Lee', city: 'Rio de Janeiro, RJ', wins: 38, elo: 1860, color: Color(0xFFF39C12)),
  _Player(rank: 6, name: 'Taylor Bell', city: 'Belo Horizonte, MG', wins: 35, elo: 1825, color: Color(0xFF9B59B6), isMe: true),
];

// ─── Avatar helper ────────────────────────────────────────────────────────────

Widget _playerAvatar(String name, Color color, {double size = 36}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    child: Center(
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : '?',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.38,
        ),
      ),
    ),
  );
}

void _openProfile(BuildContext context, _Player p) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => ProfileDetailScreen(
        playerName: p.name,
        playerCity: p.city,
        playerColor: p.color,
      ),
    ),
  );
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                _buildNotificationBanner(),
                const SizedBox(height: 24),
                _buildPodium(context),
                const SizedBox(height: 20),
                _buildListHeader(),
                const SizedBox(height: 4),
                ..._rankList.map((p) => _buildPlayerRow(context, p)),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─── Header ─────────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      child: Row(
        children: [
          const Icon(Icons.sports_tennis, color: AppColors.primary, size: 18),
          const SizedBox(width: 6),
          Text('KINETIC',
              style: AppTextStyles.headlineBold(18, color: AppColors.primary)),
          const Spacer(),
          _buildBellWithBadge(context),
        ],
      ),
    );
  }

  Widget _buildBellWithBadge(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const NotificacoesScreen()),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.notifications_none,
                color: AppColors.textSecondary, size: 22),
          ),
          Positioned(
            top: 9,
            right: 9,
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Notification Banner ──────────────────────────────────────────────────

  Widget _buildNotificationBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: const Border(
          left: BorderSide(color: AppColors.primary, width: 3),
        ),
      ),
      child: Row(
        children: [
          _playerAvatar('A', const Color(0xFFE74C3C), size: 36),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Confirmação de Partida Pendente',
                    style: AppTextStyles.bodyBold(11)),
                const SizedBox(height: 2),
                Text('André Lima desafiou você. Confirme o placar.',
                    style: AppTextStyles.body(10)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text('CONFIRMAR',
                  style: AppTextStyles.label(9, color: AppColors.onPrimary)),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Top 3 Podium ─────────────────────────────────────────────────────────

  Widget _buildPodium(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildPodiumPlayer(context, _podium[1], isTop: false),
        _buildPodiumPlayer(context, _podium[0], isTop: true),
        _buildPodiumPlayer(context, _podium[2], isTop: false),
      ],
    );
  }

  Widget _buildPodiumPlayer(BuildContext context, _Player p,
      {required bool isTop}) {
    final double avatarSize = isTop ? 68.0 : 52.0;
    return GestureDetector(
      onTap: () => _openProfile(context, p),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isTop) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.surfaceHigh,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: Text('#${p.rank}',
                  style: AppTextStyles.label(8,
                      color: AppColors.textSecondary)),
            ),
            const SizedBox(height: 6),
          ],
          Container(
            padding: EdgeInsets.all(isTop ? 3.0 : 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isTop ? AppColors.primary : AppColors.surfaceHigh,
                width: isTop ? 2.5 : 1.5,
              ),
            ),
            child: _playerAvatar(p.name, p.color, size: avatarSize),
          ),
          if (isTop) ...[
            const SizedBox(height: 5),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: Text('#1',
                  style: AppTextStyles.label(9,
                      color: AppColors.onPrimary)),
            ),
          ],
          const SizedBox(height: 6),
          Text(
            p.name,
            style: AppTextStyles.bodyBold(isTop ? 13 : 11),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '${p.elo} ELO',
            style: AppTextStyles.body(isTop ? 11 : 10,
                color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  // ─── Ranked List ──────────────────────────────────────────────────────────

  Widget _buildListHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const SizedBox(width: 84),
          Expanded(
            child: Text('POSICIONADOS', style: AppTextStyles.label(9)),
          ),
          SizedBox(
            width: 56,
            child: Text('VITÓRIAS',
                style: AppTextStyles.label(9), textAlign: TextAlign.center),
          ),
          SizedBox(
            width: 52,
            child: Text('ELO',
                style: AppTextStyles.label(9), textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerRow(BuildContext context, _Player p) {
    return GestureDetector(
      onTap: () => _openProfile(context, p),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: Text('#${p.rank}',
                  style: AppTextStyles.body(12,
                      color: AppColors.textSecondary)),
            ),
            const SizedBox(width: 8),
            _playerAvatar(p.name, p.color, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name, style: AppTextStyles.bodyBold(13)),
                  Text(p.city,
                      style: AppTextStyles.body(11),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            SizedBox(
              width: 56,
              child: Text('${p.wins}',
                  style: AppTextStyles.body(13,
                      color: AppColors.textPrimary),
                  textAlign: TextAlign.center),
            ),
            SizedBox(
              width: 52,
              child: p.isMe
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius:
                              BorderRadius.circular(AppRadius.full),
                        ),
                        child: Text('${p.elo}',
                            style: AppTextStyles.bodyBold(11,
                                color: AppColors.onPrimary),
                            textAlign: TextAlign.center),
                      ),
                    )
                  : Text('${p.elo}',
                      style: AppTextStyles.body(13,
                          color: AppColors.textPrimary),
                      textAlign: TextAlign.right),
            ),
          ],
        ),
      ),
    );
  }
}
