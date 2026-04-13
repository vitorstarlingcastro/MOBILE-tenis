import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../notifications/presentation/notifications_screen.dart';

// TODO (Phase 3): replace with TournamentResponse list from GET /tournaments
const _tournaments = [
  _Tournament(
    name: 'MASTERS 1000\nKINETIC',
    date: '15–22 Out',
    type: 'Online · Kinetics',
    location: 'São Paulo, SP',
    gradientColors: [Color(0xFF0D2B1E), Color(0xFF1A4A32), Color(0xFF0A1A10)],
    accentColor: Color(0xFF2A7A50),
    participants: [
      Color(0xFF4A90E2),
      Color(0xFFE74C3C),
      Color(0xFFF39C12),
      Color(0xFF9B59B6),
    ],
    participantCount: 48,
    isEnrolled: true,
  ),
  _Tournament(
    name: 'OPEN INDOOR SP',
    date: '05–12 Nov',
    type: 'Plástico · SP',
    location: 'Club de Tênis SP',
    gradientColors: [Color(0xFF2A1A04), Color(0xFF4A3010), Color(0xFF1A1000)],
    accentColor: Color(0xFF8A5A10),
    participants: [
      Color(0xFF5DB075),
      Color(0xFF4A90E2),
      Color(0xFFE74C3C),
    ],
    participantCount: 32,
    isEnrolled: false,
  ),
];

class _Tournament {
  final String name;
  final String date;
  final String type;
  final String location;
  final List<Color> gradientColors;
  final Color accentColor;
  final List<Color> participants;
  final int participantCount;
  final bool isEnrolled;

  const _Tournament({
    required this.name,
    required this.date,
    required this.type,
    required this.location,
    required this.gradientColors,
    required this.accentColor,
    required this.participants,
    required this.participantCount,
    required this.isEnrolled,
  });
}

class TournamentsScreen extends StatefulWidget {
  const TournamentsScreen({super.key});

  @override
  State<TournamentsScreen> createState() => _TournamentsScreenState();
}

class _TournamentsScreenState extends State<TournamentsScreen> {
  int _selectedFilter = 0; // 0 = Disponíveis, 1 = Inscrito
  double _radius = 25;     // km — TODO (Phase 3): filter GET /tournaments?radius=

  List<_Tournament> get _visibleTournaments => _selectedFilter == 0
      ? _tournaments
      : _tournaments.where((t) => t.isEnrolled).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text('CIRCUITO ELITE',
                    style: AppTextStyles.label(10, color: AppColors.primary)),
                const SizedBox(height: 4),
                Text('Torneios Oficiais',
                    style: AppTextStyles.headlineBold(26)),
                const SizedBox(height: 8),
                _buildLocationBadge(),
                const SizedBox(height: 16),
                _buildFilterToggle(),
                const SizedBox(height: 16),
                _buildRadiusSlider(),
                const SizedBox(height: 20),
                if (_visibleTournaments.isEmpty)
                  _buildEmptyState()
                else
                  ..._visibleTournaments.map((t) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildTournamentCard(t),
                      )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────

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
          const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.search,
                color: AppColors.textSecondary, size: 22),
          ),
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

  // ─── Location Badge ───────────────────────────────────────────────────────

  Widget _buildLocationBadge() {
    return Row(
      children: [
        const Icon(Icons.location_on,
            color: AppColors.textSecondary, size: 13),
        const SizedBox(width: 4),
        Text('São Paulo, SP',
            // TODO (Phase 3): replace with user's city from profile
            style: AppTextStyles.body(12)),
      ],
    );
  }

  // ─── Filter Toggle ────────────────────────────────────────────────────────

  Widget _buildFilterToggle() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _filterTab('Disponíveis', 0),
          _filterTab('Inscrito', 1),
        ],
      ),
    );
  }

  Widget _filterTab(String label, int index) {
    final isActive = _selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        child: Text(
          label,
          style: isActive
              ? AppTextStyles.bodyBold(12, color: AppColors.onPrimary)
              : AppTextStyles.body(12, color: AppColors.textSecondary),
        ),
      ),
    );
  }

  // ─── Radius Slider ────────────────────────────────────────────────────────

  Widget _buildRadiusSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('RAIO DE DISTÂNCIA', style: AppTextStyles.label(9)),
            const Spacer(),
            Text(
              '${_radius.round()} km',
              style:
                  AppTextStyles.bodyBold(13, color: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 4),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.surfaceHigh,
            thumbColor: AppColors.primary,
            overlayColor: AppColors.primary.withValues(alpha: 0.15),
            trackHeight: 3,
            thumbShape:
                const RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: Slider(
            value: _radius,
            min: 5,
            max: 100,
            divisions: 19,
            onChanged: (v) => setState(() => _radius = v),
          ),
        ),
      ],
    );
  }

  // ─── Empty State ──────────────────────────────────────────────────────────

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.emoji_events_outlined,
                color: AppColors.textSecondary, size: 40),
            const SizedBox(height: 12),
            Text('Nenhum torneio inscrito',
                style: AppTextStyles.body(14)),
          ],
        ),
      ),
    );
  }

  // ─── Tournament Card ──────────────────────────────────────────────────────

  Widget _buildTournamentCard(_Tournament t) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Image area ──
          SizedBox(
            height: 190,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: t.gradientColors,
                    ),
                  ),
                ),
                CustomPaint(painter: _CourtLinePainter(t.accentColor)),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.3, 1.0],
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.85),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius:
                          BorderRadius.circular(AppRadius.full),
                    ),
                    child: Text(
                      'INSCRIÇÕES ABERTAS',
                      style: AppTextStyles.label(8,
                          color: AppColors.onPrimary),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 14,
                  left: 14,
                  right: 14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.name,
                          style: AppTextStyles.headlineBold(20)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              color: AppColors.textSecondary, size: 11),
                          const SizedBox(width: 4),
                          Text(t.date,
                              style: AppTextStyles.body(11)),
                          const SizedBox(width: 10),
                          const Icon(Icons.sports_tennis,
                              color: AppColors.textSecondary, size: 11),
                          const SizedBox(width: 4),
                          Text(t.type,
                              style: AppTextStyles.body(11)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ── Bottom section (≈ 2/3 of image height) ──
          Container(
            constraints: const BoxConstraints(minHeight: 126),
            padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildParticipantRow(t),
                const SizedBox(height: 16),
                _buildInscricaoButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantRow(_Tournament t) {
    const avatarSize = 24.0;
    const overlap = 8.0;
    final visibleAvatars = t.participants.take(4).toList();
    final extra = t.participantCount - visibleAvatars.length;

    return Row(
      children: [
        SizedBox(
          height: avatarSize,
          width: visibleAvatars.length * (avatarSize - overlap) +
              overlap +
              (extra > 0 ? 34 : 0),
          child: Stack(
            children: [
              ...visibleAvatars.asMap().entries.map((e) => Positioned(
                    left: e.key * (avatarSize - overlap),
                    child: Container(
                      width: avatarSize,
                      height: avatarSize,
                      decoration: BoxDecoration(
                        color: e.value,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.surface, width: 1.5),
                      ),
                    ),
                  )),
              if (extra > 0)
                Positioned(
                  left: visibleAvatars.length * (avatarSize - overlap),
                  child: Container(
                    width: avatarSize,
                    height: avatarSize,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceHigh,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.surface, width: 1.5),
                    ),
                    child: Center(
                      child: Text(
                        '+$extra',
                        style: AppTextStyles.label(6,
                            color: AppColors.textSecondary),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text('${t.participantCount} inscritos',
            style: AppTextStyles.body(11)),
      ],
    );
  }

  Widget _buildInscricaoButton() {
    return Center(
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppRadius.full),
          boxShadow: neonGlow(opacity: 0.25),
        ),
        child: TextButton(
          onPressed: () {}, // TODO (Phase 3): POST /tournaments/{id}/register
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'REALIZAR INSCRIÇÃO',
            style: AppTextStyles.label(11, color: AppColors.onPrimary),
          ),
        ),
      ),
    );
  }
}

// ─── Court Line Painter ───────────────────────────────────────────────────────

class _CourtLinePainter extends CustomPainter {
  final Color lineColor;
  _CourtLinePainter(this.lineColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor.withValues(alpha: 0.25)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final midX = size.width / 2;

    canvas.drawLine(Offset(size.width * 0.05, size.height * 0.88),
        Offset(size.width * 0.95, size.height * 0.88), paint);

    canvas.drawLine(Offset(size.width * 0.15, size.height * 0.62),
        Offset(size.width * 0.85, size.height * 0.62), paint);

    paint.color = lineColor.withValues(alpha: 0.4);
    canvas.drawLine(Offset(size.width * 0.05, size.height * 0.42),
        Offset(size.width * 0.95, size.height * 0.42), paint);

    paint.color = lineColor.withValues(alpha: 0.2);
    canvas.drawLine(Offset(size.width * 0.05, size.height * 0.88),
        Offset(midX, size.height * 0.18), paint);
    canvas.drawLine(Offset(size.width * 0.95, size.height * 0.88),
        Offset(midX, size.height * 0.18), paint);

    canvas.drawLine(Offset(midX, size.height * 0.42),
        Offset(midX, size.height * 0.62), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
