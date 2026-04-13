import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../notifications/presentation/notifications_screen.dart';
import '../../matches/presentation/register_result_screen.dart';

class ProfileDetailScreen extends StatelessWidget {
  // TODO (Phase 3): replace mock fields with UserResponse model from GET /users/{id}/profile
  final String playerName;
  final String playerCity;
  final Color playerColor;

  const ProfileDetailScreen({
    super.key,
    this.playerName = 'Alex Rivera',
    this.playerCity = 'São Paulo, SP',
    this.playerColor = const Color(0xFF4A90E2),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    _buildAvatarSection(),
                    const SizedBox(height: 16),
                    _buildEloCard(),
                    const SizedBox(height: 10),
                    _buildStatsGrid(),
                    const SizedBox(height: 10),
                    _buildEloChart(),
                    const SizedBox(height: 16),
                    _buildAchievements(),
                    const SizedBox(height: 16),
                    _buildRecentMatches(),
                    const SizedBox(height: 20),
                    _buildActionButtons(context),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Header with back arrow ───────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.textSecondary,
              size: 18,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Icon(Icons.sports_tennis, color: AppColors.primary, size: 18),
          const SizedBox(width: 6),
          Text('KINETIC',
              style: AppTextStyles.headlineBold(18, color: AppColors.primary)),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const NotificacoesScreen()),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.notifications_none,
                  color: AppColors.textSecondary, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Avatar ───────────────────────────────────────────────────────────────

  Widget _buildAvatarSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 2.5),
          ),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(color: playerColor, shape: BoxShape.circle),
            child: Center(
              child: Text(
                playerName.isNotEmpty ? playerName[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(playerName, style: AppTextStyles.headlineBold(22)),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on,
                color: AppColors.textSecondary, size: 14),
            const SizedBox(width: 4),
            Text(playerCity.toUpperCase(), style: AppTextStyles.label(10)),
          ],
        ),
      ],
    );
  }

  // ─── ELO Card ─────────────────────────────────────────────────────────────

  Widget _buildEloCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CURRENT ELO', style: AppTextStyles.label(9)),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '1.892', // TODO (Phase 3): replace with player.elo_score
                style: AppTextStyles.headlineBold(34, color: AppColors.primary),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.trending_up,
                  color: AppColors.primary, size: 20),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceHigh,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text('ELITE PLAYER',
                    // TODO (Phase 3): replace with player.badge
                    style: AppTextStyles.label(9, color: AppColors.primary)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Stats Grid ───────────────────────────────────────────────────────────

  Widget _buildStatsGrid() {
    // TODO (Phase 3): replace with player.matches_won / matches_played, elo_score
    return Row(
      children: [
        Expanded(child: _statCard('77%', 'TAXA DE VITÓRIA')),
        const SizedBox(width: 8),
        Expanded(child: _statCard('#4', 'RANKING')),
        const SizedBox(width: 8),
        Expanded(child: _statCard('42', 'WINS')),
        const SizedBox(width: 8),
        Expanded(child: _statCard('13', 'LOSSES')),
      ],
    );
  }

  Widget _statCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.headlineBold(18)),
          const SizedBox(height: 4),
          Text(label,
              style: AppTextStyles.label(8), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // ─── ELO Chart ────────────────────────────────────────────────────────────

  Widget _buildEloChart() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('PERFORMANCE ELO', style: AppTextStyles.label(9)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.surfaceHigh,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text('+62.30', // TODO (Phase 3): compute from match history
                    style: AppTextStyles.bodyBold(10, color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: CustomPaint(
              size: const Size(double.infinity, 60),
              painter: _EloChartPainter(),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Achievements ─────────────────────────────────────────────────────────

  Widget _buildAchievements() {
    // TODO (Phase 3): replace with player.badges from API
    const badges = [
      (Icons.emoji_events, 'LENDÁRIO', true),
      (Icons.local_fire_department, '10 WINS', true),
      (Icons.bolt, 'ACE KING', false),
      (Icons.lock, '???', false),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('ACHIEVEMENTS', style: AppTextStyles.label(10)),
            const Spacer(),
            Text('2 / 11 UNLOCKED', style: AppTextStyles.body(10)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: badges
              .map((b) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _buildBadge(b.$1, b.$2, b.$3),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildBadge(IconData icon, String label, bool unlocked) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: unlocked ? AppColors.surfaceHigh : AppColors.surfaceLow,
            shape: BoxShape.circle,
            border: unlocked
                ? Border.all(color: AppColors.primary, width: 1.5)
                : null,
          ),
          child: Icon(
            icon,
            color: unlocked
                ? AppColors.primary
                : AppColors.textSecondary.withValues(alpha: 0.4),
            size: 22,
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: AppTextStyles.label(7,
                color: unlocked
                    ? AppColors.textSecondary
                    : AppColors.textSecondary.withValues(alpha: 0.4))),
      ],
    );
  }

  // ─── Recent Matches ───────────────────────────────────────────────────────

  Widget _buildRecentMatches() {
    // TODO (Phase 3): replace with player.recent_matches from GET /users/{id}/profile
    const matches = [
      ('Jordan Lee', '6-3, 6-1', true),
      ('Taylor Bell', '4-6, 3-6', false),
      ('M. Chen', '6-4, 7-5', true),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('RECENTES', style: AppTextStyles.label(10)),
        const SizedBox(height: 10),
        ...matches.map((m) => _buildMatchRow(m.$1, m.$2, m.$3)),
      ],
    );
  }

  Widget _buildMatchRow(String opponent, String score, bool won) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFF39C12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                opponent[0].toUpperCase(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(opponent, style: AppTextStyles.bodyBold(12)),
                Text(score, style: AppTextStyles.body(11)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: won ? AppColors.primary : AppColors.surfaceHigh,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            child: Text(
              won ? 'WIN' : 'LOSS',
              style: AppTextStyles.label(9,
                  color:
                      won ? AppColors.onPrimary : AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Action Buttons ───────────────────────────────────────────────────────

  Widget _buildActionButtons(BuildContext context) {
    // TODO (Phase 3): check friendship_status from GET /users/{id}/profile
    //                 wire ADICIONAR to POST /friends/request/{id}
    //                 wire DESAFIAR to navigate to RegisterResultScreen
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.person_add_outlined,
                size: 16, color: AppColors.primary),
            label: Text('ADICIONAR',
                style: AppTextStyles.bodyBold(13, color: AppColors.primary)),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(0, 46),
              side: const BorderSide(color: AppColors.primary, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.full),
              boxShadow: neonGlow(),
            ),
            child: ElevatedButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RegisterResultScreen(
                    opponentName: playerName,
                    opponentColor: playerColor,
                  ),
                ),
              ),
              icon: const Icon(Icons.sports_tennis,
                  size: 16, color: AppColors.onPrimary),
              label: Text('DESAFIAR',
                  style:
                      AppTextStyles.bodyBold(13, color: AppColors.onPrimary)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                minimumSize: const Size(0, 46),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── ELO Chart Painter ────────────────────────────────────────────────────────
// TODO (Phase 3): replace with fl_chart using real match history data

class _EloChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primary.withValues(alpha: 0.3),
          AppColors.primary.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final points = [
      Offset(0, size.height * 0.70),
      Offset(size.width * 0.12, size.height * 0.80),
      Offset(size.width * 0.25, size.height * 0.60),
      Offset(size.width * 0.40, size.height * 0.70),
      Offset(size.width * 0.55, size.height * 0.45),
      Offset(size.width * 0.70, size.height * 0.35),
      Offset(size.width * 0.85, size.height * 0.25),
      Offset(size.width, size.height * 0.15),
    ];

    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 0; i < points.length - 1; i++) {
      final cpX = (points[i].dx + points[i + 1].dx) / 2;
      path.cubicTo(cpX, points[i].dy, cpX, points[i + 1].dy,
          points[i + 1].dx, points[i + 1].dy);
    }

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
