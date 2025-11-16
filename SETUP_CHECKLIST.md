# ✅ Firebase Setup Checklist

## Platform: Web (Chrome) - RECOMMENDED ✅

### Prerequisites:
- [ ] Flutter SDK installed
- [ ] Chrome browser installed

### Setup Steps:
```bash
cd c:\Users\Pongo\Downloads\latihanflutter\flutter_movieapp

# 1. Clean build
flutter clean

# 2. Get dependencies
flutter pub get

# 3. Run on Chrome
flutter run -d chrome
```

### Expected Output:
```
✓ Firebase initialized successfully
✓ FCM initialized successfully
Launching lib\main.dart on Chrome...
```

### Testing:
- [ ] Splash screen tampil dengan status loading
- [ ] Onboarding page 1 tampil
- [ ] Onboarding page 2 tampil
- [ ] Onboarding page 3 tampil
- [ ] Tombol "Lanjut" works
- [ ] Tombol "Mulai" works (TANPA error merah)
- [ ] Login screen tampil
- [ ] "Sign in with Google" button visible

---

## Platform: Windows Desktop

### Prerequisites:
- [ ] Windows 10/11
- [ ] Developer Mode enabled
- [ ] Flutter SDK installed

### Enable Developer Mode:
```
Windows Settings
  → Update & Security
    → For developers
      → Enable Developer Mode
```

### Setup Steps:
```bash
cd c:\Users\Pongo\Downloads\latihanflutter\flutter_movieapp

# 1. Clean build
flutter clean

# 2. Get dependencies
flutter pub get

# 3. Run on Windows
flutter run -d windows
```

### Expected Output:
```
✓ Firebase initialized successfully
✓ FCM initialized successfully
Launching lib\main.dart on Windows...
```

### Testing:
(Same as Web)

---

## Platform: Android Emulator/Device

### Prerequisites:
- [ ] Android SDK installed
- [ ] Emulator running or device connected
- [ ] google-services.json in android/app/

### Setup Steps:
```bash
cd c:\Users\Pongo\Downloads\latihanflutter\flutter_movieapp

# 1. Clean build
flutter clean

# 2. Get dependencies
flutter pub get

# 3. List devices
flutter devices

# 4. Run on Android
flutter run -d <device-id>
```

---

## Troubleshooting

### Error: "No Firebase App"
- [ ] Check console: `✓ Firebase initialized successfully` appears?
- [ ] If not, app may be crashing during init
- [ ] Check `lib/main.dart` - Firebase init di `void main()` sebelum `runApp()`

### Error: "Symlink error" (Windows Desktop)
- [ ] Enable Developer Mode di Windows Settings
- [ ] Run PowerShell as Administrator
- [ ] Try again

### Error: "network/unknown-error"
- [ ] Check internet connection
- [ ] Firebase SDK CDN in `web/index.html` is loaded
- [ ] Try clearing browser cache

### Blank/White Screen
- [ ] Check console logs (Ctrl+J di Chrome)
- [ ] Look for `✗ Error initializing` messages
- [ ] Check DevTools for JavaScript errors

### Red Screen Error
- [ ] This means error handler kicked in (designed behavior)
- [ ] Check console for what caused the error
- [ ] Click "Kembali ke Awal" button to recover

---

## Console Logging Guide

### Look for these messages:
```
✓ Firebase initialized successfully  ← GOOD
✓ FCM initialized successfully      ← GOOD
✗ Error initializing Firebase: ...  ← BAD - Firebase config issue
✗ Error initializing FCM: ...       ← OK - Not critical
```

### If something is wrong, check:
1. Console tab di DevTools (F12)
2. Network tab - Firebase SDK loading?
3. Application tab - Is localStorage working?

---

## Files to Verify

- [ ] `lib/main.dart` - Has Firebase init
- [ ] `lib/services/firebase_service.dart` - Exists
- [ ] `lib/providers/auth_provider.dart` - Has Firebase check
- [ ] `web/index.html` - Has Firebase SDK links
- [ ] `android/app/google-services.json` - Exists (if Android)

---

## Status Indicators

| Indicator | Meaning |
|-----------|---------|
| `✓` | Success |
| `✗` | Error (but app continues) |
| `⚠` | Warning |
| `📊` | Info |

---

**Last Updated**: November 2025
**Version**: 1.0
