import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KurirChatScreen extends StatefulWidget {
  const KurirChatScreen({super.key});

  @override
  State<KurirChatScreen> createState() => _KurirChatScreenState();
}

class _KurirChatScreenState extends State<KurirChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'sender': 'kurir', 'text': 'Halo, saya Prasetyo, kurir Rycle yang akan menjemput bahanmu.', 'time': '14:31'},
  ];

  void _sendMessage(String text) {
    if (text.isEmpty) return;
    setState(() {
      _messages.add({'sender': 'user', 'text': text, 'time': '14:${32 + _messages.length}'});
    });
    _messageController.clear();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add({'sender': 'kurir', 'text': 'Baik, saya akan segera sampai.', 'time': '14:${33 + _messages.length}'});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('KURIR Prasetyo (ID: #4092)', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
            Text('Online - Kurir menuju lokasimu', style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF4CAF50))),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF4CAF50),
            child: Column(
              children: [
                Text('Hari Ini - Penjemputan sedang berlangsung', style: GoogleFonts.poppins(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text('Kurir sedang menuju lokasi anda.', style: GoogleFonts.poppins(fontSize: 11, color: Colors.white.withValues(alpha: 0.9))),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFF4CAF50) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(msg['text'], style: GoogleFonts.poppins(fontSize: 13, color: isUser ? Colors.white : Colors.black87)),
                        const SizedBox(height: 4),
                        Text(msg['time'], style: GoogleFonts.poppins(fontSize: 9, color: isUser ? Colors.white.withValues(alpha: 0.7) : Colors.grey)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['Bahan di teras', 'Hubungi saat tiba', 'Saya menunggu', 'Tanya waktu tiba', 'Kirim lokasi'].map((q) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => _sendMessage(q),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
                          child: Text(q, style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[700])),
                        ),
                      ),
                    )).toList(),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Tulis pesan untuk kurir..',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: const Color(0xFF4CAF50),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () => _sendMessage(_messageController.text),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}