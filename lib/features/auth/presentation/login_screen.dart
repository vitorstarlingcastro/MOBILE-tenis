import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/navigation/main_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    // TODO (Phase 3): validate credentials against POST /login
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainLayout()),
    );
  }

  void _onSocialLogin(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$provider — Em breve!')),
    );
  }

  void _onForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recuperação de senha — Em breve!')),
    );
  }

  void _onRegister() {
    // TODO (Phase 3): navigate to register screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: _buildCard(),
        ),
      ),
    );
  }

  // ─── Card Container ──────────────────────────────────────────────────────────

  Widget _buildCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeroImage(),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLogo(),
                const SizedBox(height: 16),
                _buildTitle(),
                const SizedBox(height: 6),
                _buildSubtitle(),
                const SizedBox(height: 24),
                Text('USUÁRIO OU E-MAIL', style: AppTextStyles.label(10)),
                const SizedBox(height: 8),
                _buildUsernameField(),
                const SizedBox(height: 16),
                _buildPasswordLabelRow(),
                const SizedBox(height: 8),
                _buildPasswordField(),
                const SizedBox(height: 24),
                _buildLoginButton(),
                const SizedBox(height: 20),
                _buildDivider(),
                const SizedBox(height: 20),
                _buildSocialButtons(),
                const SizedBox(height: 20),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Hero Image ───────────────────────────────────────────────────────────────

  Widget _buildHeroImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppRadius.lg),
        topRight: Radius.circular(AppRadius.lg),
      ),
      child: Image.asset(
        'assets/images/tennis_hero.png',
        height: 160,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 160,
          color: AppColors.surfaceHigh,
          child: const Center(
            child: Icon(Icons.sports_tennis, color: AppColors.primary, size: 64),
          ),
        ),
      ),
    );
  }

  // ─── Logo ─────────────────────────────────────────────────────────────────────

  Widget _buildLogo() {
    return Row(
      children: [
        const Icon(Icons.sports_tennis, color: AppColors.primary, size: 20),
        const SizedBox(width: 6),
        Text(
          'KINETIC',
          style: AppTextStyles.headlineBold(20, color: AppColors.primary),
        ),
      ],
    );
  }

  // ─── Headline ─────────────────────────────────────────────────────────────────

  Widget _buildTitle() {
    return Text(
      'Bem-vindo de volta, Atleta',
      style: AppTextStyles.headlineBoldItalic(22),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Insira suas credenciais para acessar a quadra.',
      style: AppTextStyles.body(13),
    );
  }

  // ─── Username Field ───────────────────────────────────────────────────────────

  Widget _buildUsernameField() {
    return TextField(
      controller: _usernameController,
      style: AppTextStyles.body(14, color: AppColors.textPrimary),
      decoration: _pillInputDecoration(hint: 'name@kinetic.app'),
    );
  }

  // ─── Password Field ───────────────────────────────────────────────────────────

  Widget _buildPasswordLabelRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('SENHA', style: AppTextStyles.label(10)),
        GestureDetector(
          onTap: _onForgotPassword,
          child: Text('ESQUECEU A SENHA?', style: AppTextStyles.label(10)),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: !_passwordVisible,
      style: AppTextStyles.body(14, color: AppColors.textPrimary),
      decoration: _pillInputDecoration(hint: '••••••••').copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility_off : Icons.visibility,
            color: AppColors.textSecondary,
            size: 20,
          ),
          onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
        ),
      ),
    );
  }

  InputDecoration _pillInputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.body(14),
      filled: true,
      fillColor: AppColors.surfaceLow,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.full),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.full),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.full),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }

  // ─── Login Button ─────────────────────────────────────────────────────────────

  Widget _buildLoginButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.full),
        boxShadow: neonGlow(),
      ),
      child: ElevatedButton.icon(
        onPressed: _onLoginPressed,
        icon: const Icon(Icons.bolt, color: AppColors.onPrimary, size: 20),
        label: Text(
          'ENTRAR',
          style: AppTextStyles.bodyBold(15, color: AppColors.onPrimary),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  // ─── Divider ──────────────────────────────────────────────────────────────────

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.surfaceHigh, thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('OU CONTINUE COM', style: AppTextStyles.label(10)),
        ),
        const Expanded(
          child: Divider(color: AppColors.surfaceHigh, thickness: 1),
        ),
      ],
    );
  }

  // ─── Social Buttons ───────────────────────────────────────────────────────────

  Widget _buildSocialButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildSocialButton('Google', Icons.g_mobiledata_outlined),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSocialButton('Apple', Icons.apple),
        ),
      ],
    );
  }

  Widget _buildSocialButton(String label, IconData icon) {
    return OutlinedButton.icon(
      onPressed: () => _onSocialLogin(label),
      icon: Icon(icon, color: AppColors.textPrimary, size: 20),
      label: Text(label, style: AppTextStyles.bodyBold(13)),
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.surfaceHigh,
        foregroundColor: AppColors.textPrimary,
        side: BorderSide.none,
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
      ),
    );
  }

  // ─── Footer ───────────────────────────────────────────────────────────────────

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Novo no Kinetic? ', style: AppTextStyles.body(13)),
        GestureDetector(
          onTap: _onRegister,
          child: Text(
            'Entre para o Clube',
            style: AppTextStyles.bodyBold(13, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
