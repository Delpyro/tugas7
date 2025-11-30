import 'package:flutter/material.dart';
import 'package:tugas9/bloc/produk_bloc.dart';
import 'package:tugas9/models/produk.dart';
import 'package:tugas9/widgets/warning_dialog.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final String namaPanggilan = "Imam";

  void _confirmHapus(Produk produk) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Yakin ingin menghapus data ini?"),
        actions: [
          OutlinedButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text("Hapus"),
            onPressed: () {
              ProdukBloc.deleteProduk(id: int.parse(produk.id!)).then((value) {
                Navigator.pop(context); 
                Navigator.pop(context); 
                
                ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(
                     content: Text("Berhasil dihapus"),
                     backgroundColor: Colors.green,
                   )
                );
              }, onError: (error) {
                showDialog(
                  context: context,
                  builder: (context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Produk? produk = ModalRoute.of(context)?.settings.arguments as Produk?;

    if (produk == null) {
      return const Scaffold(body: Center(child: Text("Data Error: Produk tidak ditemukan")));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk $namaPanggilan'),
      ),
      body: Padding(
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

            Center(
              child: Text(
                produk.namaProduk ?? "-",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 1.5),
            const SizedBox(height: 16),

            _buildDetailRow(
              icon: Icons.qr_code,
              label: "Kode Produk",
              value: produk.kodeProduk ?? "-",
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              icon: Icons.attach_money,
              label: "Harga",
              value: "Rp ${produk.hargaProduk}",
              isPrice: true,
            ),
       
            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () => _confirmHapus(produk),
                icon: const Icon(Icons.delete),
                label: const Text("Hapus Produk"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    bool isPrice = false,
  }) {
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