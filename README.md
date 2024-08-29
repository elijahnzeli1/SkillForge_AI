# SkillForge AI

SkillForge AI is a Flutter-based mobile application that provides an AI-powered learning experience. Users can select courses, interact with AI for learning assistance, track their progress, and connect with other learners.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed the latest version of [Flutter](https://flutter.dev/docs/get-started/install) (2.0 or later)
- You have a Windows/Linux/Mac machine with Android Studio or Xcode installed for running mobile emulators
- You have an OpenAI API key (for AI-powered features)

## Setting up SkillForge AI

To set up SkillForge AI, follow these steps:

1. Clone the repository:

   git clone <https://github.com/elijahnzeli1/skillforge_ai.git>

2. Navigate to the project directory:

   cd skillforge_ai

3. Install dependencies:

   flutter pub get

4. Set up your OpenAI API key:
   - Open `lib/utils/constants.dart`
   - Replace `'your-api-key-here'` with your actual OpenAI API key:

     const String OPENAI_API_KEY = 'your-actual-api-key';

5. (Optional) Configure Firebase for authentication and cloud storage:
   - Create a new Firebase project
   - Add your Android and iOS apps to the Firebase project
   - Download and add the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) to the respective directories
   - Follow Firebase setup instructions for Flutter: [FlutterFire](https://firebase.flutter.dev/docs/overview)

## Running SkillForge AI

To run SkillForge AI, follow these steps:

1. Open an emulator (Android) or simulator (iOS)

2. Run the app:

   flutter run

For running on a physical device, ensure USB debugging is enabled and run:

flutter run

## Testing SkillForge AI

To run the tests for SkillForge AI, follow these steps:

1. Run the tests:

   flutter test

2. For integration tests:

   flutter drive --target=test_driver/app.dart

## Contributing to SkillForge AI

To contribute to SkillForge AI, follow these steps:

1. Fork this repository
2. Create a branch: `git checkout -b <branch_name>`
3. Make your changes and commit them: `git commit -m '<commit_message>'`
4. Push to the original branch: `git push origin <project_name>/<location>`
5. Create the pull request

Alternatively, see the GitHub documentation on [creating a pull request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).

## Contact

If you want to contact the maintainer, you can reach out at <elijahnzeli894@gmail.com>.

## License

This project uses the following license: [MIT License](https://opensource.org/licenses/MIT).
