import 'package:firebase_core/firebase_core.dart';
import 'package:foraging_buddy/state/auth/providers/is_logged_in_provider.dart';
import 'package:foraging_buddy/state/providers/is_loading_provider.dart';
import 'package:foraging_buddy/views/components/loading/loading_screen.dart';
import 'package:foraging_buddy/views/constants/styles.dart';
import 'package:foraging_buddy/views/login/login_view.dart';
import 'package:foraging_buddy/views/main/main_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 600, name: MOBILE),
          const Breakpoint(start: 600, end: double.infinity, name: TABLET),
        ],
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          fontFamily: 'Monserrat',
          colorSchemeSeed: AppColors.brown,
          canvasColor: AppColors.eggshell,
          scaffoldBackgroundColor: AppColors.eggshell,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.eggshell,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.lightBrown,
          ),
          dialogBackgroundColor: AppColors.eggshell),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: AppColors.brown,
        fontFamily: 'Monserrat',
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      title: 'Foraging Buddy',
      home: Consumer(
        builder: (context, ref, child) {
          ref.listen(isLoadingProvider, (_, isLoading) {
            if (isLoading) {
              LoadingScreen.instance().show(context: context);
            } else {
              LoadingScreen.instance().hide();
            }
          });
          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}
