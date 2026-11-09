import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 90, height: 90,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF4CAF50), width: 3), image: const DecorationImage(image: NetworkImage('https://i.pravatar.cc/200?img=12'), fit: BoxFit.cover)),
            ),
            const SizedBox(height: 12),
            Text(AppData.userName, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PORTOFOLIO JEJAK HIJAU', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat('20.5 Kg', 'Plastik HDPE', const Color(0xFF42A5F5)),
                      _buildStat('12.0 Kg', 'Kardus Daur Ulang', const Color(0xFFA1887F)),
                      _buildStat('5.7 Kg', 'Minyak Jelantah', const Color(0xFFFFA726)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFF4CAF50).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(Icons.eco, color: Color(0xFF4CAF50)),
                        const SizedBox(width: 8),
                        Text('Total CO2 Terhindarkan: 19.5 Kg', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF4CAF50))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildMenu(Icons.person, 'Edit Profil', 'Ubah informasi profil Anda', () {}),
            _buildMenu(Icons.eco, 'Dampak Lingkungan', 'Lihat dampak positif yang Anda berikan', () {}),
            _buildMenu(Icons.lock, 'Privasi & Keamanan', 'Kelola privasi dan keamanan akun', () {}),
            _buildMenu(Icons.help, 'Bantuan', 'Pusat bantuan dan pertanyaan umum', () {}),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: Text('Log Out', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label, Color color) {
    return Column(
      children: [
        Container(width: 50, height: 50, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle), child: Icon(Icons.recycling, color: color)),
        const SizedBox(height: 8),
        Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
        Text(label, style: GoogleFonts.poppins(fontSize: 9, color: Colors.grey[600]), textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildMenu(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey[700]),
        title: Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600])),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}