{ pkgs, ... }: {
  # Add the Flutter SDK, Dart, and other tools to the environment.
  packages = [
    pkgs.flutter
    pkgs.dart
    pkgs.cmake
  ];

  # Enable Flutter support in the IDE by adding the VS Code extension.
  idx.extensions = [
    "dart-code.flutter"
  ];

  # Enable the preview server.
  idx.previews.enable = true;

  # Automatically run `flutter pub get` when the workspace is created.
  idx.workspace.onCreate = {
    "flutter-get" = "flutter pub get";
  };

  # Run the Flutter app on port 8080 when the workspace starts.
  idx.workspace.onStart = {
    "run-flutter" = "flutter run -d web-server --web-port 8080";
  };
}
