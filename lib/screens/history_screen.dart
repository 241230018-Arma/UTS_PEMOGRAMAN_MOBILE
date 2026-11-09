import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_data.dart';
import 'kurir_chat_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Refresh state saat screen muncul kembali
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Riwayat Setor',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF4CAF50),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF4CAF50),
          labelStyle:
              GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Sedang Berlangsung'),
            Tab(text: 'Selesai'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildOngoingTab(), _buildCompletedTab()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/jemput').then((_) {
            // Refresh setelah kembali dari jemput screen
            setState(() {});
          });
        },
        backgroundColor: const Color(0xFF4CAF50),
        icon: const Icon(Icons.add),
        label: Text(
          'Setor Bahan Baku Sekarang',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildOngoingTab() {
    // Cek dari AppData apakah ada penjemputan aktif
    if (!AppData.hasOngoingPickup) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.recycling, size: 40, color: Colors.grey[400]),
              ),
              const SizedBox(height: 16),
              Text(
                'Tidak ada penjemputan terjadwal.',
                style:
                    GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/jemput').then((_) {
                    setState(() {});
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Setor Bahan Baku Sekarang',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Tampilkan card kurir aktif
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const KurirChatScreen()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'KURIR MENUJU RUMAH',
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '+11.700 Poin',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4CAF50)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFF4CAF50),
                      child: Icon(Icons.person, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kurir Prasetyo',
                            style: GoogleFonts.poppins(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const KurirChatScreen()),
                              );
                            },
                            child: Text(
                              'LACAK REALTIME',
                              style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: const Color(0xFF4CAF50),
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Pengangkut Bahan Daur Ulang',
                  style:
                      GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rincian Material:',
                  style: GoogleFonts.poppins(
                      fontSize: 11, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  '• Minyak Jelantah (UCO) (1 Kg)',
                  style:
                      GoogleFonts.poppins(fontSize: 11, color: Colors.grey[700]),
                ),
                Text(
                  '• Botol & Wadah Plastik (1 Kg)',
                  style:
                      GoogleFonts.poppins(fontSize: 11, color: Colors.grey[700]),
                ),
                Text(
                  '• Kardus & HVS (1 Kg)',
                  style:
                      GoogleFonts.poppins(fontSize: 11, color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                Text(
                  'Jadwal Jemput: Hari Ini, 08:00-12:00',
                  style:
                      GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHistoryItem(
          date: '29 Juni 2026',
          title: 'SUKSES MASUK PRODUKSI',
          amount: '+11.700 Poin',
          icon: Icons.check_circle,
          iconColor: const Color(0xFF4CAF50),
        ),
        _buildHistoryItem(
          date: '08 Nov 2026',
          title: 'Setor Minyak Jelantah',
          amount: '+5.200 Poin',
          icon: Icons.local_gas_station,
          iconColor: const Color(0xFFFFA726),
        ),
        _buildHistoryItem(
          date: '05 Nov 2026',
          title: 'Setor Botol Plastik',
          amount: '+3.500 Poin',
          icon: Icons.local_drink,
          iconColor: const Color(0xFF42A5F5),
        ),
        _buildHistoryItem(
          date: '01 Nov 2026',
          title: 'Tukar Voucher',
          amount: '-10.000 Poin',
          icon: Icons.confirmation_number,
          iconColor: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildHistoryItem({
    required String date,
    required String title,
    required String amount,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style:
                      GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: amount.startsWith('+')
                  ? const Color(0xFF4CAF50)
                  : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}