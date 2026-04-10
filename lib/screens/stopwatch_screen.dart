import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  final List<Map<String, String>> _laps = [];

  void _start() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {
      setState(() {});
    });
  }

  void _stop() {
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {});
  }

  void _reset() {
    _stopwatch.reset();
    setState(() {
      _laps.clear();
    });
  }

  void _recordLap() {
    if (!_stopwatch.isRunning) return;
    setState(() {
      _laps.insert(0, {
        'lap': 'Lap ${_laps.length + 1}',
        'time': _formatTime(),
      });
    });
  }

  String _formatTime() {
    int setJam = 0;
    int setMenit = 0;
    int setDetik = 0;

    int offsetMs = (setJam * 3600000) + (setMenit * 60000) + (setDetik * 1000);
    final ms = _stopwatch.elapsedMilliseconds + offsetMs;

    int hundreds = (ms / 10).truncate() % 100;
    int seconds = (ms / 1000).truncate() % 60;
    int minutes = (ms / (1000 * 60)).truncate() % 60;
    int hours = (ms / (1000 * 60 * 60)).truncate();

    if (hours > 0) {
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${hundreds.toString().padLeft(2, '0')}";
    }
    
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${hundreds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isRunning = _stopwatch.isRunning;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        title: const Text(
          'Stopwatch',
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
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.timer_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Stopwatch',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      isRunning ? 'Sedang berjalan...' : 'Siap digunakan',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Status indicator
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isRunning
                        ? const Color(0xFF69F0AE)
                        : Colors.white.withOpacity(0.4),
                    boxShadow: isRunning
                        ? [
                            BoxShadow(
                              color: const Color(0xFF69F0AE).withOpacity(0.7),
                              blurRadius: 6,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                ),
              ],
            ),
          ),

          // Main content scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 32),

                  // Clock display
                  Container(
                    width: 290,
                    height: 290,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1565C0).withOpacity(0.15),
                          blurRadius: 48,
                          spreadRadius: 12,
                        ),
                      ],
                      border: Border.all(
                        color: isRunning
                            ? const Color(0xFF1976D2).withOpacity(0.5)
                            : const Color(0xFFBBDEFB),
                        width: 8,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _formatTime(),
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w300,
                          color: isRunning
                              ? const Color(0xFF0D47A1)
                              : const Color(0xFF90A4AE),
                          fontFeatures: const [FontFeature.tabularFigures()],
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Control buttons (4 buttons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCircularButton(
                        icon: Icons.play_arrow_rounded,
                        activeGradient: const LinearGradient(
                          colors: [Color(0xFF1565C0), Color(0xFF1E88E5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onPressed: isRunning ? null : _start,
                        tooltip: 'Start',
                        size: 60,
                      ),
                      const SizedBox(width: 14),
                      _buildCircularButton(
                        icon: Icons.pause_rounded,
                        activeGradient: const LinearGradient(
                          colors: [Color(0xFF0277BD), Color(0xFF0288D1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onPressed: isRunning ? _stop : null,
                        tooltip: 'Stop',
                        size: 60,
                      ),
                      const SizedBox(width: 14),
                      _buildCircularButton(
                        icon: Icons.flag_rounded,
                        activeGradient: const LinearGradient(
                          colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onPressed: isRunning ? _recordLap : null,
                        tooltip: 'Catat Waktu',
                        size: 60,
                      ),
                      const SizedBox(width: 14),
                      _buildCircularButton(
                        icon: Icons.refresh_rounded,
                        activeGradient: const LinearGradient(
                          colors: [Color(0xFF01579B), Color(0xFF0277BD)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onPressed: _reset,
                        tooltip: 'Reset',
                        size: 60,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Button labels
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButtonLabel('Start', !isRunning),
                      const SizedBox(width: 34),
                      _buildButtonLabel('Stop', isRunning),
                      const SizedBox(width: 38),
                      _buildButtonLabel('Lap', isRunning),
                      const SizedBox(width: 34),
                      _buildButtonLabel('Reset', true),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Lap list section
                  if (_laps.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.flag_rounded,
                            size: 18,
                            color: Color(0xFF1565C0),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Catatan Waktu',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0D47A1),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFBBDEFB),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${_laps.length} lap',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1565C0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _laps.length,
                      itemBuilder: (context, index) {
                        final lap = _laps[index];
                        final lapNumber = _laps.length - index;

                        // Find fastest & slowest only when there are multiple laps
                        final allTimes = _laps.map((e) => e['time']!).toList();
                        final fastestTime = allTimes.reduce(
                          (a, b) => a.compareTo(b) < 0 ? a : b,
                        );
                        final slowestTime = allTimes.reduce(
                          (a, b) => a.compareTo(b) > 0 ? a : b,
                        );
                        final bool isFastest =
                            _laps.length > 1 && lap['time'] == fastestTime;
                        final bool isSlowest =
                            _laps.length > 1 && lap['time'] == slowestTime;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isFastest
                                  ? const Color(0xFF81C784).withOpacity(0.7)
                                  : isSlowest
                                  ? const Color(0xFFE57373).withOpacity(0.7)
                                  : const Color(0xFFBBDEFB),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF1565C0,
                                ).withOpacity(0.07),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                // Lap number badge
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: isFastest
                                        ? const Color(0xFFC8E6C9)
                                        : isSlowest
                                        ? const Color(0xFFFFCDD2)
                                        : const Color(0xFFBBDEFB),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$lapNumber',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: isFastest
                                            ? const Color(0xFF388E3C)
                                            : isSlowest
                                            ? const Color(0xFFD32F2F)
                                            : const Color(0xFF1565C0),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lap['lap']!,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF37474F),
                                      ),
                                    ),
                                    if (isFastest)
                                      const Text(
                                        '🏆 Tercepat',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF388E3C),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    else if (isSlowest)
                                      const Text(
                                        '🐢 Terlambat',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFFD32F2F),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  lap['time']!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0D47A1),
                                    fontFeatures: [
                                      FontFeature.tabularFigures(),
                                    ],
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonLabel(String label, bool active) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: active ? const Color(0xFF1565C0) : Colors.grey.shade400,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required LinearGradient activeGradient,
    required VoidCallback? onPressed,
    required String tooltip,
    required double size,
  }) {
    final bool isActive = onPressed != null;

    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isActive ? activeGradient : null,
            color: isActive ? null : const Color(0xFFECEFF1),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: const Color(0xFF1565C0).withOpacity(0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : [],
          ),
          child: Icon(
            icon,
            size: 26,
            color: isActive ? Colors.white : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
