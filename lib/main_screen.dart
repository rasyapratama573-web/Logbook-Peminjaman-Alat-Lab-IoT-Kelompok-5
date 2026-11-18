
import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

import 'screens/dashboard_screen.dart';
import 'screens/peminjaman_screen.dart';
import 'screens/riwayat_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  late ReownAppKitModal appKitModal;

  bool initialized = false;
  bool initError = false;

  static const Color bg = Color(0xFF080D18);
  static const Color surface = Color(0xFF111A2B);
  static const Color accent = Color(0xFF3987FF);

  @override
  void initState() {
    super.initState();
    initializeWallet();
  }

  Future<void> initializeWallet() async {
    try {
      appKitModal = ReownAppKitModal(
        context: context,
        projectId: 'e883b04321299397103cdc238c68a64c',
        metadata: const PairingMetadata(
          name: 'Logbook IoT',
          description: 'Aplikasi Peminjaman Alat IoT',
          url: 'https://reown.com/',
          icons: ['https://reown.com/logo.png'],
          redirect: Redirect(
            native: 'logbook5iot://',
          ),
        ),
      );

      await appKitModal.init();

      if (!mounted) return;

      setState(() {
        initialized = true;
      });
    } catch (e) {
      debugPrint('Wallet error: $e');

      if (!mounted) return;

      setState(() {
        initError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.dark,
          surface: surface,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bg,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: Color(0xFF24334B),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF172338),
          labelStyle: const TextStyle(
            color: Colors.white70,
          ),
          hintStyle: const TextStyle(
            color: Colors.white38,
          ),
          prefixIconColor: accent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF293B56),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF293B56),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: accent,
              width: 1.5,
            ),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: surface,
          indicatorColor: accent.withValues(alpha: 0.2),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: accent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(
                Icons.hub_rounded,
                color: accent,
                size: 27,
              ),
              SizedBox(width: 10),
              Text(
                'LOGBOOK IoT',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          actions: [
            if (initialized)
              AppKitModalAccountButton(
                appKitModal: appKitModal,
                context: context,
              )
            else
              Padding(
                padding: const EdgeInsets.all(12),
                child: initError
                    ? const Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                      )
                    : const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
              ),
            const SizedBox(width: 8),
          ],
        ),
        body: Column(
          children: [
            if (initialized)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16, 8, 16, 12,
                ),
                child: AppKitModalConnectButton(
                  appKit: appKitModal,
                  context: context,
                ),
              ),
            Expanded(
              child: !initialized
                  ? Center(
                      child: initError
                          ? const Text(
                              'Gagal menginisialisasi wallet',
                            )
                          : const CircularProgressIndicator(),
                    )
                  : IndexedStack(
                      index: selectedIndex,
                      children: [
                        const DashboardScreen(),
                        PeminjamanScreen(
                          appKitModal: appKitModal,
                        ),
                        RiwayatScreen(
                          appKitModal: appKitModal,
                        ),
                      ],
                    ),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.grid_view_outlined),
              selectedIcon: Icon(Icons.grid_view_rounded),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_box_outlined),
              selectedIcon: Icon(Icons.add_box),
              label: 'Peminjaman',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined),
              selectedIcon: Icon(Icons.receipt_long),
              label: 'Riwayat',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (initialized) {
      appKitModal.dispose();
    }
    super.dispose();
  }
}
