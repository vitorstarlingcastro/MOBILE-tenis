import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class RegisterResultScreen extends StatefulWidget {
  // TODO (Phase 3): pass real UserResponse object from GET /users/{id}/profile
  final String opponentName;
  final Color opponentColor;

  const RegisterResultScreen({
    super.key,
    this.opponentName = 'Rafael Varane',
    this.opponentColor = const Color(0xFF4A90E2),
  });

  @override
  State<RegisterResultScreen> createState() => _RegisterResultScreenState();
}

class _RegisterResultScreenState extends State<RegisterResultScreen> {
  bool _iAmWinner = true;

  // Each set: [myScore, opponentScore]
  // TODO (Phase 3): use these values to build MatchReport payload
  final List<List<int>> _sets = [
    [6, 4],
    [7, 6],
  ];

  void _addSet() {
    setState(() => _sets.add([0, 0]));
  }

  void _removeSet(int setIndex) {
    setState(() => _sets.removeAt(setIndex));
  }

  void _changeScore(int setIndex, bool isMe, int delta) {
    setState(() {
      final idx = isMe ? 0 : 1;
      _sets[setIndex][idx] =
          (_sets[setIndex][idx] + delta).clamp(0, 99);
    });
  }

  void _submit() {
    // TODO (Phase 3): build MatchReport and call POST /matches/report
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDescription(),
              const SizedBox(height: 24),
              _buildOpponentSelector(),
              const SizedBox(height: 20),
              _buildWinnerToggle(),
              const SizedBox(height: 20),
              _buildSetsSection(),
              const SizedBox(height: 28),
              _buildSubmitButton(context),
              const SizedBox(height: 14),
              _buildCancelLink(context),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Description ──────────────────────────────────────────────────────────

  Widget _buildDescription() {
    return Text(
      'Atualize seu ranking kinetic com um novo resultado',
      style: AppTextStyles.body(14, color: AppColors.textSecondary),
    );
  }

  // ─── Opponent Selector ────────────────────────────────────────────────────

  Widget _buildOpponentSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SELECIONAR OPONENTE', style: AppTextStyles.label(10)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surfaceLow,
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: widget.opponentColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    widget.opponentName[0].toUpperCase(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.opponentName,
                  style: AppTextStyles.bodyBold(14),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary, size: 22),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Winner Toggle ────────────────────────────────────────────────────────

  Widget _buildWinnerToggle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('VENCEDOR DA PARTIDA', style: AppTextStyles.label(10)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _winnerPill(label: 'Você', isActive: _iAmWinner,
                onTap: () => setState(() => _iAmWinner = true))),
            const SizedBox(width: 10),
            Expanded(child: _winnerPill(label: 'Oponente', isActive: !_iAmWinner,
                onTap: () => setState(() => _iAmWinner = false))),
          ],
        ),
      ],
    );
  }

  Widget _winnerPill({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.surfaceHigh,
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isActive) ...[
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.onPrimary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: AppTextStyles.bodyBold(14,
                  color: isActive
                      ? AppColors.onPrimary
                      : AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Sets Section ─────────────────────────────────────────────────────────

  Widget _buildSetsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('PLACAR POR SET', style: AppTextStyles.label(10)),
            const Spacer(),
            GestureDetector(
              onTap: _addSet,
              child: Row(
                children: [
                  const Icon(Icons.add_circle_outline,
                      color: AppColors.primary, size: 16),
                  const SizedBox(width: 4),
                  Text('ADICIONAR SET',
                      style: AppTextStyles.label(9,
                          color: AppColors.primary)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ..._sets.asMap().entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildSetCard(e.key),
              ),
            ),
      ],
    );
  }

  Widget _buildSetCard(int setIndex) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('SET ${setIndex + 1}',
                  style: AppTextStyles.label(10,
                      color: AppColors.textSecondary)),
              if (setIndex > 0) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _removeSet(setIndex),
                  child: const Icon(
                    Icons.delete_outline,
                    color: AppColors.textSecondary,
                    size: 15,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          _buildScoreRow(
              label: 'YOU',
              score: _sets[setIndex][0],
              onDecrement: () => _changeScore(setIndex, true, -1),
              onIncrement: () => _changeScore(setIndex, true, 1)),
          const SizedBox(height: 8),
          _buildScoreRow(
              label: 'OPON',
              score: _sets[setIndex][1],
              onDecrement: () => _changeScore(setIndex, false, -1),
              onIncrement: () => _changeScore(setIndex, false, 1)),
        ],
      ),
    );
  }

  Widget _buildScoreRow({
    required String label,
    required int score,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(label,
              style: AppTextStyles.label(10,
                  color: AppColors.textSecondary)),
        ),
        const Spacer(),
        _scoreButton(icon: Icons.remove, onTap: onDecrement),
        const SizedBox(width: 20),
        SizedBox(
          width: 32,
          child: Text(
            '$score',
            style: AppTextStyles.headlineBold(24, color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 20),
        _scoreButton(icon: Icons.add, onTap: onIncrement),
      ],
    );
  }

  Widget _scoreButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.surfaceHigh,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 16),
      ),
    );
  }

  // ─── Submit ───────────────────────────────────────────────────────────────

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.full),
        boxShadow: neonGlow(),
      ),
      child: ElevatedButton.icon(
        onPressed: _submit,
        icon: const Icon(Icons.arrow_forward,
            color: AppColors.onPrimary, size: 20),
        label: Text('Enviar Resultado',
            style: AppTextStyles.bodyBold(15, color: AppColors.onPrimary)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildCancelLink(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Center(
        child: Text(
          'Cancelar e Voltar',
          style: AppTextStyles.body(13),
        ),
      ),
    );
  }
}
