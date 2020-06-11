# Activity Goals

Modular iOS app to track daily activity and progress towards goals.

## Getting Started

### Prerequisites

What things you need to install the software and how to install them

```
- Cocoapods
- Xcode 11
- iOS 11
```

### Installing

Just run

```
pod install
```
and that should be enough. 

### Running the tests

Each module has its own unit tests. Use Xcode `CMD+U` to run them.

## Architecture
  <img src="https://github.com/illuminati1911/activitygoals/blob/master/docs/architecture.png?raw=true" width="650">

### Modular architecture
The app is split into multiple modules
- Application
- Core
- Services
- Networking
- LocalStorage
- Pods

This is to follow _Separation of Concerns_ design principle, keep things reusable and loosely couple and also increase the build time and unit test execution time.

- All modules are dependent on the Core module (which is dependent on no other module) and Application module only depends on Core and Services modules.
- Services module will provide interface for using Networking and LocalStorage as needed
- Core module shares "global" assets such as localizations, domain models, utilities etc.
### MVVM + Coordinator
- MVVM to keep view controllers clean
- Coordinator to decouple navigation from view controllers

### RxSwift / RxCocoa
- Reactive functional pipelines for smooth async operations and app events

## Coding style

The application uses swiftlint with _almost_ default settings.
See `.swiftlint.yml` for more details.

## Authors

* [illuminati1911](https://github.com/illuminati1911)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
