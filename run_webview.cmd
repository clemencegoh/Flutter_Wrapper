@echo off
:: Helpful commands for running on Chrome

:: Upgrade to latest
:: flutter channel dev
:: flutter upgrade
:: flutter config --enable-web
:: cd <into project directory>
:: flutter create .

:: Run on Chrome, "R" to hot reload
flutter run -d chrome

:: Build app for web
:: flutter build web