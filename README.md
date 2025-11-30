Tugas Pertemuan 10 & 11 - Aplikasi Toko Kita (CRUD API)

Aplikasi mobile ini dikembangkan menggunakan framework Flutter sebagai pemenuhan tugas mata kuliah Pemrograman Mobile. Aplikasi ini mendemonstrasikan implementasi lengkap sistem autentikasi (Login & Registrasi) serta manajemen data produk (CRUD: Create, Read, Update, Delete) yang terhubung secara real-time ke Backend REST API berbasis CodeIgniter 4.

📱 Fitur Utama Aplikasi

Aplikasi ini memiliki fitur-fitur utama sebagai berikut:

Registrasi Akun: Memungkinkan pengguna baru mendaftar ke sistem.

Login User: Sistem autentikasi aman menggunakan Token JWT.

Dashboard Produk: Menampilkan daftar produk yang diambil langsung dari database server.

Tambah Produk: Formulir untuk menambahkan data produk baru ke server.

Detail Produk: Halaman rincian untuk melihat informasi spesifik produk.

Hapus Produk: Fitur untuk menghapus data produk dari database.

Logout: Fitur keamanan untuk mengakhiri sesi pengguna.

🛠️ Alur Kerja & Dokumentasi Tampilan

Berikut adalah dokumentasi visual dan penjelasan teknis untuk setiap proses utama dalam aplikasi.

1. Modul Autentikasi

a. Halaman Login

Halaman ini adalah gerbang masuk aplikasi. Pengguna memasukkan email dan password yang telah terdaftar.

<img src="lib/screenshots/form_login.png" width="300" alt="Tampilan Form Login" />





(Gambar 1: Tampilan Form Login)

Mekanisme:

Sistem memvalidasi input (tidak boleh kosong).

Data dikirim ke endpoint /login.

Jika sukses, Token disimpan di Shared Preferences.

b. Validasi Login (Gagal)

Jika pengguna memasukkan email/password yang salah atau terjadi gangguan koneksi, sistem akan memberikan umpan balik visual berupa dialog peringatan.

<img src="lib/screenshots/gagal_login.png" width="300" alt="Notifikasi Login Gagal" />





(Gambar 2: Notifikasi Login Gagal)

2. Modul Manajemen Produk (CRUD)

a. Menambah Produk Baru (Create)

Pengguna dapat menambahkan produk baru melalui tombol tambah (+) di halaman utama.

<img src="lib/screenshots/form_add_produk.png" width="300" alt="Form Input Produk Baru" />





(Gambar 3: Form Input Produk Baru)

Mekanisme:

Pengguna mengisi Kode, Nama, dan Harga Produk.

Tombol "Simpan" akan memicu pengiriman data POST ke endpoint /produk.

b. Notifikasi Sukses (Create)

Setelah data berhasil disimpan ke server, aplikasi memberikan konfirmasi visual agar pengguna tahu tindakannya berhasil.

<img src="lib/screenshots/succ_add_produk.png" width="300" alt="Dialog Konfirmasi Sukses Menambah Produk" />





(Gambar 4: Dialog Konfirmasi Sukses Menambah Produk)

c. Menghapus Produk (Delete)

Pada halaman detail produk, terdapat opsi untuk menghapus item tersebut.

<img src="lib/screenshots/delete_produk.png" width="300" alt="Dialog Konfirmasi Penghapusan Data" />





(Gambar 5: Dialog Konfirmasi Penghapusan Data)

Mekanisme:

Menampilkan dialog konfirmasi untuk mencegah ketidaksengajaan.

Jika "Hapus" dipilih, aplikasi mengirim request DELETE ke API.

User diarahkan kembali ke halaman list yang sudah diperbarui.

⚙️ Konfigurasi Teknis

Koneksi Backend

Aplikasi ini dikonfigurasi untuk terhubung ke server lokal dengan pengaturan berikut di api_url.dart:

class ApiUrl {
  // Menggunakan IP Loopback Android Emulator
  // Ganti dengan 'localhost' jika dijalankan di Chrome
  static const String baseUrl = '[http://10.0.2.2:8080](http://10.0.2.2:8080)'; 
  
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listProduk = baseUrl + '/produk';
  static const String createProduk = baseUrl + '/produk';
  // ... endpoint lainnya
}


Struktur Folder

/bloc: Logika bisnis dan jembatan ke API.

/model: Representasi data (Objek Produk, Login, Registrasi).

/screens: Tampilan antarmuka (UI) aplikasi.

/widgets: Komponen UI yang dapat digunakan kembali (Dialog, Drawer).

/helpers: Kelas pembantu untuk koneksi HTTP dan penyimpanan token.
