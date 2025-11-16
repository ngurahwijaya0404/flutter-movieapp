# 📋 ANDROID FIREBASE SETUP - LANGKAH DEMI LANGKAH

## ✅ APA YANG SUDAH ANDA SELESAIKAN:

```
✅ Step 1: Register app di Firebase Console
   Package: com.example.flutter_movieapp
   Project: movie-app-uts

✅ Step 2: Download google-services.json
   File tersimpan di: android/app/google-services.json

✅ Step 3: Update android/build.gradle.kts
   ✓ Plugin Google Services ditambahkan
   ✓ Version: 4.4.4
   
✅ Step 4: Update android/app/build.gradle.kts
   ✓ Plugin diterapkan ke app module
   ✓ Firebase BoM 34.5.0 ditambahkan
   ✓ Semua Firebase dependencies ditambahkan:
     - firebase-auth
     - firebase-analytics
     - firebase-messaging

✅ Step 5: flutter clean & flutter pub get
   ✓ Build cache dihapus
   ✓ Dependencies didownload
```

---

## 📋 GRADLE FILES - SUDAH DIUPDATE:

### File 1: `android/build.gradle.kts` ✅

```kotlin
plugins {
    // Add the dependency for the Google services Gradle plugin
    id("com.google.gms.google-services") version "4.4.4" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ... rest of config
```

**Status: ✅ CORRECT**

---

### File 2: `android/app/build.gradle.kts` ✅

```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    // Add the Google services plugin (must be after Flutter plugin)
    id("com.google.gms.google-services")
}

android {
    // ... Android configuration
}

flutter {
    source = "../.."
}

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

**Status: ✅ CORRECT**

---

### File 3: `android/app/google-services.json` ✅

```json
{
  "project_info": {
    "project_number": "761253598752",
    "project_id": "movie-app-uts",
    "storage_bucket": "movie-app-uts.firebasestorage.app"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "1:761253598752:android:b634bbacf4cc14e0548e45",
        "android_client_info": {
          "package_name": "com.example.flutter_movieapp"
        }
      },
      // ... rest of config
    }
  ]
}
```

**Status: ✅ DOWNLOADED & PLACED CORRECTLY**

---

## 🚀 LANGKAH BERIKUTNYA - TESTING:

### Option A: Test dengan Android Emulator (Recommended)

```bash
# 1. Buka Android Studio / Android Emulator
# 2. Run di terminal:

cd c:\Users\Pongo\Downloads\latihanflutter\flutter_movieapp

flutter clean
flutter pub get
flutter run
```

### Option B: Test dengan Android Device

```bash
# 1. Hubungkan Android phone ke PC
# 2. Enable USB Debugging di phone
# 3. Run di terminal:

cd c:\Users\Pongo\Downloads\latihanflutter\flutter_movieapp

flutter devices  # Lihat device yang terdeteksi

flutter run -d <device_id>
```

---

## ✅ EXPECTED RESULTS SAAT RUNNING:

### Console Output:

```
✓ Build successful
✓ Firebase initialized successfully
✓ FCM initialized (atau FCM initialization skipped jika ada warning)
Launching lib/main.dart on Android...
```

### Aplikasi akan menampilkan:

1. **Splash Screen** (3-5 detik)
   - Status: "Initializing..."
   - Loading indicator

2. **Onboarding Screen** (jika first time)
   - Page 1: Welcome
   - Page 2: Features
   - Page 3: Get Started

3. **Login Screen**
   - Google Sign In button
   - Tombol lainnya

4. **Tidak ada error merah** ✅

---

## ⚠️ JIKA ADA ERROR:

### Error 1: "Gradle build failed"

**Solusi:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Error 2: "Plugin com.google.gms.google-services not found"

**Check:**
- Pastikan `android/build.gradle.kts` memiliki plugin di section `plugins { }`
- Bukan di `dependencies { }`

**Benar:**
```kotlin
plugins {
    id("com.google.gms.google-services") version "4.4.4" apply false
}
```

**Salah:**
```kotlin
dependencies {
    classpath("com.google.gms:google-services:4.4.4")  // ❌ Salah tempat
}
```

### Error 3: "google-services.json not found"

**Check:**
- File ada di: `android/app/google-services.json` ✓
- Nama file exact: `google-services.json` (lowercase)
- Bukan di folder lain

### Error 4: "Blank/White Screen"

**Kemungkinan:**
1. Firebase initialization belum selesai (wait 5-10 detik)
2. Ada error Firebase saat init

**Solution:**
- Check logcat: `adb logcat | findstr Firebase`
- Check console di Chrome DevTools (jika web)

### Error 5: "Red error screen"

**Kemungkinan:**
1. Global error handler triggered (normal behavior)
2. Ada error saat initialization

**Solution:**
1. Lihat message di error screen
2. Klik tombol "Kembali ke Awal" untuk recover
3. Check console untuk detail

---

## 🔍 TROUBLESHOOTING CHECKLIST:

- [ ] Semua file gradle benar? (check dengan text editor)
- [ ] google-services.json ada? (check file explorer)
- [ ] Package name match? (`com.example.flutter_movieapp`)
- [ ] Flutter clean sudah dijalankan?
- [ ] Dependencies sudah didownload? (`flutter pub get`)
- [ ] Emulator/device sudah aktif? (`flutter devices`)
- [ ] Internet connection aktif? (Firebase perlu internet)

---

## 📱 DEVICE SETUP (JIKA PAKAI PHYSICAL DEVICE):

1. **Connect via USB:**
   ```bash
   adb devices
   ```
   Harus menampilkan device ID

2. **Enable USB Debugging di Phone:**
   - Settings → About Phone → Tap "Build Number" 7x
   - Go back → Developer Options
   - Enable "USB Debugging"
   - Allow USB Debugging permission saat ditanya

3. **Run:**
   ```bash
   flutter run
   ```

---

## 📊 STATUS SUMMARY:

```
ANDROID FIREBASE SETUP:    ✅ 100% COMPLETE
  ├─ Firebase Console     ✅ DONE
  ├─ google-services.json ✅ DONE
  ├─ Gradle Config        ✅ DONE
  ├─ Dependencies         ✅ DONE
  └─ Ready to Test        ✅ YES

NEXT PLATFORM:
  ├─ Web (Chrome)         ⏳ PENDING
  └─ iOS                  ⏳ PENDING
```

---

## 🎯 NEXT AFTER TEST:

### Jika Android Test Berhasil ✅
→ Lanjut ke Web Setup (butuh Google Client ID)

### Jika Android Test Gagal ❌
→ Check troubleshooting section di atas

### Jika Tidak Ada Android Device
→ Bisa test di Web dengan: `flutter run -d chrome`

---

## 📚 DOKUMENTASI LAINNYA:

- `ANDROID_FIREBASE_SETUP.md` - Setup detail
- `GOOGLE_SIGNIN_SETUP.md` - Google OAuth setup
- `FIREBASE_SETUP.md` - General Firebase

---

## 🎉 SIAP UNTUK TEST?

**Jalankan command ini:**

```bash
flutter run
```

**Atau untuk Chrome:**

```bash
flutter run -d chrome
```

---

**Status:** ✅ READY TO TEST

**Next:** Run app dan report hasilnya!

Generated: 2025-11-16
