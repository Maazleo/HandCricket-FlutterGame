# 🏏 Hand Cricket Game

A modern, feature-rich hand cricket game built with Flutter. Play against the computer, customize your team, track your stats, and relive the classic hand cricket experience on your device!

---

![Flutter](https://img.shields.io/badge/Flutter-3.9.0-blue?logo=flutter)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux-blue)

## 📸 LiveDemo

> _Add screenshots of your app here!_
> 
> ![Home Screen](docs/screenshots/home.png)
> ![Game Screen](docs/screenshots/game.png)

---

## 🎮 Features

- **Single Match & Tournament Modes**
- **Customizable Overs** (5, 10, 20)
- **Toss & Play Choice** (Bat/Bowl)
- **Team Customization**: Name, player names, roles, captain, wicket-keeper
- **TV-style Scoreboard** & Real-time Stats
- **Celebrations**: Fours, Sixes, 50s, 100s, Hat-tricks
- **Player & Team Stats**: Runs, wickets, balls, strike rate
- **Match Results & History**
- **Modern UI** with custom themes and Google Fonts
- **Persistent Team Profile** (saved locally)

---

## 🕹️ Gameplay & Rules

- Choose overs and match type (single/tournament)
- Toss to decide who bats/bowls first
- Each turn, pick a number (0-6) as your shot/bowl
- If your number matches the computer's, it's a wicket!
- Score as many runs as possible before losing all wickets or overs
- Two innings: Bat and bowl, then chase or defend the target
- Win, lose, or tie based on runs and wickets

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK 3.9.0+](https://docs.flutter.dev/get-started/install)
- Dart 3.9+
- Android Studio / Xcode / VS Code (recommended)

### Installation
```bash
# Clone the repository
git clone https://github.com/yourusername/hand_cricket_game.git
cd hand_cricket_game

# Get dependencies
flutter pub get
```

### Running the App
```bash
# For Android/iOSlutter run

# For Web
flutter run -d chrome

# For Windows/macOS/Linux
flutter run -d windows  # or macos/linux
```

### Building Release
```bash
flutter build apk      # Android
flutter build ios      # iOS
flutter build web      # Web
flutter build windows  # Windows
flutter build macos    # macOS
flutter build linux    # Linux
```

### Testing
```bash
flutter test
```

---

## 🗂️ Project Structure

```
lib/
  core/         # Theme, constants
  models/       # Data models (Player, Match, Score, Settings)
  screens/      # UI screens (Home, Game, Toss, Result, Stats, Team Profile)
  widgets/      # Reusable widgets
  data/         # (Future: data sources)
  services/     # (Future: services)
main.dart       # App entry point
```

---

## 🧑‍💻 Customization
- Go to **Team Profile** to set your team name, player names, roles, captain, and wicket-keeper.
- Your team profile is saved locally and used in every match.

---

## 📦 Dependencies
- [Flutter](https://flutter.dev/) (3.9.0+)
- [google_fonts](https://pub.dev/packages/google_fonts)
- [shared_preferences](https://pub.dev/packages/shared_preferences)
- [cupertino_icons](https://pub.dev/packages/cupertino_icons)

_See `pubspec.yaml` for the full list._

---

## 🧹 Code Quality
- Linting: [flutter_lints](https://pub.dev/packages/flutter_lints)
- Run `flutter analyze` to check for issues.

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a Pull Request

---

## 📄 License

_This project currently does **not** have a license. Add a LICENSE file to specify usage rights._

---

## 🙏 Credits
- Inspired by classic hand cricket games
- Built with Flutter by [Your Name](https://github.com/yourusername)

---

> _Made with ❤️ for cricket fans!_
