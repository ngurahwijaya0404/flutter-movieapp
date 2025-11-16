## Solusi Error "[core/no-app] No Firebase App"

### Penyebab Error:
Error ini terjadi karena Firebase belum diinisialisasi sebelum aplikasi mencoba mengaksesnya, terutama saat berpindah dari Onboarding ke Login Screen.

### Solusi yang Sudah Diterapkan:

#### 1. **Firebase Service Wrapper** (`lib/services/firebase_service.dart`)
- Membuat layer abstraksi untuk Firebase initialization
- Memastikan Firebase hanya diinisialisasi sekali
- Menangani error dengan graceful

#### 2. **Updated Main.dart** 
- Menggunakan `FirebaseService.initialize()` sebelum menjalankan app
- Menambahkan global error handler untuk menampilkan error lebih baik
- Error handling untuk FCM initialization agar tidak critical

#### 3. **Enhanced Auth Provider** (`lib/providers/auth_provider.dart`)
- Menambahkan `_firebaseReady` flag untuk tracking status
- Lazy initialization untuk FirebaseAuth
- Check sebelum mengakses Firebase methods

#### 4. **Firebase Messaging Service** 
- Menambahkan check apakah Firebase sudah initialized
- Graceful error handling

#### 5. **Web Support** (`web/index.html`)
- Menambahkan Firebase SDK untuk web platform

### Instruksi Setup untuk Web Platform:

Jika masih mengalami error saat menjalankan di web:

```bash
# 1. Bersihkan build
flutter clean

# 2. Perbarui dependencies
flutter pub get

# 3. Run di web dengan debug
flutter run -d chrome
```

### Instruksi Setup untuk Windows Desktop:

```bash
# 1. Aktifkan Developer Mode di Windows
# Settings > Update & Security > For developers > Enable Developer Mode

# 2. Bersihkan build
flutter clean

# 3. Run di Windows
flutter run -d windows
```

### Testing Flow:

1. ✅ Splash Screen tampil
2. ✅ Onboarding page 1, 2, 3 tampil
3. ✅ Tombol "Mulai" - tidak crash (Firebase sudah siap)
4. ✅ Login Screen tampil
5. ✅ Tombol "Sign in with Google" - siap untuk login

Jika masih ada error, periksa console (Ctrl+J di Chrome) untuk melihat error message detail.
