import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_data.dart';

class JemputScreen extends StatefulWidget {
  const JemputScreen({super.key});

  @override
  State<JemputScreen> createState() => _JemputScreenState();
}

class _JemputScreenState extends State<JemputScreen> {
  int _currentStep = 1;
  double _uco = 0, _plastik = 0, _kardus = 0;
  String _selectedDate = 'Hari Ini';
  String _selectedTime = 'Pagi (08:00-12:00)';
  final _addressController = TextEditingController(
    text: 'Jalan Jenderal Ahmad Yani Nomor 111, Kecamatan Pontianak Tenggara, Kota Pontianak, Kalimantan Barat.',
  );
  final _noteController = TextEditingController(
    text: 'Barangnya saya simpan di depan rumah bg',
  );

  int get _totalWeight => (_uco + _plastik + _kardus).toInt();
  int get _totalPoints => (_uco * 6000 + _plastik * 1700 + _kardus * 4000).toInt();

  @override
  void dispose() {
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (_currentStep > 1) {
              setState(() => _currentStep--);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Setor Bahan Daur Ulang', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
            Text('Langkah $_currentStep dari 3', style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600])),
          ],
        ),
      ),
      body: _currentStep == 1 ? _buildStep1() : _currentStep == 2 ? _buildStep2() : _buildStep3(),
    );
  }

  // ====== LANGKAH 1 ======
  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF4CAF50).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Color(0xFF4CAF50)),
                const SizedBox(width: 12),
                Expanded(child: Text('Pilahlah Terlebih Dahulu. Bahan baku yang anda setor akan diolah menjadi produk premium.', style: GoogleFonts.poppins(fontSize: 12))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildMaterialInput('Minyak Jelantah (UCO)', _uco, 6000, Icons.local_gas_station, const Color(0xFFFFA726), (v) => setState(() => _uco = v)),
          _buildMaterialInput('Botol & Wadah Plastik', _plastik, 1700, Icons.local_drink, const Color(0xFF42A5F5), (v) => setState(() => _plastik = v)),
          _buildMaterialInput('Kardus & HVS', _kardus, 4000, Icons.inventory_2, const Color(0xFFA1887F), (v) => setState(() => _kardus = v)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('BERAT MASUKAN', style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600])),
                  Text('$_totalWeight Kg', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('KOIN DIPEROLEH', style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600])),
                  Text('+$_totalPoints Poin', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF4CAF50))),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _totalWeight > 0 ? () => setState(() => _currentStep = 2) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _totalWeight > 0 ? const Color(0xFF4CAF50) : Colors.grey,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Selesaikan Alamat Penjemputan', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialInput(String name, double value, int pointsPerKg, IconData icon, Color color, ValueChanged<double> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 22)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
            Text('$pointsPerKg Poin/Kg', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600])),
          ])),
          Row(children: [
            IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: value > 0 ? () => onChanged(value - 1) : null),
            Text('${value.toInt()} Kg', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
            IconButton(icon: const Icon(Icons.add_circle_outline, color: Color(0xFF4CAF50)), onPressed: () => onChanged(value + 1)),
          ]),
        ],
      ),
    );
  }

  // ====== LANGKAH 2 ======
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Icon(Icons.location_on, color: Color(0xFF4CAF50)),
                const SizedBox(width: 8),
                Text('TITIK GPS RUMAH ANDA', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                const Spacer(),
                Text('Ketuk Peta untuk ubah Lokasi', style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600])),
              ]),
              const SizedBox(height: 12),
              Text('GG KAYUMANIS II, Pontianak', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
              Text('Titik GPS Utama Terpilih', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF4CAF50))),
            ]),
          ),
          const SizedBox(height: 16),
          Text('Alamat Penjemputan', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(controller: _addressController, maxLines: 3, decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), filled: true, fillColor: Colors.white)),
          const SizedBox(height: 16),
          Text('Catatan Tambahan', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(controller: _noteController, decoration: InputDecoration(hintText: 'Contoh: Titip plastik dekat tanaman depan rumah...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), filled: true, fillColor: Colors.white)),
          const SizedBox(height: 16),
          Text('PILIH TANGGAL PENGAMBILAN', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, children: ['Hari Ini', 'Besok', 'Lusa', 'Senin', 'Selasa', 'Rabu'].map((d) => GestureDetector(
            onTap: () => setState(() => _selectedDate = d),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: _selectedDate == d ? const Color(0xFF4CAF50) : Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade300)),
              child: Text(d, style: GoogleFonts.poppins(fontSize: 11, color: _selectedDate == d ? Colors.white : Colors.black87, fontWeight: FontWeight.w600)),
            ),
          )).toList()),
          const SizedBox(height: 8),
          Wrap(spacing: 8, children: ['Pagi (08:00-12:00)', 'Siang (13:00-16:00)'].map((t) => GestureDetector(
            onTap: () => setState(() => _selectedTime = t),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: _selectedTime == t ? const Color(0xFF4CAF50) : Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade300)),
              child: Text(t, style: GoogleFonts.poppins(fontSize: 11, color: _selectedTime == t ? Colors.white : Colors.black87, fontWeight: FontWeight.w600)),
            ),
          )).toList()),
          const SizedBox(height: 24),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: () => setState(() => _currentStep = 1), child: Text('Kembali', style: GoogleFonts.poppins()))),
            const SizedBox(width: 12),
            Expanded(child: ElevatedButton(onPressed: () => setState(() => _currentStep = 3), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)), child: Text('Selesai & Ringkasan', style: GoogleFonts.poppins(color: Colors.white)))),
          ]),
        ],
      ),
    );
  }

  // ====== LANGKAH 3 ======
  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF4CAF50).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: Text('Verifikasi Data Setoran. Harap pastikan semua detail di bawah ini sudah tepat sebelum kami mengirimkan kurir.', style: GoogleFonts.poppins(fontSize: 12)),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('BAHAN BAKU DISETOR', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              if (_uco > 0) _buildSummaryRow('Minyak Jelantah (UCO) (${_uco.toInt()} Kg)', '+${(_uco * 6000).toInt()} Poin'),
              if (_plastik > 0) _buildSummaryRow('Botol & Wadah Plastik (${_plastik.toInt()} Kg)', '+${(_plastik * 1700).toInt()} Poin'),
              if (_kardus > 0) _buildSummaryRow('Kardus & HVS (${_kardus.toInt()} Kg)', '+${(_kardus * 4000).toInt()} Poin'),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('LOKASI & PENJADWALAN', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Icon(Icons.location_on, color: Color(0xFF4CAF50), size: 16),
              const SizedBox(height: 4),
              Text(_addressController.text, style: GoogleFonts.poppins(fontSize: 12)),
              const SizedBox(height: 8),
              Text('Catatan: ${_noteController.text}', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
              const SizedBox(height: 8),
              Text('Jadwal: $_selectedDate, $_selectedTime', style: GoogleFonts.poppins(fontSize: 12)),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF4CAF50), borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Estimasi Koin Diperoleh:', style: GoogleFonts.poppins(fontSize: 13, color: Colors.white)),
                Text('+$_totalPoints Poin', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: () => setState(() => _currentStep = 2), child: const Text('Kembali'))),
            const SizedBox(width: 12),
            Expanded(child: ElevatedButton(onPressed: _confirmPickup, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)), child: Text('Pesan Penjemputan', style: GoogleFonts.poppins(color: Colors.white)))),
          ]),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 12)),
          Text(value, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF4CAF50))),
        ],
      ),
    );
  }

  // ====== KONFIRMASI - VERSI PALING AMAN (TANPA DIALOG POP) ======
  void _confirmPickup() {
    // 1. Update data DULU
    AppData.hasOngoingPickup = true;
    AppData.updatePoints(_totalPoints);
    AppData.totalKg += _totalWeight;

    // 2. Tampilkan SnackBar sukses (TIDAK PERLU DIALOG!)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 32),
            const SizedBox(height: 8),
            Text('Penjemputan Sukses Terjadwal!', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Kurir Prasetyo (ID: #4092) akan menjemput bahan Anda.', style: GoogleFonts.poppins(fontSize: 11)),
          ],
        ),
        backgroundColor: const Color(0xFF4CAF50),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    // 3. Reset form
    setState(() {
      _uco = 0;
      _plastik = 0;
      _kardus = 0;
      _currentStep = 1;
    });

    // 4. KEMBALI KE HOME dengan cara PALING AMAN
    // Hapus semua route dan push /home
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }
}