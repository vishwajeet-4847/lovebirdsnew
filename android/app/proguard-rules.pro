# Flutter
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**

# Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Kotlin coroutines and stdlib
-keep class kotlinx.coroutines.** { *; }
-dontwarn kotlinx.coroutines.**

# CameraX or other plugins
-keep class androidx.camera.** { *; }
-dontwarn androidx.camera.**

# Gson or serialization (if needed)
-keepattributes *Annotation*
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**


