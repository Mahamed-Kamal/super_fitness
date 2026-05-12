# 💪 Super Fitness

> A comprehensive AI-powered fitness companion app built with Flutter — featuring personalized workout plans, nutrition tracking, an AI chat assistant, and Clean Architecture with BLoC state management.

[![Flutter](https://img.shields.io/badge/Flutter-3.10%2B-blue?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10%2B-blue?logo=dart&logoColor=white)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Clean%20Architecture-✓-success)](#-architecture)
[![State Management](https://img.shields.io/badge/BLoC-orange)](#-packages-used)
[![AI Powered](https://img.shields.io/badge/Gemini%20AI-4285F4?logo=google&logoColor=white)](#-packages-used)
[![CI/CD](https://img.shields.io/badge/GitHub%20Actions-CI%2FCD-2088FF?logo=githubactions&logoColor=white)](#-cicd)

---

## 📖 Description

**Super Fitness** is a production-ready Flutter health and fitness application designed to be a complete personal wellness companion. It guides users through a personalized onboarding flow to capture their gender, age, height, weight, activity level, and fitness goal — then delivers tailored workout and nutrition content. The app features an integrated **AI chat assistant** powered by Google Gemini for fitness advice, **YouTube-embedded exercise tutorials**, real-time food nutrition details, and profile management with photo upload support. Built on Clean Architecture with a Feature-First structure for maximum scalability and testability.

---

## ✨ Features

- **Personalized Onboarding** — Multi-step setup flow capturing gender, age, height, weight, activity level, and fitness goal to tailor the experience.
- **User Authentication** — Secure registration, login, and OTP-based email verification with full password creation flow.
- **AI Fitness Chat** — An integrated AI assistant powered by Google Gemini (`google_generative_ai`) for personalized fitness advice, with full conversation history support.
- **Workout Plans** — Curated workout routines with embedded YouTube video tutorials for guided exercise.
- **Exercise Library** — Detailed exercise pages with instructions, reps, sets, and video demonstrations.
- **Nutrition Tracking** — Browse food items, view detailed nutritional breakdowns (calories, macros), and track daily intake.
- **Profile Management** — View and edit personal stats (weight, height, goal, activity level) with photo upload from camera or gallery.
- **Skeleton Loading** — Smooth skeleton placeholder UI while content loads for a polished user experience.
- **Localization Ready** — Architected for multi-language support via `easy_localization`.

---

## 📸 Screenshots

<div align="center">

### 🚀 Onboarding & Authentication

<table>
  <tr>
    <td align="center"><b>Splash</b></td>
    <td align="center"><b>Onboarding 1</b></td>
    <td align="center"><b>Onboarding 2</b></td>
    <td align="center"><b>Onboarding 3</b></td>
  </tr>
  <tr>
    <td><img width="180" src="https://github.com/user-attachments/assets/4ae899f9-41b4-46ba-ae74-06914dacd251" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/fb6b8520-5c00-467f-9130-a1903121e6bb" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/bb9d132a-fb46-4728-99bf-fc4d74a0bbf1" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/c5372ca2-28fa-408e-adbd-1cf8e74e8df9" /></td>
  </tr>
  <tr>
    <td align="center"><b>Register</b></td>
    <td align="center"><b>Create Password</b></td>
    <td align="center"><b>Create Password (Alt)</b></td>
    <td align="center"><b>Login</b></td>
  </tr>
  <tr>
    <td><img width="180" src="https://github.com/user-attachments/assets/f594db6a-4643-4b30-bde2-b7d905c654aa" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/882da052-c897-4f1c-a6ed-aba47b433ed3" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/7c1c02e4-0a37-47f0-af8e-296a0337c98f" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/be475c03-52d7-4a9d-8dd3-7f7d2a6bb2c6" /></td>
  </tr>
  <tr>
    <td align="center"><b>OTP</b></td>
    <td align="center"><b>OTP (Alt)</b></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td><img width="180" src="https://github.com/user-attachments/assets/23252467-d6c0-44a2-8714-89da5072ffab" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/f1c87152-800f-452a-8ac3-568856446ff0" /></td>
    <td></td>
    <td></td>
  </tr>
</table>

### 🧍 User Setup Flow

<table>
  <tr>
    <td align="center"><b>Select Gender</b></td>
    <td align="center"><b>Gender</b></td>
    <td align="center"><b>Age</b></td>
    <td align="center"><b>Height</b></td>
  </tr>
  <tr>
    <td><img width="180" src="https://github.com/user-attachments/assets/21908b50-53eb-4fc9-946e-a717d3c6f46f" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/0a4e407f-7def-4288-9917-36b0463fa41e" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/9abf0b22-1a56-4e8b-8917-4c8b71947dbc" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/a5fc3e17-176d-4212-a77d-e629daf82322" /></td>
  </tr>
  <tr>
    <td align="center"><b>Weight (KG)</b></td>
    <td align="center"><b>Goal</b></td>
    <td align="center"><b>Activity</b></td>
    <td></td>
  </tr>
  <tr>
    <td><img width="180" src="https://github.com/user-attachments/assets/0aa0acf6-66c3-492b-91cf-a4901ace6ed5" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/5c200663-58d4-4ea8-ad6b-f29e5dae11ca" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/1d142666-57b8-4d41-b9e6-499827eb1997" /></td>
    <td></td>
  </tr>
</table>

### 🏠 Core Experience

<table>
  <tr>
    <td align="center"><b>Home</b></td>
    <td align="center"><b>Workouts</b></td>
    <td align="center"><b>Workouts (Alt)</b></td>
    <td align="center"><b>Exercise</b></td>
  </tr>
  <tr>
    <td><img width="180" src="https://github.com/user-attachments/assets/ace90f7c-06b3-4476-ac2a-d79c20f778b6" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/e0b5c11a-a681-4ecd-83b3-a9bdb7631341" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/bef07556-7d31-43d9-83ba-cbbc88bdfbaa" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/b6fd0f27-6135-4658-ba31-26eb7677e490" /></td>
  </tr>
  <tr>
    <td align="center"><b>Food</b></td>
    <td align="center"><b>Food (Alt)</b></td>
    <td align="center"><b>Food Details</b></td>
    <td align="center"><b>Close</b></td>
  </tr>
  <tr>
    <td><img width="180" src="https://github.com/user-attachments/assets/23088e1d-f4ae-42fa-8abf-40ca94ee2877" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/4c9c15ef-7db1-4f14-b689-8850731dbfc9" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/78b1019f-af2b-4415-a1fb-9b86f697f99f" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/45cb3f0e-f088-4ba4-84de-291145b9a917" /></td>
  </tr>
</table>

### 🤖 AI Chat & Profile

<table>
  <tr>
    <td align="center"><b>Chat</b></td>
    <td align="center"><b>Chat (Conversation)</b></td>
    <td align="center"><b>Previous Conversations</b></td>
    <td align="center"><b>Profile</b></td>
  </tr>
  <tr>
    <td><img width="180" src="https://github.com/user-attachments/assets/b93f50be-c2b5-40b5-8dad-ec166df1f2b1" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/2d0e77e5-34a8-41f8-b089-85e10d99a502" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/a4a02f3d-0e9c-4443-b6dc-9167433386b4" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/5916bba8-4522-4f86-b811-e6f3ebc67b34" /></td>
  </tr>
  <tr>
    <td align="center"><b>Weight Edit</b></td>
    <td align="center"><b>Goal Edit</b></td>
    <td align="center"><b>Activity Edit</b></td>
    <td></td>
  </tr>
  <tr>
    <td><img width="180" src="https://github.com/user-attachments/assets/36cd7fb0-7a89-4d3e-a22b-f97174d744a4" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/85371d5d-6a56-421f-9a0d-369ed7236234" /></td>
    <td><img width="180" src="https://github.com/user-attachments/assets/d1c04cce-e24d-47aa-bc8c-7344e7bc7e10" /></td>
    <td></td>
  </tr>
</table>

</div>

---

## 🏛️ Architecture

The project follows **Clean Architecture** combined with a **Feature-First** directory layout, ensuring a strict separation of concerns, high testability, and easy scalability.

```
lib/
├── core/
│   ├── api/              # Dio client, Retrofit setup, interceptors
│   ├── di/               # Dependency injection (GetIt + Injectable)
│   ├── error/            # Custom failures and error handling
│   ├── helpers/          # Shared utilities and extensions
│   ├── local/            # Local storage (SharedPreferences, SecureStorage)
│   ├── routes/           # App routing logic
│   ├── theme/            # Colors, typography, and styling
│   └── widgets/          # Reusable shared UI components
│
└── features/
    ├── auth/             # Register, Login, OTP, Create Password
    ├── onboarding/       # Multi-step user setup (gender, age, goal…)
    ├── home/             # Home dashboard
    ├── workouts/         # Workout plans & exercise library
    ├── nutrition/        # Food browsing & nutrition details
    ├── chat/             # AI fitness assistant (Gemini)
    └── profile/          # User profile & stat editing
```

| Layer | Responsibility |
|---|---|
| **presentation** | UI — Screens, Widgets, BLoC/Cubit. Depends only on `domain`. |
| **domain** | Business logic — Entities, Use Cases, Repository interfaces. No framework dependencies. |
| **data** | Data — API calls, JSON models, repository implementations via Dio + Retrofit. |
| **core** | Shared infrastructure — DI, routing, theme, base classes, utilities. |

---

## 📦 Packages Used

### 🧠 State Management & Architecture
| Package | Purpose |
|---|---|
| `flutter_bloc` | BLoC / Cubit pattern state management |
| `get_it` | Service locator for dependency injection |
| `injectable` | Code-gen annotations for `get_it` wiring |
| `equatable` | Value equality for BLoC states and events |

### 🌐 Networking
| Package | Purpose |
|---|---|
| `dio` | Powerful HTTP client for API requests |
| `retrofit` | Type-safe REST API client generator |
| `pretty_dio_logger` | Human-readable HTTP request/response logging |
| `json_annotation` | JSON serialization annotations |

### 🔐 Security & Environment
| Package | Purpose |
|---|---|
| `flutter_secure_storage` | Encrypted storage for auth tokens |
| `shared_preferences` | Lightweight key-value local storage |
| `envied` | Secure environment variable management |

### 🤖 AI & Media
| Package | Purpose |
|---|---|
| `google_generative_ai` | Google Gemini AI for the in-app fitness chat assistant |
| `youtube_player_flutter` | Embedded YouTube video player for exercise tutorials |
| `webview_flutter` | In-app web view support |

### 🎨 UI & UX
| Package | Purpose |
|---|---|
| `flutter_svg` | SVG image rendering |
| `lottie` | Lottie animation playback |
| `cached_network_image` | Efficient network image caching |
| `skeletonizer` | Skeleton loading placeholder UI |
| `smooth_page_indicator` | Animated page indicator for onboarding |
| `pin_code_fields` | Customizable OTP / PIN input field |
| `numberpicker` | Scroll-wheel number picker (height, weight, age) |
| `google_fonts` | Google Fonts integration |
| `image_picker` | Pick profile photos from camera or gallery |
| `cupertino_icons` | iOS-style icon set |

### 🌍 Localization
| Package | Purpose |
|---|---|
| `easy_localization` | Multi-language support infrastructure |

### 🛠️ Code Generation (Dev)
| Package | Purpose |
|---|---|
| `build_runner` | Code generation runner |
| `injectable_generator` | Generates DI registration code |
| `retrofit_generator` | Generates Retrofit API client code |
| `json_serializable` | Generates `fromJson` / `toJson` methods |
| `envied_generator` | Generates secure env variable accessors |

### 🧪 Testing (Dev)
| Package | Purpose |
|---|---|
| `bloc_test` | Utilities for testing BLoC/Cubit |
| `mockito` | Mock objects for unit testing |
| `network_image_mock` | Mocks network images in widget tests |
| `flutter_lints` | Recommended Dart linting rules |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>= 3.10.4`
- Dart SDK `>= 3.10.4`
- A configured API backend
- A Google Gemini API key (for AI chat)

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/Mahamed-Kamal/super_fitness.git
cd super_fitness

# 2. Install dependencies
flutter pub get

# 3. Set up environment variables
#    Create your .env file(s) inside the /env directory
#    and configure your API base URL and Gemini API key

# 4. Run code generation (REQUIRED)
dart run build_runner build --delete-conflicting-outputs

# 5. Run the app
flutter run
```

> **Tip:** For active development, use `watch` mode to auto-regenerate files on save:
> ```bash
> dart run build_runner watch --delete-conflicting-outputs
> ```

---

## 🧪 Running Tests

```bash
flutter test
```

---

## ⚙️ CI/CD

This project uses **GitHub Actions** to automate development workflows:

| Workflow | Description |
|---|---|
| **Lint & Format** | Enforces consistent code style on every pull request |
| **Unit & Widget Tests** | Automatically runs all tests on each push to prevent regressions |
| **Branch & PR Validation** | Ensures branch names and PR titles follow the `type/scope` convention |

---

## 📱 Platform Support

| Platform | Supported |
|---|---|
| Android | ✅ |
| iOS | ✅ |

---

## 👥 Contributors
 
<div align="center">
 
A huge thank you to every developer who has poured their effort into this project! 🙏
 

<br/>
 
<table>
  <tr>
    <td align="center">
 <a href="https://github.com/Mahamed-Kamal">
        <img src="https://github.com/Mahamed-Kamal.png" width="90" style="border-radius:50%"/><br/>
        <sub><b>Mahamed Kamal</b></sub>
      </a>
      <br/>
      <sub>🏆 Flutter Developer </sub>
      <br/>
      <br/>
      <img src="https://img.shields.io/badge/Owner-FF6B6B?style=flat-square"/>
    </td>
    <td align="center">
       <a href="https://github.com/OmarWheed">
        <img src="https://github.com/OmarWheed.png" width="90" style="border-radius:50%"/><br/>
        <sub><b>Omar Wheed</b></sub>
      </a>
      <br/>
          <sub>🏆 Flutter Developer </sub>
      <br/>
      <br/>
      <img src="https://img.shields.io/badge/Contributor-4ECDC4?style=flat-square"/>
    </td>
    <td align="center">
      <a href="https://github.com/AbdelrahmanAyman1">
        <img src="https://github.com/AbdelrahmanAyman1.png" width="90" style="border-radius:50%"/><br/>
        <sub><b>Abdelrahman Ayman</b></sub>
      </a>
      <br/>
          <sub>🏆 Flutter Developer </sub>
      <br/>
      <br/>
      <img src="https://img.shields.io/badge/Contributor-4ECDC4?style=flat-square"/>
    </td>
    <td align="center">
      <a href="https://github.com/Abdo0Salah">
        <img src="https://github.com/Abdo0Salah.png" width="90" style="border-radius:50%"/><br/>
        <sub><b>Abdo Salah</b></sub>
      </a>
      <br/>
          <sub>🏆 Flutter Developer </sub>
      <br/>
      <br/>
      <img src="https://img.shields.io/badge/Contributor-4ECDC4?style=flat-square"/>
    </td>
    <td align="center">
      <a href="https://github.com/Mohamed-Ehab-Elsawy">
        <img src="https://github.com/Mohamed-Ehab-Elsawy.png" width="90" style="border-radius:50%"/><br/>
        <sub><b>Mohamed Ehab Elsawy</b></sub>
      </a>
      <br/>
          <sub>🏆 Flutter Developer </sub>
      <br/>
      <br/>
      <img src="https://img.shields.io/badge/Contributor-4ECDC4?style=flat-square"/>
    </td>
  </tr>
</table>
 
<br/>


## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

---

## 📄 License

This project is for educational/personal use. No license currently specified.
