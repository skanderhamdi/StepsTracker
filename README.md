# StepsTracker
StepsTracker

<img src="https://i.ibb.co/TkCj0bH/logo-white.png" alt="Proposed logo" width="100" height="100"/>
  
- [x] Users could be authenticated anonymously, no need to take a phone number or email. Upon first installation the app should ask for their name and image.
- [x] The application should track the user footsteps and update them in real-time, meaning while the app is in the foreground, and the user walks around, they should be able to see the steps counter increasing.
- [x] For each number of footsteps taken, a function must run to exchange it to “Health Points”, e.g., 100 footsteps = 1 Health Point.
- [x] There should be a history that lists all the exchanges that happened by date and time.
- [x] Show a visual feedback (e.g., Snack bar) when users gain extra points.
- [x] There should be a catalog of rewards so users can pick a reward they like and redeem it. Each reward is linked to one partner (e.g., 10% off on Digital Watches from Xiaomi).
- [x] Rewards are paid with health points, feedback should be given upon all cases: if the redemption can happen, show a confirmation dialog, if it cannot due to a low number of points, show an error message stating clearly what’s wrong.
- [x] There is a leaderboard page where the user can see their ranking (how many steps they have made since installing the app) compared to all other users, to encourage them to walk more.
- [x] If the application is in background, or turned off, the exchange will happen while they are walking, and a notification would be sent from the app telling them that they gained extra points.
- [x] The app is multilingual, supports both Arabic and English.

- [x] Usable and user-friendly interface.
- [x] Use a proper architecture for the code, UI code must not include any DB queries or business logic.
- [x] Use clear models for data.
- [x] Dark mode.

## Software requirements
- [x] The app is working on Android and iOS


## Notes
- The application has been tested on **Emulator** and **Redmi Note 10** as real device.
- The application has been tested on **Simulator (iPhone 8 & iPhone 12 Pro Max iOS 14.4)** and **iPhone X iOS 14.4** as real device.
- **google-services.json** & **GoogleServicesInfo.plist** are included in the project.

```
flutter doctor
```
### output:

```
[✓] Flutter (Channel master, 2.3.0-17.0.pre.327, on macOS 11.4 20F71 darwin-x64, locale en-DZ)
[!] Android toolchain - develop for Android devices (Android SDK version 29.0.3)
    ✗ cmdline-tools component is missing
      Run `path/to/sdkmanager --install "cmdline-tools;latest"`
      See https://developer.android.com/studio/command-line for more details.
    ✗ Android license status unknown.
      Run `flutter doctor --android-licenses` to accept the SDK licenses.
      See https://flutter.dev/docs/get-started/install/macos#android-setup for more details.
[✓] Xcode - develop for iOS and macOS
[✓] Chrome - develop for the web
[✓] Android Studio (version 3.5)
[✓] IntelliJ IDEA Community Edition (version 2021.1)
[✓] VS Code (version 1.51.1)
[✓] Connected device (2 available)
```
