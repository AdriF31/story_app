# 📖 Story App

## 🎯 Purpose

This application was developed as part of the **Dicoding course submission**, showcasing good software architecture practices and integrating modern mobile development workflows.

**Story App** is a mobile application built with **Flutter**, applying **Clean Architecture** and the **Separation of Concerns** principle. The project is structured into three main layers:

- **Domain Layer**: Contains entities, abstract repositories, and use cases.
- **Data Layer**: Manages repository implementations, local and remote data sources, and data model conversions.
- **Presentation Layer**: Handles the UI and state management using **BLoC**.

## ✨ Key Features

- **State Management**: Utilizes the **BLoC pattern** to ensure structured and scalable state control.
- **Code Generation**:
  - [`freezed`](https://pub.dev/packages/freezed) for immutable data classes and union types.
  - [`json_serializable`](https://pub.dev/packages/json_serializable) for JSON serialization and deserialization.
- **Dependency Injection**: Managed with [`get_it`](https://pub.dev/packages/get_it) for simple and effective service location.
- **CI/CD Integration**:
  - Automated build, test, and deployment process using **GitHub Actions**.
  - Application distribution via **Firebase App Distribution** after successful CI runs.

## 🚀 Technologies Used

- Flutter
- BLoC (State Management)
- Freezed & JSON Serializable (Code Generation)
- Get It (Dependency Injection)
- GitHub Actions (CI/CD)
- Firebase App Distribution

---
