# 🔧 Setup Firebase untuk Android

## ✅ Status Anda Sekarang:

- ✅ Register app di Firebase Console dengan package name: `com.example.flutter_movieapp`
- ✅ Download `google-services.json`
- ✅ File `google-services.json` sudah ditempatkan di `android/app/`

## 📋 Langkah-langkah yang Sudah Dilakukan:

### 1. ✅ Register Android App di Firebase Console
```
Package name: com.example.flutter_movieapp
```

### 2. ✅ Download google-services.json
Lokasi: `android/app/google-services.json` ✓

### 3. ✅ Update Root-level `build.gradle.kts`

Sudah ditambahkan di file `android/build.gradle.kts`:

```kotlin
plugins {
    // Add the dependency for the Google services Gradle plugin
    id("com.google.gms.google-services") version "4.4.4" apply false
}
```

### 4. ✅ Update App-level `build.gradle.kts`

Sudah ditambahkan di file `android/app/build.gradle.kts`:

```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    // Add the Google services plugin (must be after Flutter plugin)
    id("com.google.gms.google-services")
}
```

### 5. ✅ Tambah Firebase Dependencies

Sudah ditambahkan di file `android/app/build.gradle.kts`:

```kotlin
dependencies {
    // Import the Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:34.5.0"))

    // Add the dependency for the Firebase Authentication library
    implementation("com.google.firebase:firebase-auth")

    // Add the dependencies for any other Firebase products you want to use
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-messaging")
}
```

## 🚀 Langkah Berikutnya:

### Step 1: Update Firebase Config File

File `lib/config/firebase_config.dart` sudah siap dengan Android configuration:

```dart
class FirebaseConfig {
  static FirebaseOptions getOptions() {
    if (kIsWeb) {
      return FirebaseOptions(
        apiKey: "YOUR_WEB_API_KEY",
        appId: "YOUR_WEB_APP_ID",
        messagingSenderId: "YOUR_WEB_MESSAGING_SENDER_ID",
        projectId: "YOUR_PROJECT_ID",
        authDomain: "YOUR_AUTH_DOMAIN",
        databaseURL: "YOUR_DATABASE_URL",
        storageBucket: "YOUR_STORAGE_BUCKET",
      );
    } else if (GetPlatform.isAndroid) {
      // Android akan otomatis menggunakan google-services.json
      // Pastikan gradle configuration sudah benar
      return FirebaseOptions(
        apiKey: "AIzaSyCCy_9VQuwVG0EUONCAaSlst4qimlDsptE",
        appId: "1:761253598752:android:b634bbacf4cc14e0548e45",
        messagingSenderId: "761253598752",
        projectId: "movie-app-uts",
      );
    }
    // ... iOS config ...
  }
}
```

### Step 2: Clean dan Rebuild

```bash
cd android
# Clean gradle cache
./gradlew clean

# Back to project root
cd ..

# Clean Flutter build
flutter clean

# Get dependencies
flutter pub get

# Run on Android
flutter run -d android
```

Atau langsung:

```bash
flutter clean
flutter pub get
flutter run
```

### Step 3: Konfigurasi Firebase Console

1. Buka **Firebase Console**: https://console.firebase.google.com/
2. Pilih project: **movie-app-uts**
3. Go to **Authentication** → **Sign-in method**
4. Enable:
   - ✅ Google (untuk Google Sign In)
   - ✅ Email/Password (untuk Email login)

### Step 4: Test di Android

```bash
# Untuk device/emulator Android
flutter run -d android

# Atau specific device
flutter run -d <device_id>
```

## 📊 Checklist:

- [x] Register app di Firebase Console
- [x] Download google-services.json
- [x] Tempatkan google-services.json di android/app/
- [x] Update root build.gradle.kts dengan plugin
- [x] Update app build.gradle.kts dengan plugin dan dependencies
- [ ] Update FirebaseConfig dengan credentials dari google-services.json
- [ ] Enable Google Sign In di Firebase Console
- [ ] Clean dan rebuild project
- [ ] Test di Android emulator/device

## 🔍 Verifikasi Setup:

Cek apakah gradle configuration benar:

```bash
cd android
./gradlew app:dependencies
```

Harus include Firebase libraries:
```
com.google.firebase:firebase-auth
com.google.firebase:firebase-messaging
com.google.firebase:firebase-analytics
```

## 🚨 Troubleshooting:

### Error: "Plugin with id 'com.google.gms.google-services' not found"
- Pastikan plugin sudah ditambah di root `build.gradle.kts`
- Run: `flutter clean && flutter pub get`

### Error: "Configuration 'implementation' not found"
- Pastikan `google-services.json` ada di `android/app/`
- Update app `build.gradle.kts` dengan benar

### Error saat flutter run
```bash
# Clean semua
flutter clean
flutter pub get

# Rebuild
flutter run
```

### Android Emulator tidak ada?
```bash
# List available devices
flutter devices

# Atau gunakan Android Studio untuk buat emulator baru
```

## 📝 Important Notes:

1. **google-services.json** sudah berada di lokasi yang benar
2. **Gradle configuration** sudah diupdate sesuai Firebase requirements
3. **Dependencies** sudah ditambahkan dengan Firebase BoM (version management otomatis)
4. **Android package name** cocok dengan Firebase registration: `com.example.flutter_movieapp`

## 🎯 Next Steps:

1. Pastikan semua files sudah update (check di editor)
2. Run: `flutter clean && flutter pub get`
3. Test di Android emulator: `flutter run`
4. Jika ada error, check logcat untuk detail

---

**Setelah ini Anda siap test Firebase authentication di Android!** 🎉

