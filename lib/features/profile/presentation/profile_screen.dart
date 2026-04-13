import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../notifications/presentation/notifications_screen.dart';

// Mock badge data
const _badges = [
  _Badge(icon: Icons.emoji_events, label: 'LENDÁRIO', unlocked: true),
  _Badge(icon: Icons.local_fire_department, label: '10 WINS', unlocked: true),
  _Badge(icon: Icons.bolt, label: 'ACE KING', unlocked: true),
  _Badge(icon: Icons.lock, label: '???', unlocked: false),
];

class _Badge {
  final IconData icon;
  final String label;
  final bool unlocked;
  const _Badge({required this.icon, required this.label, required this.unlocked});
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildAvatarSection(),
                const SizedBox(height: 16),
                _buildEloCard(),
                const SizedBox(height: 12),
                _buildStatsGrid(),
                const SizedBox(height: 12),
                _buildEloChart(),
                const SizedBox(height: 16),
                _buildAchievements(),
                const SizedBox(height: 16),
                _buildRecentMatches(),
                const SizedBox(height: 16),
                _buildLogoutButton(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }

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
          const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.emoji_events_outlined,
                color: AppColors.textSecondary, size: 22),
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
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: Color(0xFF4A90E2),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'L',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text('Lucas Silva', style: AppTextStyles.headlineBold(22)),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on,
                color: AppColors.textSecondary, size: 14),
            const SizedBox(width: 4),
            Text('SÃO PAULO, BR',
                style: AppTextStyles.label(10)),
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
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('2.910',
                  style: AppTextStyles.headlineBold(32,
                      color: AppColors.primary)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceHigh,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text('ELITE PLAYER',
                    style:
                        AppTextStyles.label(9, color: AppColors.primary)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Stats Grid ───────────────────────────────────────────────────────────

  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(child: _statCard('78%', 'TAXA DE VITÓRIA')),
        const SizedBox(width: 8),
        Expanded(child: _statCard('#12', 'RANKING')),
        const SizedBox(width: 8),
        Expanded(child: _statCard('42', 'WINS')),
        const SizedBox(width: 8),
        Expanded(child: _statCard('12', 'LOSSES')),
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
              style: AppTextStyles.label(8),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // ─── ELO Chart (static placeholder) ──────────────────────────────────────

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
                child: Text('+89.40',
                    style: AppTextStyles.bodyBold(10,
                        color: AppColors.primary)),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('ACHIEVEMENTS', style: AppTextStyles.label(10)),
            const Spacer(),
            Text('3 / 11 UNLOCKED',
                style: AppTextStyles.body(10)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _badges
              .map((b) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _buildBadge(b),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildBadge(_Badge b) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: b.unlocked ? AppColors.surfaceHigh : AppColors.surfaceLow,
            shape: BoxShape.circle,
            border: b.unlocked
                ? Border.all(color: AppColors.primary, width: 1.5)
                : null,
          ),
          child: Icon(
            b.icon,
            color: b.unlocked
                ? AppColors.primary
                : AppColors.textSecondary.withValues(alpha: 0.4),
            size: 22,
          ),
        ),
        const SizedBox(height: 4),
        Text(b.label,
            style: AppTextStyles.label(7,
                color: b.unlocked
                    ? AppColors.textSecondary
                    : AppColors.textSecondary.withValues(alpha: 0.4))),
      ],
    );
  }

  // ─── Recent Matches ───────────────────────────────────────────────────────

  Widget _buildRecentMatches() {
    const matches = [
      ('Carlos Mendonça', '6-4, 6-2', true),
      ('Ana Borelli', '6-6, 3-6', false),
      ('Felipe Torres', '7-5, 6-3', true),
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
              color: Color(0xFF4A90E2),
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
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: won ? AppColors.primary : AppColors.surfaceHigh,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            child: Text(
              won ? 'WIN' : 'LOSS',
              style: AppTextStyles.label(9,
                  color: won
                      ? AppColors.onPrimary
                      : AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Logout ───────────────────────────────────────────────────────────────

  Widget _buildLogoutButton() {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.logout, size: 16, color: AppColors.textSecondary),
      label: Text('SAIR',
          style: AppTextStyles.bodyBold(13, color: AppColors.textSecondary)),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 44),
        side: const BorderSide(color: AppColors.surfaceHigh),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
      ),
    );
  }
}

// ─── Chart Painter ────────────────────────────────────────────────────────────

class _EloChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
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

    // Approximate ELO curve from Stitch screenshot
    final points = [
      Offset(0, size.height * 0.75),
      Offset(size.width * 0.15, size.height * 0.65),
      Offset(size.width * 0.30, size.height * 0.80),
      Offset(size.width * 0.45, size.height * 0.55),
      Offset(size.width * 0.60, size.height * 0.40),
      Offset(size.width * 0.75, size.height * 0.30),
      Offset(size.width * 0.90, size.height * 0.20),
      Offset(size.width, size.height * 0.10),
    ];

    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 0; i < points.length - 1; i++) {
      final cp = Offset(
          (points[i].dx + points[i + 1].dx) / 2, points[i].dy);
      final cp2 = Offset(
          (points[i].dx + points[i + 1].dx) / 2, points[i + 1].dy);
      path.cubicTo(cp.dx, cp.dy, cp2.dx, cp2.dy,
          points[i + 1].dx, points[i + 1].dy);
    }

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
