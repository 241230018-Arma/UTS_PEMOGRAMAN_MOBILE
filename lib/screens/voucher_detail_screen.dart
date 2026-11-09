import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_data.dart';

class VoucherDetailScreen extends StatelessWidget {
  final Product product;
  const VoucherDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: Text('Detail Voucher', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80, height: 80, decoration: BoxDecoration(color: product.tagColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                    child: Icon(product.icon, color: product.tagColor, size: 40),
                  ),
                  const SizedBox(height: 16),
                  Text(product.name, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(product.description, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: product.tagColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                        child: Text(product.tag, style: GoogleFonts.poppins(fontSize: 10, color: product.tagColor, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dampak Hijau Kamu (Eco-Impact)', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Dengan menukar produk ini, Anda telah menyelamatkan lingkungan dari 200g sampah plastik jenis HDPE yang sulit terurai dan membantu siklus ekonomi sirkular lokal.', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Syarat & Ketentuan', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildCondition('Produk fisik dapat diambil langsung di Pos EcoDrop pilihan.'),
                  _buildCondition('Dapat dikirim bersama kurir saat jadwal penjemputan sampah berikutnya.'),
                  _buildCondition('Tunjukkan kode QR penukaran kepada petugas lapangan saat serah terima.'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _showRedeemDialog(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: Text('TUKARKAN PRODUK', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCondition(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 16, color: Color(0xFF4CAF50)),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]))),
        ],
      ),
    );
  }

  void _showRedeemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Konfirmasi Penukaran', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tukar ${product.name} dengan ${product.points} poin?', style: GoogleFonts.poppins(fontSize: 13)),
            const SizedBox(height: 16),
            Text('Poin Tersedia: ${AppData.totalPoints}', style: GoogleFonts.poppins(fontSize: 12)),
            Text('Biaya Penukaran: -${product.points}', style: GoogleFonts.poppins(fontSize: 12, color: Colors.red)),
            Text('Sisa Poin: ${AppData.totalPoints - product.points}', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              AppData.updatePoints(-product.points);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Berhasil menukar ${product.name}!'), backgroundColor: Colors.green));
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
            child: const Text('Tukar'),
          ),
        ],
      ),
    );
  }
}