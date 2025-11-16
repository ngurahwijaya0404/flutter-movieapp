# 🌐 WEB FIREBASE SETUP - NEXT STEPS

Setelah setup Android selesai dan testing berhasil, berikut langkah untuk setup Web:

---

## 📋 WEB SETUP CHECKLIST:

### ✅ Sudah Siap (from Android setup):
- [x] `lib/services/firebase_service.dart` - Created
- [x] `lib/config/firebase_config.dart` - Created (with placeholders)
- [x] `lib/providers/auth_provider.dart` - Created (with platform detection)
- [x] `web/index.html` - Updated (with Firebase SDK)
- [x] `lib/main.dart` - Updated (with error handling)

### ⏳ Masih Perlu Dikerjakan:

1. **Firebase Web Credentials**
   - [ ] Dapatkan dari Firebase Console
   - [ ] Update `lib/config/firebase_config.dart`

2. **Google OAuth Client ID**
   - [ ] Dapatkan dari Google Cloud Console
   - [ ] Update `web/index.html`
   - [ ] Update `lib/providers/auth_provider.dart`

3. **Authorized Domains**
   - [ ] Add localhost:7077 di Firebase Console

---

## 🔑 STEP 1: GET FIREBASE WEB CREDENTIALS

### 1A. Open Firebase Console
- Go to: https://console.firebase.google.com/
- Select project: **movie-app-uts**

### 1B. Register Web App

1. Click **Add app** button
2. Select **Web** icon
3. Enter app name: "Flutter Movie App"
4. Click **Register app**

### 1C. Copy Web Configuration

Setelah register, Anda akan lihat configuration seperti:

```javascript
// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSy...",
  authDomain: "movie-app-uts.firebaseapp.com",
  projectId: "movie-app-uts",
  storageBucket: "movie-app-uts.firebasestorage.app",
  messagingSenderId: "761253598752",
  appId: "1:761253598752:web:..."
};
```

**Copy ini ke somewhere aman (text editor)**

### 1D. Continue dan Copy SDK

Firebase akan show:
```html
<!-- The core Firebase JS SDK is always required and must be listed first -->
<script src="https://www.gstatic.com/firebasejs/9.8.1/firebase-app-compat.js"></script>
...
```

Ini sudah ada di `web/index.html`, so no action needed.

---

## 🔧 STEP 2: UPDATE FIREBASE CONFIG FILE

Open file: `lib/config/firebase_config.dart`

Find the Web section:

```dart
if (kIsWeb) {
  return FirebaseOptions(
    apiKey: "AIzaSy...",  // ← REPLACE dengan value dari firebase
    appId: "1:...:web:...", // ← REPLACE
    messagingSenderId: "761253598752",
    projectId: "movie-app-uts",
    authDomain: "movie-app-uts.firebaseapp.com",
    databaseURL: "https://movie-app-uts.firebasedatabase.app",
    storageBucket: "movie-app-uts.firebasestorage.app",
  );
}
```

**Copy-paste values dari Firebase Web config:**
- apiKey ← dari firebaseConfig.apiKey
- appId ← dari firebaseConfig.appId
- messagingSenderId ← sudah ada: 761253598752
- projectId ← sudah ada: movie-app-uts
- authDomain ← dari firebaseConfig.authDomain
- storageBucket ← dari firebaseConfig.storageBucket

**Example:**
```dart
return FirebaseOptions(
  apiKey: "AIzaSyDOCAbC123...",
  appId: "1:761253598752:web:abc123def456",
  messagingSenderId: "761253598752",
  projectId: "movie-app-uts",
  authDomain: "movie-app-uts.firebaseapp.com",
  databaseURL: "https://movie-app-uts.firebasedatabase.app",
  storageBucket: "movie-app-uts.firebasestorage.app",
);
```

---

## 🔑 STEP 3: GET GOOGLE CLIENT ID

### 3A. Open Google Cloud Console
- Go to: https://console.cloud.google.com/
- Select project: **movie-app-uts** (or link Firebase project)

### 3B. Create OAuth 2.0 Credentials

1. Left sidebar → **APIs & Services** → **Credentials**
2. Click **Create Credentials** → **OAuth client ID**
3. Select: **Web application**
4. Name: "Flutter Movie App Web"
5. Add Authorized redirect URIs:
   - `http://localhost:7077`
   - `http://localhost:8080`
   - `http://localhost:3000`
6. Click **Create**

### 3C. Copy Client ID

Dialog akan show Client ID:
```
123456789-abcdefg.apps.googleusercontent.com
```

**Copy dan save ini**

---

## 🔧 STEP 4: UPDATE WEB HTML FILE

Open file: `web/index.html`

Find line dengan meta tag:
```html
<meta name="google-signin-client_id" content="YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com">
```

Replace `YOUR_GOOGLE_CLIENT_ID` dengan Client ID dari step 3:
```html
<meta name="google-signin-client_id" content="123456789-abcdefg.apps.googleusercontent.com">
```

**Example:**
```html
<meta name="google-signin-client_id" content="123456789-abcdefg.apps.googleusercontent.com">
```

---

## 🔧 STEP 5: UPDATE AUTH PROVIDER

Open file: `lib/providers/auth_provider.dart`

Find `_initializeGoogleSignIn()` method:

```dart
void _initializeGoogleSignIn() {
  if (kIsWeb) {
    _googleSignIn = GoogleSignIn(
      clientId: "YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com",
    );
  } else {
    _googleSignIn = GoogleSignIn();
  }
}
```

Replace `YOUR_GOOGLE_CLIENT_ID` dengan Client ID dari step 3:
```dart
_googleSignIn = GoogleSignIn(
  clientId: "123456789-abcdefg.apps.googleusercontent.com",
);
```

---

## 🔐 STEP 6: ENABLE GOOGLE SIGN-IN IN FIREBASE

1. Open Firebase Console
2. Go to **Authentication** → **Sign-in method**
3. Find **Google** provider
4. Click **Enable**
5. Select OAuth consent screen (or create if not exists)
6. Add Web Client ID dari Google Cloud Console
7. Click **Save**

---

## ✅ STEP 7: ADD LOCALHOST TO AUTHORIZED DOMAINS

1. Firebase Console → **Authentication** → **Settings**
2. Scroll ke **Authorized domains**
3. Click **Add domain**
4. Add:
   - `localhost:7077`
   - `localhost:8080`
5. Save

---

## 🚀 TEST WEB

Setelah semua update:

```bash
flutter clean
flutter pub get
flutter run -d chrome
```

### Expected Output:
```
✓ Firebase initialized successfully
✓ Google Sign In initialized for web with clientId
Launching lib/main.dart on Chrome...
```

### Testing Checklist:
- [ ] Splash screen muncul
- [ ] Onboarding tampil (jika first time)
- [ ] Login screen tampil
- [ ] "Sign in with Google" button visible
- [ ] Klik button → Google login popup appears
- [ ] Login berhasil → Redirect ke Home
- [ ] Movie list tampil
- [ ] Tidak ada error

---

## 🐛 TROUBLESHOOTING WEB:

### Error: "ClientID not set"
- Pastikan `web/index.html` meta tag updated
- Pastikan `lib/providers/auth_provider.dart` clientId updated
- Try clearing browser cache (Ctrl+Shift+Delete)

### Error: "Redirect URI mismatch"
- Add `localhost:7077` ke Google Cloud Console Authorized redirect URIs
- Check exact port Flutter is using: `flutter run -d chrome` will show
- Add that port to authorized URIs

### Error: "Invalid API key"
- Pastikan Firebase Web credentials updated di `lib/config/firebase_config.dart`
- Pastikan apiKey match dengan Firebase Console Web app config

### Blank/White Screen
- Open DevTools (F12)
- Check Console tab untuk errors
- Look for Firebase initialization messages

### Google popup tidak muncul
- Check browser console untuk errors
- Verify Google Sign In SDK is loaded (check Network tab di DevTools)

---

## 📊 WEB SETUP SUMMARY:

```
Requirements:
  ├─ Firebase Web Config ← dari Firebase Console
  ├─ Google Client ID ← dari Google Cloud Console
  ├─ Authorized Domains ← di Firebase Console
  └─ OAuth Consent Screen ← di Google Cloud

Files to Update:
  ├─ lib/config/firebase_config.dart ← Firebase Web Config
  ├─ web/index.html ← Google Client ID
  ├─ lib/providers/auth_provider.dart ← Google Client ID
  └─ Firebase Console Settings ← Enable providers
```

---

## 🔄 COMPLETE FLOW FOR WEB:

```
1. Register Web app di Firebase
   ↓
2. Copy Firebase Web config
   ↓
3. Update lib/config/firebase_config.dart
   ↓
4. Get Google Client ID dari Google Cloud Console
   ↓
5. Update web/index.html meta tag
   ↓
6. Update lib/providers/auth_provider.dart
   ↓
7. Enable Google provider di Firebase
   ↓
8. Add localhost to authorized domains
   ↓
9. flutter run -d chrome
   ↓
10. Test complete auth flow
```

---

## ⏱️ TIME ESTIMATE:

- Get credentials: 5-10 minutes
- Update files: 5 minutes
- Test: 5 minutes
- **Total: 15-25 minutes**

---

**Ready untuk Web setup?** Start with Step 1! 🚀

Generated: 2025-11-16
