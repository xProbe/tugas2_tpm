import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'data_kelompok_screen.dart';
import 'kalkulator_screen.dart';
import 'ganjil_genap_prima_screen.dart';
import 'total_angka_screen.dart';
import 'stopwatch_screen.dart';
import 'piramid_screen.dart';
import 'weton_screen.dart';
import 'umur_lengkap_screen.dart';
import 'hijriah_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        title: const Text(
          'Menu Utama',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
            letterSpacing: 0.3,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D47A1), Color(0xFF1E88E5)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.logout_rounded, color: Colors.white),
              tooltip: 'Logout',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header banner
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF1E88E5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.grid_view_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pilih Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '9 fitur tersedia untuk Anda',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Grid menu
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildMenuCard(
                  context,
                  'Data Kelompok',
                  Icons.group_rounded,
                  const Color(0xFF1565C0),
                  const Color(0xFFBBDEFB),
                  const DataKelompokScreen(),
                ),
                _buildMenuCard(
                  context,
                  'Kalkulator',
                  Icons.calculate_rounded,
                  const Color(0xFF0277BD),
                  const Color(0xFFB3E5FC),
                  const KalkulatorScreen(),
                ),
                _buildMenuCard(
                  context,
                  'Ganjil Genap / Prima',
                  Icons.numbers_rounded,
                  const Color(0xFF1976D2),
                  const Color(0xFFBBDEFB),
                  const GanjilGenapPrimaScreen(),
                ),
                _buildMenuCard(
                  context,
                  'Total Angka',
                  Icons.add_circle_rounded,
                  const Color(0xFF0288D1),
                  const Color(0xFFB3E5FC),
                  const TotalAngkaScreen(),
                ),
                _buildMenuCard(
                  context,
                  'Stopwatch',
                  Icons.timer_rounded,
                  const Color(0xFF01579B),
                  const Color(0xFFBBDEFB),
                  const StopwatchScreen(),
                ),
                _buildMenuCard(
                  context,
                  'Piramid',
                  Icons.change_history_rounded,
                  const Color(0xFF1E88E5),
                  const Color(0xFFBBDEFB),
                  const PiramidScreen(),
                ),
                _buildMenuCard(
                  context,
                  'Hari & Weton',
                  Icons.today_rounded,
                  const Color(0xFF01579B),
                  const Color(0xFFBBDEFB),
                  const HariWetonScreen(),
                ),
                _buildMenuCard(
                  context,
                  'Umur Lengkap',
                  Icons.cake_rounded,
                  const Color(0xFF01579B),
                  const Color(0xFFBBDEFB),
                  const UmurLengkapScreen(),
                ),
                _buildMenuCard(
                  context,
                  'Konversi Hijriah',
                  Icons.nights_stay_rounded,
                  const Color(0xFF01579B),
                  const Color(0xFFBBDEFB),
                  const HijriahScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Color primaryColor,
    Color accentColor,
    Widget screen,
  ) {
    return Card(
      elevation: 3,
      shadowColor: primaryColor.withOpacity(0.25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        ),
        splashColor: primaryColor.withOpacity(0.15),
        highlightColor: primaryColor.withOpacity(0.08),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 36, color: primaryColor),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: 28,
                height: 3,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
