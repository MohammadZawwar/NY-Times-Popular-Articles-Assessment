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
├── Configuration/
│   ├── APIConfig.swift          # API configuration
│   ├── DependencyContainer.swift # Dependency injection container
│   └── DateFormatterUtility.swift # Shared date formatting utilities
├── Models/
│   └── Article.swift            # Data models
├── Services/
│   └── NetworkService.swift     # Network layer
├── ViewModels/
│   └── ArticlesViewModel.swift  # Business logic
├── Views/
│   ├── ArticleTableViewCell.swift
│   └── ArticleDetailViewController.swift
└── ViewController.swift         # Main view controller
```

## Testing

The project includes unit tests that demonstrate fundamental testing concepts:
- **ArticlesViewModelTests**: Basic property and method testing
- **ArticleTests**: Basic model property validation

## Requirements

  - Xcode 16
  - Swift 5

## Getting Started

1. Clone the repository
2. Open `NY Times Most Popular Articles.xcodeproj` in Xcode
3. Build and run the project

## Dependencies

- Foundation framework
- UIKit framework
- SafariServices framework
- NY Times API
