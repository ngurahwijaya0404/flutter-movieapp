# 🔑 Setup Google Sign In Client ID

## ❌ Error yang Muncul:
```
ClientID not set. Either set it on a <meta name="google-signin-client_id" content="CLIENT_ID" /> tag, 
or pass clientId when initializing GoogleSignIn
```

## 🔍 Penyebab:
Google Sign In memerlukan **Client ID** yang harus dikonfigurasi di:
1. `web/index.html` - sebagai meta tag
2. `lib/providers/auth_provider.dart` - sebagai parameter GoogleSignIn

## ✅ Solusi: Setup Google OAuth Client ID

### **Step 1: Buka Firebase Console**

1. Go to: https://console.firebase.google.com/
2. Select project "flutter-movieapp"
3. Click **Authentication** di sidebar
4. Click tab **Sign-in method**
5. Find **Google** dan click enable
6. Fill in OAuth consent screen (jika diminta):
   - App name: "Flutter Movie App"
   - User support email: your@email.com
   - Developer contact: your@email.com
7. Save and continue

### **Step 2: Get Google Client ID**

**Method A: Dari Firebase Console**

1. Di Firebase Console, klik **Authentication**
2. Klik tab **Sign-in method**
3. Klik **Google** provider
4. Scroll ke bawah, cari **Web SDK configuration**
5. Copy **Web client ID** (format: `123456789-abc...apps.googleusercontent.com`)

**Method B: Dari Google Cloud Console**

1. Go to: https://console.cloud.google.com/
2. Select project "flutter-movieapp"
3. Left sidebar → APIs & Services → Credentials
4. Find "Web client" di Application type
5. Copy **Client ID**

### **Step 3: Update Configuration Files**

#### **File 1: `web/index.html`**

Find line dengan:
```html
<meta name="google-signin-client_id" content="YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com">
```

Replace `YOUR_GOOGLE_CLIENT_ID` dengan nilai asli:
```html
<meta name="google-signin-client_id" content="123456789-abcdefg.apps.googleusercontent.com">
```

#### **File 2: `lib/providers/auth_provider.dart`**

Find line:
```dart
clientId: "YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com",
```

Replace dengan nilai asli:
```dart
clientId: "123456789-abcdefg.apps.googleusercontent.com",
```

### **Step 4: Add Authorized Redirect URIs**

1. Di Google Cloud Console → APIs & Services → Credentials
2. Click Web client yang sudah dibuat
3. Bawah, di "Authorized redirect URIs", tambahkan:
   - `http://localhost:7077` (Flutter web dev server)
   - `http://localhost:8080` (Alternative port)
   - `http://localhost:3000`
   - Domain production (jika ada)

4. Click **Save**

### **Step 5: Test**

```bash
flutter clean
flutter pub get
flutter run -d chrome
```

**Expected output:**
```
GoogleSignIn initialized for web with clientId
✓ Firebase ready for authentication
Google user signed in: user@gmail.com
Successfully signed in: user@gmail.com
```

## 📋 Checklist:

- [ ] Firebase project "flutter-movieapp" dibuat
- [ ] Google Sign-In provider sudah enabled di Firebase Console
- [ ] Client ID sudah di-copy dari Firebase/Google Cloud Console
- [ ] `web/index.html` sudah updated dengan Client ID
- [ ] `lib/providers/auth_provider.dart` sudah updated dengan Client ID
- [ ] Authorized redirect URIs sudah ditambahkan di Google Cloud Console
- [ ] `localhost:7077` (atau port yang dipakai) sudah di-authorize

## 🔗 Links:

- **Firebase Console**: https://console.firebase.google.com/
- **Google Cloud Console**: https://console.cloud.google.com/

## 🚨 Important Notes:

⚠️ **Never commit real Client ID ke GitHub public repo!**

Untuk production, gunakan Environment Variables:

```dart
// lib/providers/auth_provider.dart
String clientId = String.fromEnvironment(
  'GOOGLE_CLIENT_ID',
  defaultValue: 'YOUR_DEFAULT_CLIENT_ID.apps.googleusercontent.com'
);

_googleSignIn = GoogleSignIn(clientId: clientId);
```

Run dengan:
```bash
flutter run -d chrome --dart-define=GOOGLE_CLIENT_ID="your_client_id_here"
```

## 🔧 Troubleshooting:

### "Invalid Client ID"
- Check Client ID format: should end with `.apps.googleusercontent.com`
- Verify Client ID is from correct project

### "Redirect URI mismatch"
- Add `localhost:7077` to Authorized redirect URIs
- Check exact port Flutter dev server is using
- Some redirects use `http://localhost/auth/callback`

### "popup_closed_by_user"
- This is normal - user cancelled the login
- Check browser console for other errors

### Still not working?
1. Clear browser cache (Incognito mode)
2. Check console logs (Chrome DevTools F12)
3. Verify all credentials in both files match exactly
4. Try different port if 7077 is blocked

---

**After updating all files, try again:** 🎉

```bash
flutter clean
flutter pub get
flutter run -d chrome
```

Login should work now!
