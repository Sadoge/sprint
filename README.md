# Sprint

Sprint is a minimalist Flutter focus timer for short, repeatable work sessions. It keeps the experience intentionally small: start a sprint, finish it, and track your consistency over time.

## Features

- Single-tap focus timer with a clean countdown UI
- Adjustable sprint duration
- Local sprint history stored on device
- Current streak and total sprint stats
- 30-day activity heatmap
- Optional completion sound
- Reset controls for clearing history and streak data

## Built With

- Flutter
- Riverpod and `riverpod_generator`
- GoRouter
- Drift with SQLite
- Freezed
- Audioplayers

## Project Structure

- `lib/presentation` contains the timer, history, and settings screens
- `lib/data` contains Drift database setup, DAOs, and repository implementations
- `lib/domain` contains models and repository contracts
- `lib/core` contains routing, design system tokens, and shared utilities

## Getting Started

```bash
flutter pub get
flutter run
```

## Current App Flow

- `Timer`: run a sprint, stop it early, and see today’s completed count
- `History`: review the last 30 days, streak, active days, and total sprints
- `Settings`: change sprint duration, toggle completion sound, or reset local data

## Notes

- Sprint stores data locally and does not require an account
- The app is currently configured as a portrait experience
