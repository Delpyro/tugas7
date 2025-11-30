import 'package:flutter/material.dart';
import 'package:tugas9/bloc/produk_bloc.dart';
import 'package:tugas9/models/produk.dart';
import 'package:tugas9/widgets/side_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String namaPanggilan = "Imam"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Produk $namaPanggilan'), 
      ),
      drawer: const SideMenu(), 
      
      body: FutureBuilder<List<Produk>>(
        future: ProdukBloc.getProduks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Gagal memuat data: \n${snapshot.error}", 
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<Produk> listProduk = snapshot.data!;
          if (listProduk.isEmpty) {
             return const Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Icon(Icons.inbox_outlined, size: 60, color: Colors.grey),
                   SizedBox(height: 10),
                   Text("Belum ada produk di database."),
                 ],
               ),
             );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: listProduk.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple.shade100,
                    child: Text(
                      listProduk[index].namaProduk![0].toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                  ),
                  title: Text(
                    listProduk[index].namaProduk ?? "-",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text("Kode: ${listProduk[index].kodeProduk}"),
                      Text(
                        "Rp ${listProduk[index].hargaProduk}",
                        style: const TextStyle(
                          color: Colors.green, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detail_product',
                      arguments: listProduk[index],
                    ).then((value) {
                      setState((){});
                    }); 
                  },
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add_product');
          setState(() {}); 
        },
        tooltip: 'Tambah Produk',
        child: const Icon(Icons.add),
      ),
    );
  }
}