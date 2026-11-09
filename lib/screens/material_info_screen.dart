import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_data.dart';

class MaterialInfoScreen extends StatelessWidget {
  final MaterialInfo material;
  const MaterialInfoScreen({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(width: 60, height: 60, decoration: BoxDecoration(color: material.color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(14)), child: Icon(material.icon, color: material.color, size: 30)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(material.title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(material.subtitle, style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600])),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoBox('${material.pointsPerKg}', 'Poin/Kg'),
                  _buildInfoBox(material.materialType, 'Jenis bahan'),
                  _buildInfoBox(material.requirement, 'Syarat utama'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildSection('Apa itu ${material.title.split(' ')[0].toLowerCase()}?', material.title.contains('Minyak') ? 'Minyak jelantah adalah minyak goreng bekas yang telah digunakan berulang kali.' : material.title.contains('Botol') ? 'Kategori ini mencakup botol minuman, botol sabun, wadah makanan, gelas plastik.' : 'Kategori ini mencakup kardus bekas, kertas HVS, kertas fotokopi, lembar dokumen.'),
            const SizedBox(height: 16),
            if (material.acceptedTypes.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jenis yang diterima', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: material.acceptedTypes.map((t) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: material.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                        child: Text(t, style: GoogleFonts.poppins(fontSize: 10, color: material.color, fontWeight: FontWeight.w500)),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Manfaat dan dampaknya', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  ...material.benefits.map((b) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle, size: 16, color: Color(0xFF4CAF50)),
                        const SizedBox(width: 8),
                        Expanded(child: Text(b, style: GoogleFonts.poppins(fontSize: 12))),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Proses Rycle', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  ...material.processSteps.asMap().entries.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24, height: 24, decoration: const BoxDecoration(color: Color(0xFF4CAF50), shape: BoxShape.circle),
                          child: Center(child: Text('${e.key + 1}', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold))),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(e.value, style: GoogleFonts.poppins(fontSize: 12))),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chat),
                label: Text('Chat Admin', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50), padding: const EdgeInsets.symmetric(vertical: 14)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(String value, String label) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF4CAF50))),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(content, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
        ],
      ),
    );
  }
}