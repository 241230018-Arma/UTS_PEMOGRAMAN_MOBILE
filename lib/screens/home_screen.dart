import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_data.dart';
import '../widgets/shared_widgets.dart';
import 'material_info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF4CAF50), width: 2),
                image: const DecorationImage(
                  image: NetworkImage('https://i.pravatar.cc/100?img=12'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('HALO, BUDAK PONTIANAK!', style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600], fontWeight: FontWeight.w500)),
                Text(AppData.userName, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        actions: [IconButton(icon: const Icon(Icons.chat_bubble_outline), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            WalletCard(
              points: AppData.totalPoints,
              kg: AppData.totalKg,
              onVoucherTap: () => Navigator.pushNamed(context, '/rewards'),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('3 Kategori Bahan Baku Utama', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () => Navigator.pushNamed(context, '/jemput'), child: Text('Mulai Setor', style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF4CAF50), fontWeight: FontWeight.w600))),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: AppProducts.materials.map((m) => Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MaterialInfoScreen(material: m))),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                      child: Column(
                        children: [
                          Container(width: 60, height: 60, decoration: BoxDecoration(color: m.color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(14)), child: Icon(m.icon, color: m.color, size: 30)),
                          const SizedBox(height: 10),
                          Text(m.title.split(' ')[0], textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, height: 1.3)),
                        ],
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 24),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text('Edukasi & Dampak Lingkungan', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold))),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: [Icon(Icons.info_outline, size: 14, color: Colors.grey[600]), const SizedBox(width: 4), Text('Pelajari 2 Manfaat & 2 Dampak Utama', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]))]),
            ),
            const SizedBox(height: 12),
            _buildEduCard('MANFAAT', 'Sirkular Ekonomi', 'Siklus Sirkular Sempurna: Manfaat Hebat Daur Ulang bagi Pontianak', const Color(0xFF4CAF50)),
            const SizedBox(height: 12),
            _buildEduCard('MANFAAT', 'Energi Hijau', 'Dari Dapur Jadi Bahan Bakar: Manfaat Mengolah Jelantah Jadi Biodiesel', const Color(0xFF4CAF50)),
            const SizedBox(height: 12),
            _buildEduCard('DAMPAK', 'Saluran Kota', 'Parit Tersumbat & Banjir: Dampak Fatal Jelantah Tanpa Daur Ulang', Colors.red),
            const SizedBox(height: 12),
            _buildEduCard('DAMPAK', 'Ekosistem Kapuas', 'Ancaman Mikroplastik & TPA Meledak: Dampak Buruk Sampah Tercampur', Colors.red),
            const SizedBox(height: 24),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text('Mengapa Harus Didaur Ulang?', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold))),
            const SizedBox(height: 12),
            _buildWhyCard('1', 'Mengurangi pencemaran', 'Mencegah minyak dan bahan bekas mencemar tanah serta saluran air.'),
            _buildWhyCard('2', 'Memberi nilai guna baru', 'Bahan yang terkumpul dapat diproses menjadi produk yang lebih bermanfaat.'),
            _buildWhyCard('3', 'Mendukung kebiasaan bersih', 'Membantu masyarakat memilah dan mengelola bahan bekas dari rumah.'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildEduCard(String tag, String title, String subtitle, Color tagColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          Container(
            width: 80, height: 80, decoration: BoxDecoration(color: tagColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: tagColor, borderRadius: BorderRadius.circular(6)), child: Text(tag, style: GoogleFonts.poppins(fontSize: 7, color: Colors.white, fontWeight: FontWeight.bold))),
              const SizedBox(height: 4),
              Icon(Icons.recycling, color: tagColor, size: 24),
            ]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600], fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w600, height: 1.3)),
              const SizedBox(height: 8),
              Row(children: [Text('Baca Selengkapnya', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF4CAF50), fontWeight: FontWeight.w500)), const Icon(Icons.arrow_forward, size: 14, color: Color(0xFF4CAF50))]),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyCard(String number, String title, String desc) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(width: 40, height: 40, decoration: const BoxDecoration(color: Color(0xFF4CAF50), shape: BoxShape.circle), child: Center(child: Text(number, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)), const SizedBox(height: 4), Text(desc, style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]))])),
        ],
      ),
    );
  }
}