import 'package:flutter/material.dart';
import 'package:tugas9/bloc/produk_bloc.dart';
import 'package:tugas9/models/produk.dart';
import 'package:tugas9/widgets/warning_dialog.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _kodeController = TextEditingController();
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  
  bool _isLoading = false;
  final String namaPanggilan = "Imam";

  void _simpanProduk() {
    if (_formKey.currentState!.validate()) {
      setState(() { _isLoading = true; });

      Produk createProduk = Produk(
        id: null, 
        kodeProduk: _kodeController.text,
        namaProduk: _namaController.text,
        hargaProduk: int.parse(_hargaController.text),
      );

      ProdukBloc.addProduk(produk: createProduk).then((value) {
        Navigator.pop(context); 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil menambah produk!'), 
            backgroundColor: Colors.green
          ),
        );
      }, onError: (error) {
        showDialog(
          context: context,
          builder: (context) => const WarningDialog(
            description: "Gagal menyimpan data, periksa koneksi atau inputan",
          ),
        );
      });

      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Produk $namaPanggilan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _kodeController,
                decoration: const InputDecoration(
                  labelText: 'Kode Produk', 
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.qr_code),
                ),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Produk', 
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_bag),
                ),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga', 
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  if (int.tryParse(value) == null) return 'Harus angka valid';
                  return null;
                },
              ),
              const SizedBox(height: 24),

              _isLoading 
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _simpanProduk,
                    icon: const Icon(Icons.save),
                    label: const Text('Simpan Produk'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}