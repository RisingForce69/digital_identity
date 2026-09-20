import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

void main() {
  runApp(const DigitalIdentityApp());
}

// 1. Mengubah DigitalIdentityApp menjadi StatefulWidget untuk mengatur state tema
class DigitalIdentityApp extends StatefulWidget {
  const DigitalIdentityApp({super.key});

  @override
  State<DigitalIdentityApp> createState() => _DigitalIdentityAppState();
}

class _DigitalIdentityAppState extends State<DigitalIdentityApp> {
  bool _isDarkMode = true; // Default tema gelap sesuai kodingan aslimu

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Identity',
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      
      // Tema Terang (Light Mode)
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black, fontFamily: 'Sans'),
        ),
      ),
      
      // Tema Gelap (Dark Mode)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F141E),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white, fontFamily: 'Sans'),
        ),
      ),
      // Meneruskan state dan fungsi toggle ke ProfileScreen
      home: ProfileScreen(
        isDarkMode: _isDarkMode,
        onThemeToggle: toggleTheme,
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const ProfileScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late YoutubePlayerController _ytController;

  @override
  void initState() {
    super.initState();
    // ID YouTube Shorts
    _ytController = YoutubePlayerController.fromVideoId(
      videoId: 'S7F9c1kzpEg', 
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
  }

  @override
  void dispose() {
    _ytController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Menghilangkan hamburger menu
        actions: [
          // Mengganti ikon titik 3 dengan tombol toggle tema
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: widget.isDarkMode ? const Color(0xFF1E2738) : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: Icon(
                  widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: widget.isDarkMode ? Colors.white : Colors.black87,
                  size: 20,
                ),
                onPressed: widget.onThemeToggle,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            // 1. HEADER (Profile Picture, Name, Major)
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Color(0xFF4A89A7),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: widget.isDarkMode ? const Color(0xFF1E2738) : Colors.grey[200],
                backgroundImage: const AssetImage('assets/pfp.jpg'), 
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Judson Phangestu",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: widget.isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "NIM 2411090",
              style: TextStyle(
                fontSize: 14,
                color: widget.isDarkMode ? const Color(0xFF8B9CB6) : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: widget.isDarkMode ? const Color(0xFF1E2738) : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("🎓 ", style: TextStyle(fontSize: 14)),
                  Text(
                    "Teknik Informatika",
                    style: TextStyle(
                      color: widget.isDarkMode ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. SKILLS SECTION
            _buildSectionContainer(
              title: "Skills",
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildSkillChip("JavaScript", isSolid: true),
                  _buildSkillChip("UI/UX", isSolid: false),
                  _buildSkillChip("Git", isSolid: false),
                  _buildSkillChip("Figma", isSolid: false),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 3. CONTACT SECTION
            _buildSectionContainer(
              title: "Contact",
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContactCard(
                    icon: Icons.mail_outline,
                    color: const Color(0xFF1E3A5F),
                    text: "judsonphanges@\ngmail.com",
                  ),
                  const SizedBox(width: 10),
                  _buildContactCard(
                    icon: Icons.phone_outlined,
                    color: const Color(0xFF23442C),
                    text: "+62 822-2383-5969",
                  ),
                  const SizedBox(width: 10),
                  _buildContactCard(
                    icon: Icons.code,
                    color: const Color(0xFF151921),
                    text: "github.com/\nRisingForce69",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 4. ABOUT ME SECTION (YOUTUBE SHORTS VIDEO)
            _buildSectionContainer(
              title: "About Me",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: YoutubePlayer(
                  controller: _ytController,
                  aspectRatio: 9 / 16, 
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BANTUAN DENGAN LOGIKA TEMA ---

  Widget _buildSectionContainer({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.isDarkMode ? const Color(0xFF161E2D) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: widget.isDarkMode
            ? []
            : [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: widget.isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label, {required bool isSolid}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSolid ? const Color(0xFF0F52BA) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSolid ? const Color(0xFF0F52BA) : (widget.isDarkMode ? const Color(0xFF0F52BA) : Colors.grey[400]!), 
          width: 1.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSolid ? Colors.white : (widget.isDarkMode ? Colors.white : Colors.black87), 
          fontSize: 13, 
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildContactCard({required IconData icon, required Color color, required String text}) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              // Di mode terang, warna solid diganti jadi transparan agar teks di bawahnya tetap cocok
              color: widget.isDarkMode ? color : color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: widget.isDarkMode ? Colors.white : color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.isDarkMode ? const Color(0xFF8B9CB6) : Colors.grey[700],
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}