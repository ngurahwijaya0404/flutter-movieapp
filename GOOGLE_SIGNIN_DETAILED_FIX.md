# 📚 COMPLETE GUIDE: Fix Google Sign In Error 401 invalid_client

## Problem Analysis

Anda mendapatkan error "Error 401: invalid_client" karena:

1. **Client ID masih placeholder** (`YOUR_GOOGLE_CLIENT_ID`) di:
   - `web/index.html` meta tag
   - `lib/providers/auth_provider.dart` GoogleSignIn initialization

2. **Android SHA-1 fingerprint belum registered** di Firebase
   - Required untuk Google Sign In authentication

3. **Authorized domains belum configured** di Google Cloud

---

## Solution Overview

```
Step 1: Get Android SHA-1 fingerprint
   ↓
Step 2: Register SHA-1 in Firebase Console
   ↓
Step 3: Get Google Client ID from Firebase/Google Cloud
   ↓
Step 4: Update web/index.html with real Client ID
   ↓
Step 5: Update auth_provider.dart with real Client ID
   ↓
Step 6: Configure Authorized Redirect URIs
   ↓
Step 7 (Optional): Setup OAuth Consent Screen
   ↓
Step 8: Clean & Rebuild
   ↓
TEST ✓
```

---

## DETAILED STEPS

### STEP 1: Get Android SHA-1 Fingerprint

**Why:** Android uses certificate fingerprint for security. Firebase needs to know your certificate.

**How:**

Open terminal and run:

```bash
cd c:\Users\Pongo\Downloads\latihanflutter\flutter_movieapp\android
```

Then run:

```bash
./gradlew signingReport
```

**Wait for output:**

```
Variant: debug
Config: debug
Store: C:\Users\...\.android\debug.keystore
Alias: AndroidDebugKey
MD5: ...
SHA1: AA:BB:CC:DD:EE:FF:00:11:22:33:44:55:66:77:88:99:AA:BB:CC:DD
SHA256: ...
```

**⭐ Copy the SHA1 value** (format: `AA:BB:CC:DD:...`)

---

### STEP 2: Register SHA-1 in Firebase Console

**Why:** Firebase needs to know this is your app's certificate.

**How:**

1. Open: https://console.firebase.google.com/
2. **Select project:** movie-app-uts
3. Click **⚙️ Project Settings** (gear icon, top right)
4. Tab: **Your apps**
5. Find Android app: `com.example.flutter_movieapp`
6. Click to expand
7. Scroll down to **SHA certificate fingerprints**
8. Click **Add fingerprint**
9. **Paste your SHA1** (from Step 1)
10. Click **Save**

**Verify:** You should see green checkmark next to SHA1

---

### STEP 3: Get Google Client ID

**Why:** This ID is needed to authenticate users with Google.

**Method A: From Firebase Console (EASIEST)**

1. Firebase Console → **Authentication**
2. Tab: **Sign-in method**
3. Provider: **Google** (click to expand)
4. Look for **Web SDK configuration** section
5. Copy **Web Client ID**
   - Format: `123456789-abcdefghijk1234567890ab.apps.googleusercontent.com`

**Method B: From Google Cloud Console**

1. Open: https://console.cloud.google.com/
2. **Select project:** movie-app-uts
3. Left sidebar: **APIs & Services** → **Credentials**
4. Find "Web client" in **Application type** column
5. Click the row to open details
6. Copy **Client ID**

**⭐ SAVE THIS CLIENT ID** - You need it twice!

---

### STEP 4: Update web/index.html

**File:** `c:\Users\Pongo\Downloads\latihanflutter\flutter_movieapp\web\index.html`

**Find (around line 38):**

```html
<meta name="google-signin-client_id" content="YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com">
```

**Replace with:**

```html
<meta name="google-signin-client_id" content="123456789-abcdefghijk1234567890ab.apps.googleusercontent.com">
```

⚠️ **Important:** 
- Replace `YOUR_GOOGLE_CLIENT_ID` with YOUR ACTUAL Client ID
- Keep `.apps.googleusercontent.com` part
- Don't add extra spaces

---

### STEP 5: Update lib/providers/auth_provider.dart

**File:** `c:\Users\Pongo\Downloads\latihanflutter\flutter_movieapp\lib\providers\auth_provider.dart`

**Find method** `_initializeGoogleSignIn()` **(around line 15-25):**

```dart
void _initializeGoogleSignIn() {
  if (kIsWeb) {
    _googleSignIn = GoogleSignIn(
      clientId: "YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com",
    );
```

**Replace with:**

```dart
void _initializeGoogleSignIn() {
  if (kIsWeb) {
    _googleSignIn = GoogleSignIn(
      clientId: "123456789-abcdefghijk1234567890ab.apps.googleusercontent.com",
    );
```

⚠️ **Important:**
- Same Client ID as Step 4!
- If not same, authentication will fail
- Double-check for typos

---

### STEP 6: Configure Authorized Redirect URIs

**Why:** Google needs to know which URLs are allowed to use this Client ID.

**How:**

1. Google Cloud Console → **APIs & Services** → **Credentials**
2. Click your **Web client** credentials
3. Section: **Authorized redirect URIs**
4. Click **Add URI**
5. Add these values (one by one):
   ```
   http://localhost:7077
   http://localhost:8080
   http://localhost:3000
   ```
6. Click **Save**

**Note:** `localhost:7077` is default Flutter web port. If you see different port in `flutter run` output, use that port instead.

---

### STEP 7 (OPTIONAL): Setup OAuth Consent Screen

**Why:** If you get "Access blocked: Authorization Error", you need this.

**How:**

1. Google Cloud Console → **APIs & Services** → **OAuth consent screen**
2. **User Type:** Select **External**
3. Click **Create**
4. **App name:** "Flutter Movie App"
5. **User support email:** your@email.com
6. Click **Save and Continue**
7. **Scopes** → **Add or remove scopes**
   - Add: `https://www.googleapis.com/auth/userinfo.email`
   - Add: `https://www.googleapis.com/auth/userinfo.profile`
   - Click **Update**
8. Click **Save and Continue**
9. **Test users** → **Add users**
   - Add your Google account email
10. Click **Save and Continue**

**Status:** Consent screen is now in "Development" mode (OK for testing)

---

### STEP 8: Clean & Rebuild

```bash
cd c:\Users\Pongo\Downloads\latihanflutter\flutter_movieapp

flutter clean
flutter pub get

# Test on Web:
flutter run -d chrome

# Test on Android:
flutter run
```

---

## VERIFICATION CHECKLIST

Before testing, verify:

```
Firebase:
  ✓ Android app registered with: com.example.flutter_movieapp
  ✓ SHA-1 fingerprint added to Firebase
  ✓ Google provider enabled in Authentication

Google Cloud:
  ✓ OAuth 2.0 Web Application created
  ✓ Client ID obtained
  ✓ Authorized redirect URIs: localhost:7077, 8080
  ✓ OAuth consent screen setup (if needed)

Code:
  ✓ web/index.html: Client ID NOT placeholder
  ✓ auth_provider.dart: Client ID NOT placeholder
  ✓ Both files have SAME Client ID
  ✓ No extra spaces or typos
  ✓ flutter clean executed
  ✓ flutter pub get executed
```

---

## TESTING

### Test on Web:

```bash
flutter run -d chrome
```

1. Wait for app to load
2. Skip onboarding (or complete it)
3. Go to Login Screen
4. Click **"Sign in with Google"**
5. Google popup should open
6. Login with your test account
7. Should redirect to Home screen

### Expected Console Output:

```
Starting Google Sign In...
✓ Firebase ready for authentication
Google user signed in: your.email@gmail.com
Got authentication tokens
Creating Firebase credential...
Successfully signed in: your.email@gmail.com
```

---

## TROUBLESHOOTING

### Problem: "Error 401: invalid_client"

**Cause:** Client ID is invalid or not registered

**Solution:**
- Verify Client ID format: `123456789-abc...apps.googleusercontent.com`
- Check both files have SAME Client ID
- No placeholder text remaining
- No extra spaces

---

### Problem: "The OAuth client was not found"

**Cause:** Client ID not created or registered

**Solution:**
- Create OAuth 2.0 Web Application in Google Cloud Console
- Copy Client ID correctly
- Update both files

---

### Problem: "Redirect URI mismatch"

**Cause:** localhost port not authorized

**Solution:**
- Check port from `flutter run -d chrome` output
- Add that port to Authorized URIs
- Example: `http://localhost:7077`

---

### Problem: "Access blocked: Authorization Error"

**Cause:** OAuth consent screen not setup

**Solution:**
- Complete Step 7 above
- Add your email to test users
- If still blocked: try incognito mode

---

### Problem: "popup_closed"

**Cause:** User closed popup OR Client ID error

**Solution:**
- If popup doesn't open: Client ID error (see above)
- If popup opens but user closes: Normal (let user try again)

---

### Problem: No popup at all

**Cause:** Client ID still placeholder

**Solution:**
- Check web/index.html: Is meta tag value still "YOUR_GOOGLE_CLIENT_ID"?
- If YES: Update it!
- If NO: Browser cache issue
  - Try incognito/private mode
  - Or clear browser cache

---

## DEBUG TIPS

### Check Web Console:

1. Open app in Chrome
2. Press **F12** (DevTools)
3. Tab: **Console**
4. Look for error messages
5. Should see:
   ```
   Starting Google Sign In...
   ✓ Firebase ready for authentication
   ```

### Check Network:

1. DevTools → Tab: **Network**
2. Reload page
3. Look for failed requests
4. Check for CORS errors
5. Verify Firebase SDK loading

### Test Different Port:

If `flutter run -d chrome` uses different port:

1. Note the port (e.g., `localhost:8090`)
2. Add to Authorized URIs in Google Cloud
3. Try again

---

## SECURITY NOTES

⚠️ **NEVER commit real credentials to public GitHub!**

For production, use environment variables:

```dart
String clientId = String.fromEnvironment(
  'GOOGLE_CLIENT_ID',
  defaultValue: 'dev-client.apps.googleusercontent.com'
);

if (kIsWeb) {
  _googleSignIn = GoogleSignIn(clientId: clientId);
}
```

Run with:
```bash
flutter run -d chrome --dart-define=GOOGLE_CLIENT_ID="123456789-abc...apps.googleusercontent.com"
```

---

## SUMMARY

| Step | Action | Time |
|------|--------|------|
| 1 | Get Android SHA-1 | 2 min |
| 2 | Register in Firebase | 2 min |
| 3 | Get Client ID | 2 min |
| 4 | Update web/index.html | 1 min |
| 5 | Update auth_provider.dart | 1 min |
| 6 | Configure Authorized URIs | 2 min |
| 7 | Setup Consent Screen (optional) | 5 min |
| 8 | Clean & test | 5 min |
| **TOTAL** | | **20 min** |

---

## Quick Links

- Firebase Console: https://console.firebase.google.com/
- Google Cloud Console: https://console.cloud.google.com/
- Google Sign In Web Guide: https://developers.google.com/identity/gsi/web

---

**Follow all steps carefully and Google Sign In should work!** ✅

If still stuck, compare with GOOGLE_SIGNIN_QUICK_FIX.md for simplified version.
