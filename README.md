# NY Times Most Popular Articles

A Swift iOS application that displays the most popular articles from the New York Times API.

## Features

- Browse articles in a list and view detailed information
- Pull-to-refresh functionality
- Integration with NY Times Most Popular Articles API
- Modern UI built with Auto Layout

## Architecture

This project follows **SOLID principles** and implements **Dependency Injection**:

### SOLID Principles

1. **Single Responsibility**: Each class has one clear purpose
2. **Open/Closed**: Extensible through protocols without modification
3. **Liskov Substitution**: Protocols ensure substitutability
4. **Interface Segregation**: Focused, minimal interfaces
5. **Dependency Inversion**: High-level modules depend on abstractions

### Dependency Injection

- **Constructor Injection**: Dependencies injected through initializers
- **Protocol Abstraction**: Services depend on interfaces, not implementations
- **Dependency Container**: Centralized service management
- **Testability**: Easy to inject mocks for testing

## Project Structure

```
NY Times Most Popular Articles/
├── Info.plist                          # App configuration
├── Sources/                            # Main source code
│   ├── App/
│   │   ├── AppDelegate.swift           # App lifecycle management
│   │   ├── SceneDelegate.swift         # Scene lifecycle management
│   │   ├── DependencyContainer.swift   # Dependency injection container
│   │   ├── NavigationCoordinator.swift # Navigation coordination
│   │   └── DateFormatterUtility.swift  # Shared date formatting utilities
│   ├── Features/
│   │   └── Articles/
│   │       ├── Controllers/
│   │       │   ├── ArticlesViewController.swift # Main articles list view
│   │       │   └── ArticleDetailViewController.swift # Article detail view
│   │       ├── ViewModels/
│   │       │   └── ArticlesViewModel.swift # Business logic and state management
│   │       ├── Views/
│   │       │   └── ArticleTableViewCell.swift # Article list cell
│   │       └── Models/
│   │           └── Article.swift       # Data models for API responses
│   ├── Networking/
│   │   ├── NetworkService.swift        # Network layer with protocol abstraction
│   │   ├── APIConfig.swift            # API configuration and URL generation
│   │   └── ArticlesRepository.swift   # Data access layer (Repository pattern)
│   └── Resources/
│       ├── Assets.xcassets/           # App icons and images
│       └── Base.lproj/                # Localization and storyboards
├── NY Times Most Popular ArticlesTests/ # Test target
│   ├── ArticlesViewModelTests.swift   # ViewModel unit tests
│   └── ArticleTests.swift             # Model unit tests
└── NY Times Most Popular Articles.xcodeproj/
```

### Architecture Layers

- **App Layer**: App lifecycle, DI container, navigation, and utilities
- **Features Layer**: Feature-based organization with Controllers, ViewModels, Views, and Models
- **Networking Layer**: Network communication, API configuration, and data access
- **Resources Layer**: Assets, localization, and configuration files
- **Tests Layer**: Unit tests for business logic and models

## Testing

The project includes unit tests that demonstrate fundamental testing concepts:
- **ArticlesViewModelTests**: Basic property and method testing
- **ArticleTests**: Basic model property validation

## Requirements

- iOS 18.0+
- Xcode 16.0+
- Swift 5.0+

## Getting Started

1. Clone the repository
2. Open `NY Times Most Popular Articles.xcodeproj` in Xcode
3. Build and run the project

## Dependencies

- Foundation framework
- UIKit framework
- SafariServices framework
- NY Times API
