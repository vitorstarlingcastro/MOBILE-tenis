import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/home/providers/home_provider.dart';
import 'features/profile/providers/profile_provider.dart';
import 'features/tournaments/providers/tournaments_provider.dart';

// O Flutter, por ser focado em Celular, normalmente ignora cliques e arrastes de 
// "Mouse" nativo. Isso aqui injeta o comportamento de Mobile no clique do Mouse do seu Windows!
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => TournamentsProvider()),
      ],
      child: const TenisApp(),
    ),
  );
}

class TenisApp extends StatelessWidget {
  const TenisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tênis App',
      debugShowCheckedModeBanner: false,
      scrollBehavior: AppScrollBehavior(), // Aplica mundialmente a permissão do clique do Mouse
      theme: AppTheme.darkTheme, 
      home: const LoginPage(),
    );
  }
}
