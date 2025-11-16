# ⚠️ PENTING: Konfigurasi Firebase Credentials

## ❌ Error yang Terjadi:
```
FirebaseOptions cannot be null when creating the default app.
options != null
```

## 🔍 Penyebab:
Firebase web memerlukan **Firebase Options** (API key, project ID, auth domain, dll) yang harus dikonfigurasi di `lib/config/firebase_config.dart`.

## ✅ Solusi: Dapatkan Firebase Credentials

### Step 1: Buka Firebase Console
1. Go to: https://console.firebase.google.com/
2. Login dengan Google account
3. Klik project "flutter-movieapp" (atau buat baru jika belum ada)

### Step 2: Get Web Configuration
1. Di Firebase Console, klik **⚙️ Settings** (gear icon)
2. Klik **Project Settings**
3. Scroll ke section "Your apps"
4. Cari app dengan platform **Web** (atau tambah baru jika belum ada)
5. Klik **Config** untuk menampilkan code snippet
6. Copy konfigurasi yang mirip seperti ini:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyD...",
  authDomain: "flutter-movieapp.firebaseapp.com",
  projectId: "flutter-movieapp",
  storageBucket: "flutter-movieapp.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abcdef..."
};
```

### Step 3: Update `lib/config/firebase_config.dart`

Ganti placeholder dengan credentials asli Anda:

```dart
static FirebaseOptions getOptions() {
  if (kIsWeb) {
    return FirebaseOptions(
      apiKey: "AIzaSyD...",  // ← Copy dari Firebase Console
      appId: "1:123456789:web:abcdef...",  // ← Copy dari Firebase Console
      messagingSenderId: "123456789",  // ← Copy dari Firebase Console
      projectId: "flutter-movieapp",  // ← Copy dari Firebase Console
      authDomain: "flutter-movieapp.firebaseapp.com",  // ← Copy dari Firebase Console
      databaseURL: "https://flutter-movieapp.firebaseio.com",  // ← Auto-generated
      storageBucket: "flutter-movieapp.appspot.com",  // ← Copy dari Firebase Console
    );
  }
  // ... rest of code
}
```

### Step 4: Setup Google Sign In

1. Di Firebase Console, buka **Authentication**
2. Klik tab **Sign-in method**
3. Enable **Google** provider
4. Set authorized domains (harus include localhost untuk testing)

### Step 5: Test

```bash
flutter clean
flutter pub get
flutter run -d chrome
```

**Expected output:**
```
✓ Firebase service initialized successfully
Firebase apps count: 1
Default app name: [DEFAULT]
=== Firebase Initialization Complete ===
```

## 📋 Checklist:

- [ ] Firebase project dibuat di console.firebase.google.com
- [ ] Web app sudah ditambahkan ke project
- [ ] Credentials sudah di-copy ke `lib/config/firebase_config.dart`
- [ ] Google Sign-In provider sudah di-enable di Firebase Console
- [ ] Localhost sudah di-whitelist sebagai authorized domain

## 🚨 Important Notes:

⚠️ **JANGAN** share Firebase credentials di GitHub public repo!

Untuk production, gunakan Environment Variables:
```dart
final apiKey = String.fromEnvironment('FIREBASE_API_KEY');
```

Jalankan dengan:
```bash
flutter run -d chrome --dart-define=FIREBASE_API_KEY="your_key_here"
```

## 🔗 Firebase Console Link:
https://console.firebase.google.com/

## 📞 Jika Masih Error:

1. **Check console logs** (Chrome F12)
   - Cari "Firebase service initialized"
   - Jika tidak ada, Firebase init gagal

2. **Verify credentials**
   - Pastikan apiKey, appId, projectId benar
   - Copy paste langsung dari Firebase Console

3. **Check network**
   - Firebase SDK harus bisa di-load dari CDN
   - Check Network tab di DevTools

4. **Test di incognito mode**
   - Clear cache/cookies
   - Some issues related to cached configs

---

**After updating credentials, try again:** 🎉
```bash
flutter clean
flutter pub get
flutter run -d chrome
```
