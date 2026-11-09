import 'package:flutter/material.dart';

class AppData {
  static String userName = 'Mass Prass';
  static String userEmail = 'budak.pontianak@email.com';
  static int totalPoints = 55250;
  static double totalKg = 22.4;
  static bool hasOngoingPickup = false;
  
  static void updatePoints(int points) {
    totalPoints += points;
  }
  
  static void resetPickup() {
    hasOngoingPickup = false;
  }
}

class Product {
  final String name;
  final String description;
  final int points;
  final int price;
  final IconData icon;
  final String category;
  final String tag;
  final Color tagColor;

  Product({
    required this.name,
    required this.description,
    required this.points,
    required this.price,
    required this.icon,
    required this.category,
    required this.tag,
    required this.tagColor,
  });
}

class MaterialInfo {
  final String title;
  final String subtitle;
  final int pointsPerKg;
  final String materialType;
  final String requirement;
  final IconData icon;
  final Color color;
  final List<String> acceptedTypes;
  final List<String> benefits;
  final List<String> processSteps;

  MaterialInfo({
    required this.title,
    required this.subtitle,
    required this.pointsPerKg,
    required this.materialType,
    required this.requirement,
    required this.icon,
    required this.color,
    required this.acceptedTypes,
    required this.benefits,
    required this.processSteps,
  });
}

class AppProducts {
  static List<Product> allProducts = [
    Product(
      name: 'Robries Coaster Estetik',
      description: 'Dibuat dari 200 gram tutup botol plastik HDPE.',
      points: 45000,
      price: 45000,
      icon: Icons.shopping_bag,
      category: 'Daur Ulang Plastik',
      tag: 'DAUR ULANG PLASTIK',
      tagColor: const Color(0xFF2196F3),
    ),
    Product(
      name: 'GrowPaper: Kertas Benih',
      description: 'Kertas yang bisa ditanam setelah selesai dipakai.',
      points: 35000,
      price: 35000,
      icon: Icons.eco,
      category: 'Kertas Daur Ulang',
      tag: 'KERTAS DAUR ULANG',
      tagColor: const Color(0xFF4CAF50),
    ),
    Product(
      name: 'Eco Scent: Lilin Aromaterapi',
      description: 'Lilin relaksasi wangi murni dari jelantah',
      points: 50000,
      price: 50000,
      icon: Icons.local_fire_department,
      category: 'Olahan Minyak Jelantah',
      tag: 'OLAHAN MINYAK JELANTAH',
      tagColor: const Color(0xFFFF9800),
    ),
    Product(
      name: 'DANA: Top Up Saldo',
      description: 'Minimal top up 5.000 Poin',
      points: 5000,
      price: 5000,
      icon: Icons.account_balance_wallet,
      category: 'Voucher',
      tag: 'E-WALLET',
      tagColor: const Color(0xFF1E88E5),
    ),
    Product(
      name: 'CW Coffe: Diskon 50%',
      description: 'Long black robusta',
      points: 6000,
      price: 6000,
      icon: Icons.local_cafe,
      category: 'Voucher',
      tag: 'MAKANAN & MINUMAN',
      tagColor: const Color(0xFF795548),
    ),
    Product(
      name: 'Heika: Diskon 40%',
      description: 'Voucher hemat untuk makan siang & malam',
      points: 20000,
      price: 20000,
      icon: Icons.restaurant,
      category: 'Voucher',
      tag: 'MAKANAN & MINUMAN',
      tagColor: const Color(0xFFE91E63),
    ),
  ];

  static List<MaterialInfo> materials = [
    MaterialInfo(
      title: 'Minyak Jelantah (UCO)',
      subtitle: 'Jangan buang minyak jelantah sembarangan',
      pointsPerKg: 6000,
      materialType: 'UCO',
      requirement: 'Bersih',
      icon: Icons.local_gas_station,
      color: const Color(0xFFFFA726),
      acceptedTypes: ['Minyak goreng bekas', 'Minyak jelantah murni'],
      benefits: [
        'Mengurangi pencemaran air',
        'Dapat dimanfaatkan kembali menjadi biodiesel',
        'Memberikan nilai guna berupa poin',
      ],
      processSteps: [
        'Dinginkan minyak',
        'Saring dan simpan dalam botol tertutup',
        'Ajukan setoran melalui aplikasi',
        'Verifikasi dan poin masuk ke akun',
      ],
    ),
    MaterialInfo(
      title: 'Botol & Wadah Plastik',
      subtitle: 'Plastik bersih lebih mudah didaur ulang',
      pointsPerKg: 1700,
      materialType: 'PET/PP',
      requirement: 'Bersih',
      icon: Icons.local_drink,
      color: const Color(0xFF42A5F5),
      acceptedTypes: ['Botol minuman', 'Wadah sabun', 'Tutup botol', 'Wadah makanan', 'Plastik PET', 'Plastik PP'],
      benefits: ['Mengurangi timbunan sampah', 'Dapat digunakan kembali menjadi biji plastik', 'Menambah nilai setoran'],
      processSteps: ['Kosongkan isi botol/wadah', 'Bilas dan keringkan', 'Pisahkan berdasarkan jenis', 'Ajukan setoran'],
    ),
    MaterialInfo(
      title: 'Kardus & HVS',
      subtitle: 'Pilah kardus dan kertas agar tetap bernilai',
      pointsPerKg: 4000,
      materialType: 'Kertas',
      requirement: 'Kering',
      icon: Icons.inventory_2,
      color: const Color(0xFFA1887F),
      acceptedTypes: ['Kardus bekas', 'Kertas HVS', 'Dokumen bekas', 'Kertas fotokopi', 'Karton tipis', 'Kertas campuran'],
      benefits: ['Mengurangi limbah kertas', 'Dapat diolah kembali menjadi kertas daur ulang', 'Mendorong kebiasaan memilah'],
      processSteps: ['Pisahkan bahan dari sampah lain', 'Lipat dan rapikan', 'Pastikan tetap kering', 'Ajukan setoran'],
    ),
  ];
}