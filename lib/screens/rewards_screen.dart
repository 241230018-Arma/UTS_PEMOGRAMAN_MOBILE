import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_data.dart';
import '../widgets/shared_widgets.dart';
import 'voucher_detail_screen.dart';
import 'topup_confirm_screen.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  String _selectedTab = 'Katalog Recycle';
  String _selectedCategory = 'Semua Produk';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.shopping_bag_outlined, color: Color(0xFF4CAF50)),
            const SizedBox(width: 8),
            Text('EcoShop: Pasar Produk Hijau', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          WalletCard(points: AppData.totalPoints, kg: AppData.totalKg),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 'Katalog Recycle'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == 'Katalog Recycle' ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('Katalog Recycle', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: _selectedTab == 'Katalog Recycle' ? Colors.black87 : Colors.grey[600])),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 'Voucher & Pesananku (1)'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == 'Voucher & Pesananku (1)' ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('Voucher & Pesananku (1)', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: _selectedTab == 'Voucher & Pesananku (1)' ? Colors.black87 : Colors.grey[600])),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_selectedTab == 'Katalog Recycle')
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: ['Semua Produk', 'Daur Ulang Plastik', 'Kertas Daur Ulang', 'Olahan Minyak Jelantah', 'Voucher'].map((c) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedCategory = c),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: _selectedCategory == c ? const Color(0xFF4CAF50) : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(c, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: _selectedCategory == c ? Colors.white : Colors.black87)),
                    ),
                  ),
                )).toList(),
              ),
            ),
          const SizedBox(height: 16),
          Expanded(
            child: _selectedTab == 'Katalog Recycle' ? _buildProductList() : _buildVoucherList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: AppProducts.allProducts.length,
      itemBuilder: (context, index) {
        final product = AppProducts.allProducts[index];
        if (_selectedCategory != 'Semua Produk' && product.category != _selectedCategory) return const SizedBox.shrink();
        return GestureDetector(
          onTap: () {
            if (product.category == 'Voucher' && product.name.contains('DANA')) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const TopupConfirmScreen()));
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (_) => VoucherDetailScreen(product: product)));
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Container(
                  width: 80, height: 80, decoration: BoxDecoration(color: product.tagColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                  child: Icon(product.icon, color: product.tagColor, size: 40),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.tag, style: GoogleFonts.poppins(fontSize: 9, color: product.tagColor, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(product.name, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(product.description, style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600])),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text('${product.points.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} Poin', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF4CAF50))),
                          const SizedBox(width: 8),
                          Text('atau Rp ${product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}', style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (product.category == 'Voucher' && product.name.contains('DANA')) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const TopupConfirmScreen()));
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => VoucherDetailScreen(product: product)));
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  child: Text('Tukar', style: GoogleFonts.poppins(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVoucherList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Robries Coaster Estetik', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text('Untuk ekspor biodiesel', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600])),
                  ],
                ),
              ),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)), child: Text('Gunakan', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey))),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Top Up Dana', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text('19 Juli 2026, 19:30 WIB', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600])),
                  ],
                ),
              ),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)), child: Text('Berhasil', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.green))),
            ],
          ),
        ),
      ],
    );
  }
}