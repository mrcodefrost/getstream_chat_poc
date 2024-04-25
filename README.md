# Chat POC V2

A Stream chat integration in Flutter app proof of 
concept based on stream_chat_flutter package by Stream.

### Platforms

- Android
- iOS

### Technologies Used

- Flutter
- Firebase
- Stream Chat API (stream_chat_flutter)


### Installation

1. Clone the repository to your local machine:

  ```bash
   git clone https://github.com/mrcodefrost/chat_poc_one.git
  ```

2. Navigate to the project directory:

  ```bash
   cd chat_poc_one
  ```

3. Install dependencies by running this command in IDE terminal:

  ```bash
    flutter pub get
  ```

4. Set up Firebase:

If you haven't already, [sign in to your Firebase account](https://firebase.google.com/docs/web/setup).
Install Firebase CLI globally using IDE Terminal:

Log in to Firebase
  ```bash
   firebase login
  ```

Activate Flutterfire CLI
  ```bash
   flutter pub global activate flutterfire_cli
  ```

5. Set up Stream

[Sign in to your free stream account](https://getstream.io/try-for-free/).

- Create a project in developer dashboard and set to development mode
- Get access to API key and Secret key
- Each token is unique to the user id, a token generator on the following link will require secret key and user id
- [Generate unique user tokens](https://getstream.io/chat/docs/flutter-dart/tokens_and_authentication/?language=dart)



### Configuration

These steps may be required in case of errors

1. Set dependency versions of following in pubspec.yaml

    ```yaml
     stream_chat_flutter: 7.2.0-hotfix.1
     connectivity_plus: 5.0.2
    ```


2. Upgrade kotlin version in android/settings.gradle to min 1.9.0

    ```groovy
     plugins {
     id "org.jetbrains.kotlin.android" version "1.9.0" apply false
     }
    ```

3. Enable multidex support in android by running the command

    ```bash
     flutter run
    ```



### Additional

Basic Docs
https://getstream.io/chat/docs/flutter-dart/?language=dart

Stream Flutter Chat Docs
https://getstream.io/chat/docs/sdk/flutter/stream_chat_flutter/stream_chat_and_theming/

Stream Flutter Chat Core Docs
https://getstream.io/chat/docs/sdk/flutter/stream_chat_flutter_core/stream_channel_list_controller/

Stream Token Generation Docs
https://getstream.io/chat/docs/sdk/flutter/guides/token_generation_with_firebase/


========CURRENT USERS============

Name : ID

1) Gordon : 123123
2) Hunny: 321321