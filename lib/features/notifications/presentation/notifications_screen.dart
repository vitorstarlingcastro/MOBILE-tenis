import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class NotificacoesScreen extends StatelessWidget {
  const NotificacoesScreen({super.key});

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildSection('RECENTE', [
                      _buildPriorityCard(),
                      const SizedBox(height: 6),
                      _buildNotifRow(
                        icon: Icons.person,
                        iconColor: const Color(0xFFE74C3C),
                        title: 'Beatriz Haddad',
                        subtitle: 'confira sua performance recente',
                        time: '2h',
                      ),
                    ]),
                    const SizedBox(height: 20),
                    _buildSection('TORNEIOS', [
                      _buildNotifRow(
                        icon: Icons.emoji_events,
                        iconColor: const Color(0xFF5DB075),
                        title: 'Torneio Aberto SP',
                        subtitle:
                            'As inscrições para o Torneio Aberto São Paulo já estão abertas. Garanta sua vaga.',
                        time: 'ONTEM',
                      ),
                    ]),
                    const SizedBox(height: 20),
                    _buildSection('DM', [
                      _buildNotifRow(
                        icon: Icons.person,
                        iconColor: const Color(0xFF4A90E2),
                        title: 'Rafael Varane',
                        subtitle:
                            'Bora treinar! Quando você quer marcar nossa próxima partida?',
                        time: '11h',
                        label: 'enviou uma mensagem',
                      ),
                    ]),
                    const SizedBox(height: 20),
                    _buildSection('SISTEMA', [
                      _buildNotifRow(
                        icon: Icons.public,
                        iconColor: AppColors.primary,
                        title: 'Nova Ranking Global',
                        subtitle:
                            'Sua posição subiu para o top 100 no app Kinetic.',
                        time: '3d',
                      ),
                    ]),
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

  // ─── Header ───────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: AppColors.textSecondary, size: 18),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Text('NOTIFICAÇÕES',
              style: AppTextStyles.headlineBold(18)),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.settings_outlined,
                color: AppColors.textSecondary, size: 22),
          ),
        ],
      ),
    );
  }

  // ─── Section wrapper ──────────────────────────────────────────────────────

  Widget _buildSection(String label, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label(9)),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  // ─── Priority card (pending match confirmation) ───────────────────────────

  Widget _buildPriorityCard() {
    // TODO (Phase 3): wire CONFIRMAR to PUT /matches/{id}/confirm
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: const Border(
          left: BorderSide(color: AppColors.primary, width: 3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.sports_tennis,
                color: AppColors.onPrimary, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('Confirmação de Partida',
                          style: AppTextStyles.bodyBold(13)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceHigh,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                      child: Text('HOJE',
                          style: AppTextStyles.label(8,
                              color: AppColors.primary)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Você tem um desafio pendente na sua conta! Clique e confirme o resultado.',
                  style: AppTextStyles.body(11),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text('CONFIRMAR',
                          style: AppTextStyles.label(9,
                              color: AppColors.onPrimary)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Standard notification row ────────────────────────────────────────────

  Widget _buildNotifRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
    String? label,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: iconColor.withValues(alpha: 0.4), width: 1.5),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: AppTextStyles.bodyBold(13)),
                          if (label != null) ...[
                            const SizedBox(height: 1),
                            Text(label,
                                style: AppTextStyles.label(9,
                                    color: AppColors.primary)),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(time, style: AppTextStyles.body(10)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.body(11),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
