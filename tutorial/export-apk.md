项目已创建完成。目录结构如下：

```
android-app/
├── build.gradle
├── settings.gradle
├── gradle.properties
├── gradlew.bat
├── gradle/wrapper/gradle-wrapper.properties
└── app/
    ├── build.gradle
    ├── proguard-rules.pro
    └── src/main/
        ├── AndroidManifest.xml
        ├── java/com/citywings/game/MainActivity.java
        ├── assets/index.html (游戏文件)
        └── res/
            ├── layout/activity_main.xml
            ├── drawable/ic_launcher.xml
            ├── values/styles.xml
            └── values/strings.xml
```

---

## 打包APK教程（3种方法）

### 方法一：Android Studio（推荐，最简单）

**1. 安装Android Studio**
- 下载地址：https://developer.android.com/studio
- 安装时勾选 "Android SDK"、"Android Virtual Device"

**2. 打开项目**
- 启动 Android Studio
- 点击 `File → Open`
- 选择 `D:\AI-misc\FlappyPlane\android-app` 文件夹
- 点击 OK，等待 Gradle 同步完成（首次需要下载依赖）

**3. 运行到手机/模拟器**
- 手机开启 USB调试（设置→关于手机→连续点击版本号7次→开发者选项→USB调试）
- 用USB连接电脑
- 点击 Android Studio 顶部的绿色运行按钮 ▶
- 选择你的手机设备

**4. 打包Release APK**
- 点击 `Build → Generate Signed Bundle / APK`
- 选择 `APK`，点击 Next
- 如果没有密钥库，点击 `Create new` 创建：
  - Key store path: 选择一个位置保存 `.jks` 文件
  - 填写密码、别名、有效期等
- 选择 `release` 构建类型
- 点击 Finish，等待构建完成
- APK 文件位置：`android-app\app\release\app-release.apk`

---

### 方法二：命令行打包（无Android Studio）

**1. 安装JDK 17**
- 下载地址：https://adoptium.net/
- 安装后设置环境变量 `JAVA_HOME`

**2. 安装Android SDK Command-line Tools**
- 下载地址：https://developer.android.com/studio#command-tools
- 解压后设置 `ANDROID_HOME` 环境变量

**3. 构建APK**

```powershell
cd D:\AI-misc\FlappyPlane\android-app
.\gradlew.bat assembleRelease
```

APK 生成在：`app\build\outputs\apk\release\app-release.apk`

---

### 方法三：在线打包（最简单，无需安装）

使用 [Website 2 APK Builder](https://www.website2apkbuilder.com/) 或 [GoNative.io](https://gonative.io/)：

1. 将 `android-app\app\src\main\assets\index.html` 作为入口文件
2. 上传项目或填写本地文件路径
3. 设置应用名称为 "都市飞翼"
4. 下载生成的APK

---

**注意事项：**
- 游戏已经支持触屏操作（`touchstart` 事件），手机上可以直接玩
- 屏幕方向已锁定为竖屏（portrait）
- 如果要在应用商店发布，需要创建正式签名密钥，且版本号（versionCode）需要递增
- 打包前建议先清理测试历史数据（避免本地缓存和历史最高分被带入验收）：

```powershell
# 1) 清空设备中已安装的测试数据（推荐）
adb shell pm clear com.citywings.game

# 2) 如果你改过应用ID或遇到异常，直接卸载再安装
adb uninstall com.citywings.game

# 3) 重新安装新打包的 APK
adb install -r app\build\outputs\apk\release\app-release.apk
```

- 本项目 `MainActivity` 已在启动时自动清理 WebView 的缓存、DOM Storage 和 Cookie，减少测试残留数据干扰