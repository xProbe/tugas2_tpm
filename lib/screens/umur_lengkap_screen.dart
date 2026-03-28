import 'package:flutter/material.dart';

class UmurLengkapScreen extends StatefulWidget {
  const UmurLengkapScreen({super.key});

  @override
  State<UmurLengkapScreen> createState() => _UmurLengkapScreenState();
}

class _UmurLengkapScreenState extends State<UmurLengkapScreen> {
  DateTime _birthDate = DateTime(2000, 1, 1, 0, 0);
  int _birthHour = 0;
  int _birthMinute = 0;

  int _tahun = 0;
  int _bulan = 0;
  int _hari = 0;
  int _jam = 0;
  int _menit = 0;
  bool _hasResult = false;

  @override
  void initState() {
    super.initState();
    _hitungUmur();
  }

  String _formatTanggal(DateTime dt) {
    const List<String> bulan = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${dt.day} ${bulan[dt.month]} ${dt.year}';
  }

  void _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1976D2),
            brightness: Brightness.light,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null && mounted) {
      setState(() {
        _birthDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _birthHour,
          _birthMinute,
        );
        _hitungUmur();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _birthHour, minute: _birthMinute),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1976D2),
            brightness: Brightness.light,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null && mounted) {
      setState(() {
        _birthHour = picked.hour;
        _birthMinute = picked.minute;
        _birthDate = DateTime(
          _birthDate.year,
          _birthDate.month,
          _birthDate.day,
          _birthHour,
          _birthMinute,
        );
        _hitungUmur();
      });
    }
  }

  void _hitungUmur() {
    final now = DateTime.now();
    if (_birthDate.isAfter(now)) return;

    // Hitung tahun, bulan, hari secara akurat
    int years = now.year - _birthDate.year;
    int months = now.month - _birthDate.month;
    int days = now.day - _birthDate.day;
    int hours = now.hour - _birthDate.hour;
    int minutes = now.minute - _birthDate.minute;

    if (minutes < 0) {
      minutes += 60;
      hours--;
    }
    if (hours < 0) {
      hours += 24;
      days--;
    }
    if (days < 0) {
      final prevMonth = DateTime(now.year, now.month, 0);
      days += prevMonth.day;
      months--;
    }
    if (months < 0) {
      months += 12;
      years--;
    }

    setState(() {
      _tahun = years;
      _bulan = months;
      _hari = days;
      _jam = hours;
      _menit = minutes;
      _hasResult = true;
    });
  }

  String _buildSummary() {
    final parts = <String>[];
    if (_tahun > 0) parts.add('$_tahun tahun');
    if (_bulan > 0) parts.add('$_bulan bulan');
    if (_hari > 0) parts.add('$_hari hari');
    if (_jam > 0) parts.add('$_jam jam');
    if (_menit > 0) parts.add('$_menit menit');
    if (parts.isEmpty) return 'Baru saja lahir!';
    return parts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        title: const Text(
          'Umur Lengkap',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
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
        iconTheme: const IconThemeData(color: Colors.white),
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
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.cake_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kalkulator Umur',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Hitung umur hingga menit',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Input section label
                  const Text(
                    'Tanggal & Jam Lahir',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF37474F),
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Date picker
                  GestureDetector(
                    onTap: () => _selectBirthDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFBBDEFB)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1565C0).withAlpha(25),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFBBDEFB),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.calendar_month_rounded,
                              color: Color(0xFF1976D2),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Tanggal Lahir',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF90A4AE),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _formatTanggal(_birthDate),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1A237E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: Color(0xFF90CAF9),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Time picker
                  GestureDetector(
                    onTap: () => _selectTime(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFBBDEFB)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1565C0).withAlpha(25),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFB3E5FC),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.access_time_rounded,
                              color: Color(0xFF0277BD),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Jam Lahir',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF90A4AE),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${_birthHour.toString().padLeft(2, '0')}:${_birthMinute.toString().padLeft(2, '0')} WIB',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1A237E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: Color(0xFF90CAF9),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  if (_hasResult) ...[
                    // Summary card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0D47A1), Color(0xFF1E88E5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1565C0).withAlpha(60),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.celebration_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Umur Saat Ini',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _buildSummary(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Divider(color: Colors.white24),
                          const SizedBox(height: 8),
                          Text(
                            'Lahir: ${_formatTanggal(_birthDate)}, pukul ${_birthHour.toString().padLeft(2, '0')}:${_birthMinute.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Detail rows
                    const Text(
                      'Rincian',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF37474F),
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailItem(
                      'Tahun',
                      _tahun,
                      Icons.calendar_today_rounded,
                      const Color(0xFF1565C0),
                      const Color(0xFFBBDEFB),
                    ),
                    _buildDetailItem(
                      'Bulan',
                      _bulan,
                      Icons.date_range_rounded,
                      const Color(0xFF0277BD),
                      const Color(0xFFB3E5FC),
                    ),
                    _buildDetailItem(
                      'Hari',
                      _hari,
                      Icons.today_rounded,
                      const Color(0xFF1976D2),
                      const Color(0xFFBBDEFB),
                    ),
                    _buildDetailItem(
                      'Jam',
                      _jam,
                      Icons.access_time_rounded,
                      const Color(0xFF01579B),
                      const Color(0xFFBBDEFB),
                    ),
                    _buildDetailItem(
                      'Menit',
                      _menit,
                      Icons.timer_outlined,
                      const Color(0xFF1E88E5),
                      const Color(0xFFBBDEFB),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    String label,
    int value,
    IconData icon,
    Color color,
    Color accent,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(20),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 14),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Color(0xFF37474F),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$value $label',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
