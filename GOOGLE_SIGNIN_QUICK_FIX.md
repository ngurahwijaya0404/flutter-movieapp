# 🔴 URGENT FIX: Google Sign In Error 401 invalid_client

## ❌ Error Yang Muncul:
```
Google login error: popup_closed
Sign in failed: popup_closed
Access blocked: Authorization Error
The OAuth client was not found.
Error 401: invalid_client
```

## 🔍 Penyebab:

Client ID Anda masih **PLACEHOLDER** di dua tempat:
- `web/index.html` - masih `YOUR_GOOGLE_CLIENT_ID`
- `lib/providers/auth_provider.dart` - masih `YOUR_GOOGLE_CLIENT_ID`

---

## ✅ QUICK FIX (5 STEPS):

### **Step 1: Get Android SHA-1**

```bash
cd android
./gradlew signingReport
```

Output:
```
SHA1: AA:BB:CC:DD:EE:FF:...
```
**Copy SHA1 value** ⭐

---

### **Step 2: Add SHA-1 to Firebase**

1. https://console.firebase.google.com/
2. Project: **movie-app-uts**
3. **Project Settings** (gear icon) → **Your apps** → Android app
4. Scroll to **SHA certificate fingerprints** → **Add fingerprint**
5. Paste SHA1 → **Save**

✅ Done

---

### **Step 3: Get Client ID**

**Firebase Console:**
1. **Authentication** → **Sign-in method**
2. Click **Google**
3. Copy **Web Client ID** from SDK configuration
   - Format: `123456789-abcdefg.apps.googleusercontent.com`

**OR Google Cloud Console:**
1. https://console.cloud.google.com/
2. **APIs & Services** → **Credentials**
3. Find "Web client" → copy **Client ID**

**Save this value** ⭐

---

### **Step 4: Update 2 Files**

**File 1: `web/index.html` (line ~38)**

**FIND:**
```html
<meta name="google-signin-client_id" content="YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com">
```

**REPLACE WITH:**
```html
<meta name="google-signin-client_id" content="123456789-abcdefg.apps.googleusercontent.com">
```

---

**File 2: `lib/providers/auth_provider.dart` (line ~18)**

**FIND:**
```dart
_googleSignIn = GoogleSignIn(
  clientId: "YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com",
);
```

**REPLACE WITH:**
```dart
_googleSignIn = GoogleSignIn(
  clientId: "123456789-abcdefg.apps.googleusercontent.com",
);
```

---

### **Step 5: Add Authorized URIs**

Google Cloud Console:
1. **APIs & Services** → **Credentials**
2. Click Web client credentials
3. **Authorized redirect URIs** → **Add URI**
4. Add:
   ```
   http://localhost:7077
   http://localhost:8080
   ```
5. **Save**

---

### **Step 6: Clean & Run**

```bash
flutter clean
flutter pub get
flutter run -d chrome
```

✅ Should work now!

---

## ⚠️ IF STILL ERROR:

### Error: "Access blocked"
→ Setup OAuth consent screen in Google Cloud Console

### Error: popup won't open
→ Make sure localhost:7077 is in Authorized URIs

### Error: "Invalid client"
→ Check Client ID is EXACTLY same in both files (no extra spaces)

---

## 🔐 IMPORTANT:

**NEVER commit real credentials to GitHub!**

Use environment variables instead (see full guide).

---

**That's it! Try testing now!** 🚀
