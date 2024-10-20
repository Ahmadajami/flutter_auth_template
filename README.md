# Flutter Starter App with BLoC, Retrofit, and Go Router

A starter template for building Flutter applications utilizing BLoC for state management, Retrofit for API calls, Go Router for navigation, and GetIt for dependency injection. This project includes full authentication functionality and is designed to streamline your Flutter app development process.

## Features

- **State Management**: Utilizes BLoC (Business Logic Component) for efficient state management.
- **API Integration**: Uses Retrofit for making network calls with easy-to-use models and endpoints.
- **Routing**: Implements Go Router for smooth navigation and deep linking.
- **Dependency Injection**: Uses GetIt for managing dependencies throughout the application.
- **Authentication**: Full authentication support, including login and registration.
- **Splash Screen**: Integrates Flutter Native Splash for a beautiful splash screen experience.

## Packages Used

- **[flutter_bloc](https://pub.dev/packages/flutter_bloc)**: A package that helps implement the BLoC pattern, making it easier to manage state in Flutter applications.
- **[dio](https://pub.dev/packages/dio)**: A powerful HTTP client for Dart, used by Retrofit for making API calls.
- **[retrofit](https://pub.dev/packages/retrofit)**: A type-safe HTTP client for Dart, built on top of Dio, that allows you to create API clients using annotations.
- **[go_router](https://pub.dev/packages/go_router)**: A declarative routing package for Flutter that simplifies navigation and deep linking.
- **[get_it](https://pub.dev/packages/get_it)**: A service locator for Dart and Flutter that makes it easy to manage dependencies and implement dependency injection.
- **[flutter_native_splash](https://pub.dev/packages/flutter_native_splash)**: A package for creating a native splash screen for your Flutter app.

## Getting Started

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- An IDE (like [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio))

### Installation

1. Clone the repository:

   ```bash
   git clone git@github.com:Ahmadajami/flutter_auth_template.git

2. Navigate to the project directory:

   ```bash
   cd flutter_bloc_auth
   
3. Install dependencies
    ```bash
    flutter pub get
4. Run the App:
    ```bash
   flutter run

### Usage

- To add new dependencies, update the `pubspec.yaml` file.
- Implement your API calls in the service layer using Retrofit.
- Use BLoC classes to manage the state of your application.
- For navigation, define your routes in the Go Router configuration.
- Use GetIt to register and retrieve your services easily.


### License
This project is licensed under the MIT License - see the LICENSE file for details.

### Acknowledgments
Flutter - UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
GetIt - Service locator for Dart and Flutter.
Retrofit - Type-safe HTTP client for Dart.


### Contributing
Contributions are welcome! If you have suggestions for improvements or find any issues, feel free to create a pull request or open an issue.

