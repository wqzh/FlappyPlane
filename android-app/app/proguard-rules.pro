# WebView related rules
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Keep game data
-keepclassmembers class * {
    public *;
}
