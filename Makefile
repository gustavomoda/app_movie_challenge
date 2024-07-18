.PHONY: setup-dev install clean build-runner-clean build-runner watch debug-app test

.setup-flutter: 
	@yes | fvm use

setup-dev: .setup-flutter clean install i10n-generate build-runner
	@echo "\nEverything is ready to run app! 🚀\n"

install: 
	@echo "Installing dependencies..."
	@fvm flutter pub get

clean: build-runner-clean
	@echo "Removing build generated files..."
	@fvm flutter clean

reset: clean install build-runner
	@echo "Reseted app! 🚀"

rebuild: build-runner-clean build-runner
	@echo "Rebuilded! 🚀"

build-runner-clean: 
	@echo "Running build runner..."
	@dart run build_runner clean

build-runner: 
	@echo "Running build runner..."
	@dart run build_runner build --delete-conflicting-outputs

i10n-generate: 
	@echo "Generating i10n files..."
	@fvm dart run intl_utils:generate

watch: 
	@echo "Running build runner in watch mode..."
	@dart run build_runner watch --delete-conflicting-outputs

debug-app:
ifeq ($(device),)
	@echo "To debug app in a specific device, run: make debug-app device=<device-id>"
	@echo "Available devices:"
	@fvm flutter devices
	exit 1
endif
	@echo "Debugging app..."
	@fvm flutter run --debug --device-id $(device)

test: 
	@echo "Running tests..."
	@fvm flutter test --coverage  

coverage: test
	make coverage_report

coverage_report:
	@echo "Generating coverage report..."
	@lcov --remove coverage/lcov.info \
		'**/i10n/**' \
		'lib/src/di/*' \
		'lib/src/features/developer/**'  \
		'lib/generated-code/*' \
		'**/generated/**' \
		'**/*.g.dart' \
		'**/*.freezed.dart' \
		'**/*.injectable.dart' \
		'lib/src/config/themes/tokens/**' \
		'lib/src/config/routes/**' \
		'lib/src/shared/exceptions/**' \
		'lib/src/**/entities/**' \
		-o coverage/coverage_with_exclusion.info --ignore-errors unused && \
	cat coverage/coverage_with_exclusion.info > coverage/lcov.info  &&\
	rm coverage/coverage_with_exclusion.info &&\
	genhtml coverage/lcov.info -o ./coverage &&\
	fvm flutter pub run test_cov_console --exclude='lib/generated/,i10n,lib/src/config/themes/tokens/,lib/src/di/,lib/src/config/routes/,entities' &&\
	echo "\n\n-------------------------\n\nReport generated, open file into navigator: coverage/index.html\n"


lint: 
	@echo "Running lint..."
	@fvm flutter analyze lib

format_code: 
	@echo "Formating code"
	@find lib test -name "*.dart" \
		! -path "lib/generated/*" \
		! -path "lib/**injector.config.dart" \
		! -path "lib/**injector.module.dart" \
		! -path "lib/generated/**" \
		! -path "lib/**.g.dart" \
		! -path "lib/**.freezed.dart" \
		! -path "lib/firebase_options.dart" | \
		xargs fvm dart format -l 100

local_ci: format_code lint test
	@echo "Local CI passed! 🚀"