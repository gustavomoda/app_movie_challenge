# app_movie_challenge

An application showcasing the nominees and winners of the Worst Picture category in the Golden Raspberry Awards.

### Project Status

- Currently in development.
- Not yet ready for production.
- Not suitable for use at this stage.

---

# Architecture

The project is structured using Clean Architecture, organized into several layers:

- **Data**: Contains data sources and repositories.
- **Domain**: Comprises use cases and entities.
- **Presentation**: Encompasses the UI and business logic.

Adopting a package-feature approach, the project is segmented into the following packages:

- **configs**: Holds the app's configurations and routes.
- **shared**: Includes shared components of the app.
- **main**: Contains the core code of the app.
- **features**: Houses the app's features, with each feature as a distinct package adhering to Clean Architecture principles.

## Core Packages

- **Flutter Bloc**: Utilized for state management.
- **Provider**: Utilized for simplified state management and resource allocation.
- **get_it** and **injectable**: Used for dependency injection.
- **dio**: Facilitates HTTP requests.
- **freezed** and **freezed_annotation**: Aids in code generation for entities, models, and DTOs.
- **json_serializable** and **json_annotation**: Provides JSON serialization capabilities.
- **build_runner**: A tool for code generation, supporting both freezed and json_serializable packages.
- **intl** and **intl_utils**: Supports internationalization.

## Getting Started

Follow these instructions to set up the project locally for development and testing.

### Prerequisites

- [Makefile](https://www.gnu.org/software/make/manual/make.html): For executing Makefile commands.
- [FVM](https://fvm.app): Manages Flutter versions.
- Android Studio: For running the app on an emulator or physical device.
- Xcode: For running the app on an iOS emulator or physical device.


## Installing prerequisites

### 1. Makefile:


#### MacOS
MacOS users can install Makefile using Homebrew:
```bash
brew install make
```


####  Windows
Windows users have the option to install Makefile via Chocolatey for convenience:
```bash
choco install make
```

> You can install Makefile without Chocolatey, but I recommend using Chocolatey because it is easier to install and manage packages on Windows.

> You can install Chocolatey by following the instructions on the [official website](https://chocolatey.org/install).


### Linux systems
Linux users can install Makefile using the package manager of their distribution. 

For example, for Debian-based distributions, you can use the following command:

```bash
sudo apt-get install make
```

### 2. FVM

You can install FVM by following the instructions on the [official website](https://fvm.app).


### 3. Android Studio

You can install Android Studio by following the instructions on the [official website](https://developer.android.com/studio).


### 4. Xcode

You can install Xcode by following the instructions on the [official website](https://developer.apple.com/xcode/).

## Running the App

There are three ways to run the app: using the Makefile, running the commands manually, or running it from Visual Studio Code or Android Studio IDE.

### Running the App Using the Makefile

1. Set up the development environment: `make setup-dev`
2. Debug the app on an emulator or a physical device using: `make debug-app`
    > To run the app on a physical device, enable USB debugging on your device and connect it to your computer.
    > Once the device is connected, use the command `make debug-app` to list the devices connected to your computer.
    > Run the app on the selected device with `make debug-app DEVICE=<device_id>`, where `<device_id>` is identified by either `make debug-app` or `fvm flutter devices`.
3. Run tests: `make test`

### Running the App Manually

1. Set up Flutter FVM: `yes | fvm use install`.
2. Install packages: `fvm flutter pub get`
3. Update the dependencies: `fvm flutter pub get`
4. Generate the internationalization files: `fvm flutter pub run intl_utils:generate`
5. Run build runner: `fvm flutter pub run build_runner build` or `fvm flutter pub run build_runner watch`
6. Run the app: `fvm flutter run`

### Running the App from Visual Studio Code or Android Studio IDE

1. Open the project in Visual Studio Code or Android Studio IDE.
2. Run build runner: `fvm flutter pub run build_runner build` or `fvm flutter pub run build_runner watch`
3. Run the app in the IDE.

### Makefile Goals

Below are the goals available in the Makefile:

- `setup-dev`: Set up the development environment.
- `install`: Install the dependencies.
- `build-runner`: Run the build runner.
- `watch`: Run the build runner in watch mode.
- `debug-app`: Run the app on an emulator or physical device.
- `test`: Run the tests.
- `lint`: Run the linter.
- `format_code`: Run the code formatter.
- `i10n-generate`: Generate the internationalization files.
- `local_ci`: Execute lint, format_code, and test.
- `rebuild`: Rebuild the project. Executes clean, install, and build-runner.
- `clean`: Clean the project.
### Author
- Luis Gustavo Moda: gustavo.moda@gmail.com

