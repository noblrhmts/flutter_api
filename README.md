**NAMA: NOBEL RAHMAT SANI**

**NIM: 362358302075**

**KELAS: 2A TRPL**


Hasil Akhir:

![11](https://github.com/user-attachments/assets/158ca96f-b99a-4663-a4ce-5e6ddd945c47)

![22](https://github.com/user-attachments/assets/37580269-58a9-46ab-b36d-ed391112a45d)

![33](https://github.com/user-attachments/assets/353a920a-5878-4716-a869-450fed31a57a)


Penjelasan:

Aplikasi ini mengambil data cuaca dari API OpenWeatherMap untuk menampilkan informasi cuaca di beberapa kota di Jawa Timur. 


- Struktur Aplikasi
  
Aplikasi ini terdiri dari dua file utama:

1. api_service.dart – Berfungsi untuk mengambil data cuaca dari API.

2. main.dart – Berisi tampilan antarmuka pengguna dan logika aplikasi.

- Penjelasan Kode

A. api_service.dart

File ini berfungsi untuk mengambil data cuaca dari API OpenWeatherMap. Berikut penjelasan bagian-bagiannya:

1. Kelas ApiService:
   
   Kelas ini memiliki dua metode utama untuk mengambil data cuaca:
   
   - fetchWeather: Mengambil data cuaca berdasarkan nama kota.
  
   - fetchMultipleCitiesWeather: Mengambil data cuaca untuk beberapa kota sekaligus.

2. Variabel String _apiKey:
   
   - Ini adalah kunci API yang digunakan untuk mengakses data cuaca dari OpenWeatherMap.
     
3. Metode fetchWeather:
   
   - Metode ini mengambil data cuaca untuk satu kota yang dimasukkan dan mengembalikannya dalam bentuk data JSON.
  
   - Jika berhasil, data cuaca akan dikembalikan. Jika gagal, akan ada pesan error.

4. Metode fetchMultipleCitiesWeather:

   - Metode ini mengambil cuaca untuk beberapa kota yang ada di dalam list cities. Data cuaca untuk setiap kota disimpan dalam sebuah list dan dikembalikan.

  
B. main.dart

File ini berfungsi untuk menampilkan tampilan aplikasi dan interaksi dengan pengguna. Berikut penjelasannya:

1. Widget WeatherApp:

   - Ini adalah widget utama yang menjalankan aplikasi dan menampilkan layar pertama, yaitu HomeScreen.
  
2. Widget HomeScreen (StatefulWidget):

   - HomeScreen berfungsi untuk menampilkan cuaca dari beberapa kota di Jawa Timur dan memungkinkan pengguna untuk mencari cuaca berdasarkan kota.
  
   - Ada beberapa elemen di dalamnya:
  
     - TextField: Untuk memasukkan nama kota.
    
     - ElevatedButton: Untuk memulai pencarian berdasarkan kota yang dimasukkan.
    
     - ListView: Menampilkan daftar cuaca untuk kota-kota yang diambil dari API.
    
     - CircularProgressIndicator: Ditampilkan ketika data cuaca sedang dimuat.
    
3. State Variables:

   - cities: Daftar kota yang cuacanya akan ditampilkan di halaman utama.
  
   - weatherData: Menyimpan data cuaca untuk beberapa kota setelah diambil dari API.
  
   - searchedWeather: Menyimpan data cuaca untuk kota yang dicari oleh pengguna.
  
   - isLoading: Menunjukkan apakah aplikasi sedang memuat data cuaca.
  
   - isSearching: Menunjukkan apakah pencarian cuaca sedang dilakukan.
  
4. Metode fetchWeatherData:

   - Mengambil data cuaca dari beberapa kota di list cities dan menyimpan hasilnya di weatherData.
  
   - Menangani error jika terjadi masalah saat mengambil data dan menampilkan pesan kesalahan.
  
5. Metode searchWeather:

   - Digunakan untuk mencari cuaca berdasarkan kota yang dimasukkan di TextField.
  
   - Jika pencarian berhasil, cuaca kota yang dicari akan ditampilkan. Jika gagal, aplikasi akan memberi pesan kesalahan.
  
6. Widget DetailScreen:

   - Ketika pengguna mengetuk salah satu kota dalam daftar, aplikasi akan menampilkan detail cuaca untuk kota tersebut di halaman baru.
  
   - Di halaman detail ini, pengguna bisa melihat informasi lebih lengkap seperti suhu, kondisi cuaca, kelembapan, dan kecepatan angin.
  
7. Icon Cuaca:

   - Metode getWeatherIcon selalu mengembalikan ikon awan (Icons.cloud), meskipun cuaca di kota tersebut bisa berbeda. Anda bisa mengganti logika ini nanti agar menampilkan ikon yang lebih sesuai dengan cuaca.
  
8. Desain UI:

   - Aplikasi menggunakan warna biru muda untuk header dengan teks putih dan tebal.
  
   - Latar belakang halaman utama dan halaman detail berwarna putih.
  
   - Tampilan aplikasi disusun menggunakan Column dan Row untuk memudahkan tata letak.

9. StatefulWidget:

    - Aplikasi menggunakan StatefulWidget untuk memperbarui UI saat data cuaca dimuat atau saat pencarian dilakukan.
  
10. Handling Error:

    - Jika ada kesalahan saat mengambil data, aplikasi akan menampilkan pesan kesalahan menggunakan SnackBar.
