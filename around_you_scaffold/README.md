# ARound You Scaffold

This folder contains copy-paste ready files to bring a bright, vibrant, world-class theme and MVP features into your existing Flutter app.

## How to use

1) Copy lib files
- Copy the `lib/` folder contents into your app's `lib/` (merge folders). If asked to overwrite, review and accept where appropriate.

2) Add dependencies
- Replace your `pubspec.yaml` with the one in this folder or merge the dependencies manually.
- Run:
  - `flutter pub get`

3) Environment
- Copy `.env` to your project root and set values:
  - `SUPABASE_URL=https://YOUR-PROJECT.supabase.co`
  - `SUPABASE_ANON_KEY=YOUR_PUBLIC_ANON_KEY`
  - `AR_TEST_GLB_URL=https://YOUR-PUBLIC-ASSET.glb`

4) Firebase
- Put `google-services.json` into `android/app/`.
- Ensure Firebase is enabled for Authentication and Firestore.

5) Android settings
- Open `snippets/android/` and copy:
  - `build.gradle` (project) into `android/build.gradle` (merge classpaths)
  - `app/build.gradle` into `android/app/build.gradle` (merge minSdk, Java 17, apply google-services)
  - `AndroidManifest.xml` into `android/app/src/main/AndroidManifest.xml` (merge permissions)

6) Assets
- Create buckets in Supabase: `ar_assets` (public). The code uses it for images and audio.
- Put a small `.glb` test model at a public URL and set `AR_TEST_GLB_URL`.

7) Run
- `flutter clean`
- `flutter pub get`
- `flutter run`

## Structure
- `lib/theme/app_theme.dart` vibrant Material 3 theme (dark-first, non-white surfaces, bright accents)
- `lib/providers/providers.dart` Riverpod providers
- `lib/services/*` Firebase Auth, Geolocator, Supabase Storage, Firestore Memories with geo
- `lib/models/*` UserProfile, Memory
- `lib/ui/screens/*` Auth, Home with tabs (AR, Around, Memories, Chat, Profile), Create Memory flow
- `snippets/android/*` Android build and manifest examples to merge

## Notes
- Replace placeholder ownerUid in `CreateMemoryScreen` with `FirebaseAuth.instance.currentUser!.uid` after Auth flow is fully wired.
- Ensure each memory document includes both `position` (GeoFlutterFire field) and `isPublic` for geo queries.
- Theme uses Poppins; adjust palette in `app_theme.dart` if desired.
- iOS requires Info.plist camera/location usage descriptions and ARKit capability.