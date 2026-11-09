import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_data.dart';

class TopupConfirmScreen extends StatefulWidget {
  const TopupConfirmScreen({super.key});

  @override
  State<TopupConfirmScreen> createState() => _TopupConfirmScreenState();
}

class _TopupConfirmScreenState extends State<TopupConfirmScreen> {
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: Text('Konfirmasi Penukaran', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Container(
                    width: 60, height: 60, decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 30),
                  ),
                  const SizedBox(height: 16),
                  Text('DANA', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Anda akan menukarkan 5.000 Poin menjadi Rp 5.000 Saldo DANA', style: GoogleFonts.poppins(fontSize: 12), textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Text('Nomor DANA', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600])),
                        const SizedBox(height: 4),
                        Text('081234567890', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.warning, color: Colors.orange, size: 16),
                      const SizedBox(width: 8),
                      Expanded(child: Text('Pastikan nomor DANA sudah benar. Nomor tidak dapat diubah setelah konfirmasi.', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[700]))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(value: _confirmed, onChanged: (v) => setState(() => _confirmed = v!), activeColor: const Color(0xFF4CAF50)),
                Expanded(child: Text('Saya telah memastikan nomor DANA sudah benar.', style: GoogleFonts.poppins(fontSize: 12))),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Batal'))),
                const SizedBox(width: 12),
                Expanded(child: ElevatedButton(
                  onPressed: _confirmed ? () => _processTopup() : null,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
                  child: Text('Konfirmasi Tukar', style: GoogleFonts.poppins(color: Colors.white)),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _processTopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60, height: 60, decoration: BoxDecoration(color: const Color(0xFF1E88E5), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 16),
            Text('Proses Top Up', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text('Sedang memproses...', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text('Mohon tunggu beberapa saat. Jangan menutup aplikasi.', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text('0%', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF1E88E5))),
            const SizedBox(height: 8),
            Text('Proses ini biasanya memakan waktu beberapa menit hingga maksimal 1x24 jam.', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
      AppData.updatePoints(-5000);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Top Up DANA Berhasil!'), backgroundColor: Colors.green));
      Navigator.pop(context);
    });
  }
}