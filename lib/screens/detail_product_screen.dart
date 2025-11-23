import 'package:flutter/material.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key});

  final String namaPanggilan = "nabil";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? product = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk $namaPanggilan'),
      ),
      body: product == null
          ? const Center(child: Text("Data produk tidak ditemukan"))
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 60,
                        color: Colors.deepPurple.shade300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Text(
                    product['nama'],
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Divider(thickness: 1.5),
                  const SizedBox(height: 16),

                  _buildDetailRow(
                    context, 
                    icon: Icons.qr_code, 
                    label: "Kode Produk", 
                    value: product['kode']
                  ),
                  const SizedBox(height: 16),

                  _buildDetailRow(
                    context, 
                    icon: Icons.attach_money, 
                    label: "Harga", 
                    value: "Rp ${product['harga']}",
                    isPrice: true,
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    "Deskripsi:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      product['deskripsi'] ?? "Tidak ada deskripsi.",
                      style: const TextStyle(fontSize: 15, height: 1.5),
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Kembali ke List"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildDetailRow(BuildContext context, {required IconData icon, required String label, required String value, bool isPrice = false}) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 28),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: isPrice ? Colors.green : Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}