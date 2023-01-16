# api_tempest

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which
offers tutorials, samples, guidance on mobile development, and a full API reference.

## Git hooks

### Git pre hook

Before commiting the code, a pre hook is run to ensure that the doesn't contain any error. It also updates the version
number in the pubspec.yaml file.

To install the git pre hook, run the following command:

```bash
chmod +x scripts/\*.sh && ./scripts/install-hooks.sh
```

Sometimes, you may want to skip the pre hook. avoid using the prehook: `git commit -m "test commit" --no-verify`
