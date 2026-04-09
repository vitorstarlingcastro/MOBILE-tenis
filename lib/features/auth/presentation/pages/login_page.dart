import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/ui/components/custom_tennis_button.dart';
import '../../../../core/ui/components/custom_tennis_input.dart';
import '../../../../core/theme/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../../../../core/ui/main_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  Future<void> _handleLogin() async {
    // Buscamos a gestora de sessão que bate na API
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final username = _userController.text.trim();
    final password = _passController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    // A mágica: envia pra Internet, aguarda servidor docker verificar, e reage ao retorno
    final success = await authProvider.login(username, password);

    if (!mounted) return; 

    if (success) {
      // Vai para a tela principal (HomPage) e impede o usuário de voltar para a de Login pelo botão voltar
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainLayout()),
      );
    } else {
      // Se erro (senha errada etc):
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(authProvider.errorMessage ?? 'Ocorreu um erro no login.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ficamos observando a gestora pra saber se colocamos a rodinha de carregar na tela
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch, 
              children: [
                const Icon(
                  Icons.sports_tennis,
                  size: 100,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(height: 32),
                
                Text(
                  "Tênis App",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  "Faça login para subir no Ranking ELO",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 48),

                CustomTennisInput(
                  label: "Usuário",
                  controller: _userController,
                ),
                const SizedBox(height: 16),
                CustomTennisInput(
                  label: "Senha",
                  controller: _passController,
                  isPassword: true,
                ),
                
                const SizedBox(height: 32),
                
                // MÁGICA REATIVA: Troca dinamicamente o botão físico clássico
                // por uma rodinha de loading enquanto a API trabalha respondendo
                authProvider.isLoading 
                    ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor))
                    : CustomTennisButton(
                        label: "ENTRAR NO APP",
                        onPressed: _handleLogin,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
