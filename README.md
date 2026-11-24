SimRS — Modul Triase & Pendaftaran IGD
RS Sehat Sentosa

1. Deskripsi Umum
Modul Triase & Pendaftaran IGD merupakan purwarupa Sistem Informasi Manajemen Rumah Sakit untuk mendukung pencatatan kunjungan pasien IGD dan penentuan kategori prioritas triase awal.

Fungsionalitas yang tersedia meliputi:

Pencatatan nomor rekam medis, identitas pseudonim, dan waktu kedatangan.
Pemilihan kategori triase Merah, Kuning, Hijau, atau Hitam.
Pencatatan keluhan utama pasien.
Pencatatan tanda vital:
Tekanan darah sistolik dan diastolik
Frekuensi nadi
Suhu tubuh
Frekuensi pernapasan
Saturasi oksigen
Validasi dasar data melalui antarmuka dan batasan pada basis data PostgreSQL.
Antarmuka berada dalam bentuk statis dan tidak mengirim atau menyimpan data pada purwarupa saat ini. Penentuan kategori klinis tetap harus dilakukan oleh tenaga kesehatan sesuai protokol rumah sakit.

2. Struktur Direktori
Text
simrs-triase-igd-kelompok4/
├── .env
├── .gitignore
├── README.md
├── ddl.sql
└── triase-igd.html
Berkas/Direktori	Fungsi
README.md	Dokumentasi umum proyek, struktur, penggunaan, dan aturan pengembangan.
triase-igd.html	Purwarupa antarmuka formulir pendaftaran dan triase IGD dalam satu halaman HTML.
ddl.sql	Definisi enum triase, tabel pendaftaran, tabel triase_igd, relasi, constraint, dan komentar kolom PostgreSQL.
.env	Penyimpanan konfigurasi lingkungan yang digunakan saat pengembangan. Tidak boleh dicantumkan dalam Git atau berisi kredensial asli.
.gitignore	Mengatur berkas sensitif atau sementara agar tidak masuk ke repositori, seperti .env, backup SQL, dan data pasien asli.
Struktur Basis Data Utama
Tabel/Objek	Fungsi
kategori_triase_enum	Menentukan nilai kategori triase: Merah, Kuning, Hijau, atau Hitam.
pendaftaran	Menyimpan ID kunjungan, nomor rekam medis, NIK pseudonim, dan waktu kedatangan.
triase_igd	Menyimpan kategori triase, keluhan utama, tanda vital, dan hubungan dengan data pendaftaran.
Foreign key fk_triase_pendaftaran	Menghubungkan catatan triase dengan catatan pendaftaran yang bersangkutan.
Check constraints	Memastikan nilai klinis memiliki batas atau rentang yang valid.
3. SOP Keamanan Data Pasien bagi Tim Pengembang
Gunakan data pseudonim atau sintetis

Jangan menggunakan NIK, nomor rekam medis, nama, alamat, atau data riwayat medis pasien asli dalam pengujian. Gunakan data anonim, pseudonim, atau data sintetis yang tidak dapat digunakan untuk mengidentifikasi pasien.

Jangan menyimpan rahasia dalam kode atau versi Git

Kredensial basis data, API key, sertifikat, dan isi berkas .env tidak boleh ditulis langsung dalam sumber kode atau dimasukkan ke commit. Gunakan variabel lingkungan, sekret aman, dan pembatasan akses repository.

Terapkan kontrol akses dan hak minimum

Hanya petugas berwenang yang boleh mengakses data pasien. Pengembang harus memiliki hak akses minimum sesuai kebutuhan, termasuk membatasi akses ke lingkungan produksi dan prosedur ekspor data.

Gunakan enkripsi dan audit akses

Data pasien harus dilindungi saat disimpan dan dikirim, misalnya dengan TLS untuk komunikasi dan enkripsi pada basis data atau penyimpanan cadangan. Catat akses dan perubahan data penting untuk keperluan audit dan investigasi insiden.

Hapus atau amankan data uji serta cadangan

Berkas backup, unggahan, log, dan data uji yang mengandung informasi pasien harus dienkripsi, dibatasi penyimpanannya, dan dihapus sesuai jadwal retensi. Berkas seperti *.sql.bak dan data_pasien_asli* tidak boleh diteruskan ke repository publik.

SOP ini merupakan standar pengembangan dan belum menggantikan kebijakan privasi, regulasi kesehatan, prosedur rumah sakit, atau persetujuan pasien yang berlaku.
